defmodule CounterWeb.Pagelive do
  use CounterWeb, :live_view

  def mount(_params, _session, socket) do
    # Subscribe to the "counter_updates" topic
    Phoenix.PubSub.subscribe(Counter.PubSub, "counter_updates")
    {:ok, assign(socket, products: Counter.Product |> Counter.Repo.all())}
  end

  def handle_event("inc", %{"product_id" => product_id, "quantity" => value}, socket) do
    product = Counter.Repo.get(Counter.Product, product_id)
    updated_product = %{product | stock_quantity: String.to_integer(value) + 1}
    updated_products = update_product(socket.assigns.products, updated_product)
    broadcast_products(updated_products, socket)
    {:noreply, assign(socket, products: updated_products)}
  end

  def handle_event("dec", %{"product_id" => product_id, "quantity" => value}, socket) do
    product = Counter.Repo.get(Counter.Product, product_id)
    updated_product = %{product | stock_quantity: String.to_integer(value) - 1}
    updated_products = update_product(socket.assigns.products, updated_product)
    broadcast_products(updated_products, socket)
    {:noreply, assign(socket, products: updated_products)}
  end

  defp update_product(products, updated_product) do
    Enum.map(products, fn p ->
      if p.id == updated_product.id, do: updated_product, else: p
    end)
  end

  def handle_info({:update_products, updated_products}, socket) do
    {:noreply, assign(socket, products: updated_products)}
  end

  def handle_info({:update_counter, {product_id, stock_quantity}}, socket) do
    updated_products = Enum.map(socket.assigns.products, fn product ->
      if product.id == product_id do
        %{product | stock_quantity: stock_quantity}
      else
        product
      end
    end)
    {:noreply, assign(socket, products: updated_products)}
  end

  defp broadcast_products(updated_products, _socket) do
    Phoenix.PubSub.broadcast(Counter.PubSub, "counter_updates", {:update_products, updated_products})
  end
end
