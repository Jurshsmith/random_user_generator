defmodule RandomUserGenerator.UtilsTest do
  use ExUnit.Case
  alias RandomUserGenerator.Utils

  test "generates random integer" do
    assert Utils.generate_random_number(100) >= 0
  end
end
