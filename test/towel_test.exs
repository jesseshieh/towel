defmodule TowelTest do
  use ExUnit.Case
  use Towel

  describe "Otherwise for Tuple" do
    test "with an error" do
      result =
        error(:invalid)
        |> bind(fn x -> ok(x) end)
        |> bind(fn x -> "Ok: #{x}" end)
        |> otherwise(fn e -> "Sorry, there was a problem." end)

      assert result == "Sorry, there was a problem."
    end

    test "with an ok" do
      result =
        ok(:valid)
        |> bind(fn x -> ok(x) end)
        |> bind(fn x -> "Ok: #{x}" end)
        |> otherwise(fn e -> "Sorry, there was a problem." end)

      assert result == "Ok: valid"
    end


    test "error without Otherwise" do
      result =
        error(:invalid)
        |> bind(fn x -> ok(x) end)
        |> case do
          {:ok, x} -> "Ok: #{x}"
          {:error, e} -> "Sorry, there was a problem."
        end

      assert result == "Sorry, there was a problem."
    end

    test "ok without Otherwise" do
      result =
        ok(:valid)
        |> bind(fn x -> ok(x) end)
        |> case do
          {:ok, x} -> "Ok: #{x}"
          {:error, e} -> "Sorry, there was a problem."
        end

      assert result == "Ok: valid"
    end
  end

  describe "Monad for List" do
    test "bind" do
      result =
        [1, 2, 3]
        |> bind(fn i -> [i * 2] end)

      assert result == [2, 4, 6]
    end
  end
end
