defmodule SurrogateTest do
  use ExUnit.Case

  test "subscribe/1 links to a topic" do
    {:ok, _pid} = Surrogate.start_link

    :ok = Surrogate.subscribe("topic.1")
    :ok = Surrogate.subscribe("topic.2")

    {:ok, other_conn} = Redix.start_link
    {:ok, _} = Redix.command(other_conn, ~w(PUBLISH topic.1 hello))
    {:ok, _} = Redix.command(other_conn, ~w(PUBLISH topic.2 world))

    assert_receive "hello"
    assert_receive "world"
  end

  test "unsubscribe/1 unlinks a topic" do
    {:ok, _pid} = Surrogate.start_link

    :ok = Surrogate.subscribe("topic.1")
    :ok = Surrogate.unsubscribe("topic.1")

    {:ok, other_conn} = Redix.start_link
    {:ok, _} = Redix.command(other_conn, ~w(PUBLISH topic.1 hello))

    refute_receive "hello"
  end
end
