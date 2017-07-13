defmodule Lemma do
  use GenFST

  @moduledoc """
  Documentation for Lemma.
  """
  rule ["play", {"s", "^s"}]
  rule ["act", {"s", "^s"}]
end
