defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  alias KV.Registry
  alias KV.Bucket

  setup do
    registry = start_supervised!(Registry)
    %{registry: registry}
  end

  test "creates and recovers a bucket by name", %{registry: registry} do
    Registry.create(registry, "shopping")

    {:ok, bk} = Registry.lookup(registry, "shopping")
    Bucket.put(bk, "milk", 3)

    assert Bucket.get(bk, "milk") == 3
  end

  test "removes buckets on exit", %{registry: registry} do
    Registry.create(registry, "shopping")
    {:ok, bucket} = Registry.lookup(registry, "shopping")

    Agent.stop(bucket)

    assert Registry.lookup(registry, "shopping") == :error
  end
end
