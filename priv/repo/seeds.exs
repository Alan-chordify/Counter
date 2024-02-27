# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Counter.Repo.insert!(%Counter.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# users = [
#   %{name: "Alice", email: "alice@example.com"},
#   %{name: "Bob", email: "bob@example.com"}
# ]
alias Counter.Product
[
   %Product{name: "Product 1", description: "Description for product 1" , price: 50.00, stock_quantity: 20},
   %Product{name: "Product 2", description: "Description for product 2" , price: 50.00, stock_quantity: 50}
]

# # Insert seed data into the database
# Enum.each(users, fn user_attrs ->
#   Repo.insert!(%User{}, user_attrs)
# end)

|>Enum.each(&Counter.Repo.insert!(&1))
