defmodule MarsRover.RoverTest do
  use ExUnit.Case

  alias MarsRover.{Position, Rover}

  test "new without specify position should return new rover positioned at (0, 0)" do
    {:ok, %Rover{position: position}} = Rover.new()
    assert position.x == 0
    assert position.y == 0
  end

  test "new with position should return new rover positioned at that position" do
    {:ok, start_position} = Position.new(1, 2)
    {:ok, %Rover{position: position}} = Rover.new(start_position)
    assert position.x == 1
    assert position.y == 2
  end

  test "execute move_up command when the position is into range should increment y position" do
    {:ok, rover} = Rover.new()
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_up)
    assert position.x == 0
    assert position.y == 1
  end

  test "execute move_up command when the position is not into range should return the same y position" do
    {:ok, start_position} = Position.new(0, 6)
    {:ok, rover} = Rover.new(start_position)
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_up)
    assert position.x == 0
    assert position.y == 6
  end

  test "execute move_down command when the position is into range should decrement y position" do
    {:ok, start_position} = Position.new(0, 3)
    {:ok, rover} = Rover.new(start_position)
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_down)
    assert position.x == 0
    assert position.y == 2
  end

  test "execute move_down command when the position is not into range should return the same y position" do
    {:ok, start_position} = Position.new(0, 0)
    {:ok, rover} = Rover.new(start_position)
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_down)
    assert position.x == 0
    assert position.y == 0
  end

  test "execute move_right command when the position is into range should increment y position" do
    {:ok, rover} = Rover.new()
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_right)
    assert position.x == 1
    assert position.y == 0
  end

  test "execute move_right command when the position is not into range should return the same x position" do
    {:ok, start_position} = Position.new(6, 0)
    {:ok, rover} = Rover.new(start_position)
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_right)
    assert position.x == 6
    assert position.y == 0
  end

  test "execute move_left command when the position is into range should increment y position" do
    {:ok, start_position} = Position.new(3, 0)
    {:ok, rover} = Rover.new(start_position)
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_left)
    assert position.x == 2
    assert position.y == 0
  end

  test "execute move_left command when the position is not into range should return the same x position" do
    {:ok, start_position} = Position.new(0, 0)
    {:ok, rover} = Rover.new(start_position)
    {:ok, %Rover{position: position}} = Rover.execute(rover, :move_left)
    assert position.x == 0
    assert position.y == 0
  end
end
