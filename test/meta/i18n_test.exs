defmodule Meta.I18NTest do
  use ExUnit.Case, async: true

  alias Meta.I18N

  describe "t/3" do
    test "no translation" do
      assert I18N.t("en", "huh") == {:error, :no_translation}
    end

    test "flash.hello in English" do
      assert I18N.t("en", "flash.hello", first: :Joe, last: "Schmoe") == "Hello, Joe Schmoe!"
    end

    test "flash.hello in French" do
      assert I18N.t("fr", "flash.hello", first: "Joe", last: "Schmoe") == "Salut, Joe Schmoe!"
    end

    test "flash.bye in English" do
      assert I18N.t("en", "flash.bye", name: "Joe") == "Joe, Bye!"
    end

    test "flash.bye in French" do
      assert I18N.t("fr", "flash.bye", name: "Joe") == "Joe, Au revoir!"
    end

    test "users.title in English" do
      assert I18N.t("en", "users.title") == "Users"
    end

    test "users.title in French" do
      assert I18N.t("fr", "users.title") == "Utilisateurs"
    end

    test "users.address.city in English" do
      assert I18N.t("en", "users.address.city") == "City"
    end

    test "users.address.something.else.the.thing in English" do
      assert I18N.t("en", "users.address.something.else.the.thing") == "the thing"
    end
  end
end
