defmodule FpChapter1.Cafe do
  use GenServer

  def init(_), do: {:ok, :none}

  def buy_coffee(card) do
    {:ok, coffee} = GenServer.start(FpChapter1.Coffee, 10)
    FpChapter1.Coffee.price(coffee)
    |> FpChapter1.CreditCard.charge(card)
    coffee
  end

end


defmodule FpChapter1.Coffee do
  use GenServer

  def init(price), do: {:ok, price}

  def price(coffee) do

    GenServer.call(coffee, :price)
   end
  def price() do
   3
  end

  def handle_call(:price, _from, price) do
    {:reply, price,  price}
  end

end

defmodule FpChapter1.CreditCard do
  use GenServer

  def init(_), do: {:ok, :none}

  def charge(amount, card) do
   IO.puts "The charge Pid: #{ inspect self()}"
   GenServer.call(card, amount)
  end

  def handle_call(_amount, from, state) do
    IO.puts "I was here"
    Process.send(self(), {:reply, from}, [])
    {:noreply, state}
  end

  def handle_info({:reply, from}, state) do
    IO.puts "The Pid: #{ inspect self()}"
    GenServer.reply(from, :amount)
    {:noreply, state}
  end
end
