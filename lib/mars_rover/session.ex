defmodule MarsRover.Session do
  @moduledoc false

  alias MarsRover.{Rover, Position}

  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, {}, [])

  def init(_) do
    x = Enum.random(0..6)
    y = Enum.random(0..6)
    {:ok, position} = Position.new(x, y)
    {:ok, rover} = Rover.new(position)
    {:ok, %{rover: rover}}
  end

  def move_up_rover(session) do
    GenServer.call(session, {:rover, :move_up})
  end

  def move_down_rover(session) do
    GenServer.call(session, {:rover, :move_down})
  end

  def move_left_rover(session) do
    GenServer.call(session, {:rover, :move_left})
  end

  def move_right_rover(session) do
    GenServer.call(session, {:rover, :move_right})
  end

  def handle_call({:rover, command}, _from, state_data) do
    state_data
    |> send_command_to_rover(command)
    |> reply_success()
  end

  defp send_command_to_rover(state_data, command) do
    {:ok, %Rover{} = rover} =
      state_data.rover
      |> Rover.execute(command)

    put_in(state_data.rover, rover)
  end

  defp reply_success(state_data),
    do: {:reply, {:ok, %{new_rover_position: state_data.rover.position}}, state_data}
end
