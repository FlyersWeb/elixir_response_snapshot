defmodule ResponseSnapshot.FileManagerTest do
  use ExUnit.Case, async: true
  alias ResponseSnapshot.FileManager

  describe "write_fixture/2" do
    test "the data is written to disk in the correct format" do
      path = "test/fixtures/file_manager/write_fixture_1.json"
      FileManager.write_fixture(path, data: %{"a" => 1})
      file_contents = FileManager.read_fixture(path)
      FileManager.cleanup_fixture(path)

      %{
        "data" => data,
        "file" => file,
        "recorded_at" => recorded_at
      } = file_contents
      {:ok, recorded_at, 0} = DateTime.from_iso8601(recorded_at)
      difference_in_recorded_seconds = DateTime.to_unix(recorded_at) - DateTime.to_unix(DateTime.utc_now())

      assert data == %{"a" => 1}
      assert file == "test/response_snapshot/file_manager_test.exs"
      assert_in_delta(difference_in_recorded_seconds, 0, 3)
    end
  end

  describe "read_fixture/1" do
  end
end
