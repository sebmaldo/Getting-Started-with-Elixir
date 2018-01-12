defmodule Sample.Enum do
    def first([]), do: nil
    def first([head | _ ]), do: head
end