defmodule MarsRover.Position do
  @moduledoc false

  alias __MODULE__

  @enforce_keys [:x, :y]
  defstruct [:x, :y]

  @min_position 0
  @max_position 6
  def new(x, y) when x <= @max_position and x >= 0 and y <= @max_position and y >= 0,
    do: {:ok, %Position{x: x, y: y}}

  def new(_x, _y), do: {:error, :wrong_coordinates}

  def update(%Position{x: x, y: y}, x_offset, y_offset) do
    x =
      cond do
        x + x_offset > @max_position -> @max_position
        x + x_offset < @min_position -> @min_position
        true -> x + x_offset
      end

    y =
      cond do
        y + y_offset > @max_position -> @max_position
        y + y_offset < @min_position -> @min_position
        true -> y + y_offset
      end

    {:ok, %Position{x: x, y: y}}
  end
end
