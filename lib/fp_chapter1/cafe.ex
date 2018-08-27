defmodule FpChapter1.Cafe do
  use GenServer

  def init(_), do: {:ok, :none}

  def buy_coffee() do
    
  end

end


defmodule FpChapter1.Coffee do
  use GenServer
 
  def init(_), do: {:ok, :none}

  def price() do
  
  end

end

defmodule FpChapter1.CreditCard do
  use GenServer

  def init(_), do: {:ok, :none}

  def charge(amount) do 

  end 

end
