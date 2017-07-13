defmodule GenFST do
  defmacro __using__(_opts) do
    quote do 
      import GenFST

      @rules []

      @before_compile GenFST

      def start_link() do
        GenStateMachine.start_link(__MODULE__, {:root, ""})
      end

      def read(pid, alphabets) do
        transduced = for a <- String.codepoints(alphabets) do
          GenStateMachine.call(pid, {:read, a})
        end
        List.last transduced
      end

      def get_output(pid) do
        GenStateMachine.call(pid, :get_output)
      end
    end
  end

  defmacro rule(r) do
    quote do 
      @rules [unquote(r) | @rules]
    end
  end

  def process_rule(fst_graph, rule) do
    {fst_graph, _, _} =  Enum.reduce(rule, {fst_graph, :root, ""}, fn(rule_item, {fst_graph, vertex, prefix}) ->
      process_rule_item(fst_graph, vertex, prefix, rule_item)
    end)
    fst_graph
  end

  def process_rule_item(fst_graph, vertex, prefix, rule_item) do
    # IO.puts "=============="
    # IO.inspect vertex
    # IO.inspect prefix
    # IO.inspect rule_item
    # IO.inspect fst_graph
    # IO.puts "-------------"
    if is_binary rule_item do
      Enum.reduce(String.codepoints(rule_item), {fst_graph, vertex, prefix}, fn(char, {fst_graph, vertex, prefix}) -> 
        process_rule_item_char(fst_graph, vertex, prefix, {char, char})
      end)
    else
      {from, to} = rule_item
      new_prefix = prefix <> from
      target_v = String.to_atom(new_prefix)
      edge = Graph.Edge.new(vertex, target_v, label: {from, to})
      fst_graph = fst_graph
      |> Graph.add_edge(edge)
      {fst_graph, target_v, new_prefix}
    end
  end

  def process_rule_item_char(fst_graph, vertex, prefix, {from, to}) do
    new_prefix = prefix <> from
    target_v = String.to_atom(new_prefix)
    edge = Graph.Edge.new(vertex, target_v, label: {from, to})
    fst_graph = fst_graph
    |> Graph.add_edge(edge)
    {fst_graph, target_v, new_prefix}
  end

  # Invoked right before target module compiled, used to inject
  # GenStateMachine event handlers.
  @doc false
  defmacro __before_compile__(_env) do
    quote do
      use GenStateMachine

      @fst_graph Enum.reduce(@rules, Graph.new(), fn(rule, fst_graph) -> 
        IO.puts "Processing rule: #{inspect rule}"
        fst_graph |> process_rule(rule)
      end)
      IO.inspect(@fst_graph)

      def handle_event({:call, from}, {:read, alphabet}, state, transduced) do
        edge = Enum.find(Graph.out_edges(@fst_graph, state), nil, fn(edge) -> 
          {e_from, e_to} = edge.label
          e_from == alphabet
        end)

        transduced = transduced <> elem(edge.label, 1)
        {:next_state, edge.v2, transduced, [{:reply, from, transduced}]}
      end

      def handle_event({:call, from}, :get_output, state, transduced) do
        {:next_state, state, transduced, [{:reply, from, transduced}]}
      end

      def handle_event(event_type, event_content, state, transduced) do
        # Call the implementation from GenStateMachine for everything else
        super(event_type, event_content, state, transduced)
      end
    end
  end
end