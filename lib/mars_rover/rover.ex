defmodule MarsRover.Rover do
  @moduledoc false

  alias MarsRover.{Position, Rover}

  @enforce_keys [:position]
  defstruct [:position]

  @types [:move_up, :move_down, :move_left, :move_right]

  def new do
    {:ok, position} = Position.new(0, 0)
    {:ok, %Rover{position: position}}
  end

  def new(%Position{} = position), do: {:ok, %Rover{position: position}}

  def execute(%Rover{position: position}, :move_up) do
    move(position, 0, 1)
  end

  def execute(%Rover{position: position}, :move_down) do
    move(position, 0, -1)
  end

  def execute(%Rover{position: position}, :move_right) do
    move(position, 1, 0)
  end

  def execute(%Rover{position: position}, :move_left) do
    move(position, -1, 0)
  end

  def execute(_, command) when command not in @types, do: {:error, :bad_command}

  defp move(%Position{} = position, x_offset, y_offset) do
    {:ok, new_position} = Position.update(position, x_offset, y_offset)
    new(new_position)
  end
end
