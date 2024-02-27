defmodule CounterWeb.LoginHTML do
  use CounterWeb, :html

  embed_templates "login_html/*"

  @doc """
  Renders a login form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def login_form(assigns)
end
