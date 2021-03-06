defmodule Commands.MatrixCommands do
    
    def left_diagonal(matrix), do: left_diagonal(matrix, 0, [])
    def left_diagonal(matrix, index, parsed_diagonal) do
        case matrix |> Stream.take(1) |> Enum.to_list |> List.first do
            nil -> parsed_diagonal
            row -> 
                case row |> Stream.drop(index) |> Stream.take(1) |> Enum.to_list |> List.first do
                    nil -> parsed_diagonal
                    element -> left_diagonal(matrix |> Stream.drop(1), index + 1, parsed_diagonal ++ [element])
                end
        end
    end

    def right_diagonal(matrix), do: left_diagonal(matrix |> Stream.map(fn x -> x |> Enum.reverse end))
    
    def upper_triangular_matrix(matrix), do: upper_triangular_matrix(matrix, 0, [])
    def upper_triangular_matrix(matrix, index, parsed_matrix) do
        case matrix |> Stream.take(1) |> Enum.to_list |> List.first do
            nil -> parsed_matrix
            row ->
                case row |> Stream.drop(index) |> Enum.to_list do
                    [] -> parsed_matrix
                    curr_element -> upper_triangular_matrix(matrix |> Stream.drop(1), index + 1, parsed_matrix ++ [curr_element])
                end
        end
    end
    def lower_triangular_matrix(matrix), do: upper_triangular_matrix(matrix |> Stream.map(fn x -> x |> Enum.reverse end) |> Enum.reverse) |> Enum.reverse |> Stream.map(&Enum.reverse/1)

    def columns_of(matrix) do
        Stream.unfold(matrix, fn
            [] -> nil
            matrix ->
                heads = matrix |> Stream.map(fn x -> x |> Stream.take(1) |> Enum.to_list |> List.first end) |> Stream.filter(fn x -> x != nil end)
                case heads |> Stream.take(1) |> Enum.to_list do
                    [] -> nil
                    _ -> {heads, matrix |> Stream.map(fn x -> x |> Stream.drop(1) end)}
                end
            end) |> Stream.map(fn x -> x end)
    end
end