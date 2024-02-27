defmodule CounterWeb.LoginControllerTest do
  use CounterWeb.ConnCase

  import Counter.AccountsFixtures

  @create_attrs %{password: "some password", email: "some email"}
  @update_attrs %{password: "some updated password", email: "some updated email"}
  @invalid_attrs %{password: nil, email: nil}

  describe "index" do
    test "lists all logins", %{conn: conn} do
      conn = get(conn, ~p"/logins")
      assert html_response(conn, 200) =~ "Listing Logins"
    end
  end

  describe "new login" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/logins/new")
      assert html_response(conn, 200) =~ "New Login"
    end
  end

  describe "create login" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/logins", login: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/logins/#{id}"

      conn = get(conn, ~p"/logins/#{id}")
      assert html_response(conn, 200) =~ "Login #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/logins", login: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Login"
    end
  end

  describe "edit login" do
    setup [:create_login]

    test "renders form for editing chosen login", %{conn: conn, login: login} do
      conn = get(conn, ~p"/logins/#{login}/edit")
      assert html_response(conn, 200) =~ "Edit Login"
    end
  end

  describe "update login" do
    setup [:create_login]

    test "redirects when data is valid", %{conn: conn, login: login} do
      conn = put(conn, ~p"/logins/#{login}", login: @update_attrs)
      assert redirected_to(conn) == ~p"/logins/#{login}"

      conn = get(conn, ~p"/logins/#{login}")
      assert html_response(conn, 200) =~ "some updated password"
    end

    test "renders errors when data is invalid", %{conn: conn, login: login} do
      conn = put(conn, ~p"/logins/#{login}", login: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Login"
    end
  end

  describe "delete login" do
    setup [:create_login]

    test "deletes chosen login", %{conn: conn, login: login} do
      conn = delete(conn, ~p"/logins/#{login}")
      assert redirected_to(conn) == ~p"/logins"

      assert_error_sent 404, fn ->
        get(conn, ~p"/logins/#{login}")
      end
    end
  end

  defp create_login(_) do
    login = login_fixture()
    %{login: login}
  end
end
