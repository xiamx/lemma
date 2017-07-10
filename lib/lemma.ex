defmodule Lemma do
  use GenFST

  @moduledoc """
  Documentation for Lemma.
  """

  @doc """
  Hello world.
  """

  # Client

  def start_link() do
    GenStateMachine.start_link(Lemma, {:s, ""})
  end

  # Server (callbacks)

  def handle_event(:cast, {:read, "p"}, :s, transduced) do
    {:next_state, :s0, transduced <> "p"}
  end

  def handle_event(:cast, {:read, "l"}, :s0, transduced) do
    {:next_state, :s1, transduced <> "l"}
  end

  def handle_event(:cast, {:read, "a"}, :s1, transduced) do
    {:next_state, :s2, transduced <> "a"}
  end

  def handle_event(:cast, {:read, "y"}, :s2, transduced) do
    {:next_state, :s3, transduced <> "y"}
  end

  def handle_event(:cast, {:read, "s"}, :s3, transduced) do
    {:next_state, :s4, transduced <> "^s"}
  end

  def handle_event({:call, from}, :get_output, state, transduced) do
    {:next_state, state, transduced, [{:reply, from, transduced}]}
  end

  def handle_event(event_type, event_content, state, transduced) do
    # Call the implementation from GenStateMachine for everything else
    super(event_type, event_content, state, transduced)
  end

end
