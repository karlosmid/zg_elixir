defmodule Stack do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def child do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [[:hello]]}
    }
  end

  # Callbacks

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  @impl true
  def handle_info(:pop, [head | tail]) do
    {:noreply, tail} 
  end
  
  @impl true
  def handle_info({:push, element}, state) do
    :timer.sleep(1_000)
    {:noreply, [element | state]}
  end
end
