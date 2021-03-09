defmodule MarsRover.PositionTest do
  use ExUnit.Case

  alias MarsRover.Position

  test "new with right position should returns the right position" do
    {:ok, %Position{} = position} = Position.new(1, 2)
    assert position.x == 1
    assert position.y == 2
  end

  test "new with negative x should returns error" do
    {error, message} = Position.new(-1, 0)
    assert error == :error
    assert message == :wrong_coordinates
  end

  test "new with out of bound x should returns error" do
    {error, message} = Position.new(7, 0)
    assert error == :error
    assert message == :wrong_coordinates
  end

  test "new with negative y should returns error" do
    {error, message} = Position.new(0, -1)
    assert error == :error
    assert message == :wrong_coordinates
  end

  test "new with out of bound y should returns error" do
    {error, message} = Position.new(0, 7)
    assert error == :error
    assert message == :wrong_coordinates
  end

  test "update x by 1 when x is into range should increment x" do
    {:ok, position} = Position.new(0, 0)
    {:ok, %Position{} = new_position} = Position.update(position, 1, 0)
    assert new_position.x == 1
    assert new_position.y == 0
  end

  test "update x by -1 when x is into range should decrement x" do
    {:ok, position} = Position.new(2, 0)
    {:ok, %Position{} = new_position} = Position.update(position, -1, 0)
    assert new_position.x == 1
    assert new_position.y == 0
  end

  test "update x by 1 when x is not into range should set x to maximum value" do
    {:ok, position} = Position.new(6, 0)
    {:ok, %Position{} = new_position} = Position.update(position, 1, 0)
    assert new_position.x == 6
    assert new_position.y == 0
  end

  test "update x by -1 when x is not into range should set x to 0" do
    {:ok, position} = Position.new(0, 0)
    {:ok, %Position{} = new_position} = Position.update(position, -1, 0)
    assert new_position.x == 0
    assert new_position.y == 0
  end

  test "update y by 1 when y is into range should increment y" do
    {:ok, position} = Position.new(0, 0)
    {:ok, %Position{} = new_position} = Position.update(position, 0, 1)
    assert new_position.x == 0
    assert new_position.y == 1
  end

  test "update y by -1 when y is into range should decrement y" do
    {:ok, position} = Position.new(0, 2)
    {:ok, %Position{} = new_position} = Position.update(position, 0, -1)
    assert new_position.x == 0
    assert new_position.y == 1
  end

  test "update y by 1 when y is not into range should set y to maximum value" do
    {:ok, position} = Position.new(0, 6)
    {:ok, %Position{} = new_position} = Position.update(position, 0, 1)
    assert new_position.x == 0
    assert new_position.y == 6
  end

  test "update y by -1 when y is not into range should set y to 0" do
    {:ok, position} = Position.new(0, 0)
    {:ok, %Position{} = new_position} = Position.update(position, 0, -1)
    assert new_position.x == 0
    assert new_position.y == 0
  end
end
