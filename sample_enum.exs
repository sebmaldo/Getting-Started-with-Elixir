defmodule Sample.Enum do

    def first(list, val \\ nil)
    def first([head, _], val), do: head
    def first([], val), do: val

    def add(list, val \\ 0) do
        trace(string)
        [val | list]
    end

    defp trace(string) do
        IO.puts("El valor entregado es #{string}")
    end
end