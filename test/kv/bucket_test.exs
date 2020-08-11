defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  alias KV.Bucket

  setup do
    bucket = start_supervised!(Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    Bucket.put(bucket, "milk", 3)

    assert Bucket.get(bucket, "milk") == 3
    assert Bucket.get(bucket, "bread") == nil
  end

  test "Deletes a keys", %{bucket: bucket} do
    Bucket.put(bucket, "milk", 3)
    deleted_value = Bucket.delete(bucket, "milk")

    assert Bucket.get(bucket, "milk") == nil
    assert deleted_value == 3
  end
end
