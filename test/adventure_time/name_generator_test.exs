defmodule AdventureTime.NameGeneratorTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{NameGenerator}

  doctest NameGenerator

  describe "generate/0" do
    test "it returns a random name" do
      :rand.seed(:exsplus, {100, 101, 102})
      assert NameGenerator.generate() == "snowy_fog_4797"
    end
  end
end
