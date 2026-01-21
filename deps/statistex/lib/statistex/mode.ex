defmodule Statistex.Mode do
  @moduledoc false

  import Statistex

  @spec mode(Statistex.samples(), keyword) :: Statistex.mode()
  def mode([], _) do
    raise(
      ArgumentError,
      "Passed an empty list ([]) to calculate statistics from, please pass a list containing at least on number."
    )
  end

  def mode(samples, opts) do
    frequencies =
      Keyword.get_lazy(opts, :frequency_distribution, fn -> frequency_distribution(samples) end)

    frequencies
    |> max_multiple()
    |> decide_mode()
  end

  defp max_multiple(map) do
    max_multiple(Enum.to_list(map), [{nil, 0}])
  end

  defp max_multiple([{sample, count} | rest], ref = [{_, max_count} | _]) do
    new_ref =
      cond do
        count < max_count -> ref
        count == max_count -> [{sample, count} | ref]
        true -> [{sample, count}]
      end

    max_multiple(rest, new_ref)
  end

  defp max_multiple([], ref) do
    ref
  end

  defp decide_mode([{nil, _}]), do: nil
  defp decide_mode([{_, 1} | _rest]), do: nil
  defp decide_mode([{sample, _count}]), do: sample

  defp decide_mode(multi_modes) do
    Enum.map(multi_modes, fn {sample, _} -> sample end)
  end
end
