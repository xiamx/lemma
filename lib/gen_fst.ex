defmodule GenFST do
  defmacro __using__(_opts) do
    quote do 
      use GenStateMachine

      def read(pid, alphabets) do
        for a <- String.codepoints(alphabets) do
          GenStateMachine.cast(pid, {:read, a})
        end
      end

      def get_output(pid) do
        GenStateMachine.call(pid, :get_output)
      end

    end
  end
end