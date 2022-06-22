# ZgElixir3

Observing Elixir app with observer

## Start iex shell so we have cmd history and available all lib modules
`iex --erl "-kernel shell_history enabled" --name zg_elixir_3 -S mix`

## Start the observer

`:observer.start()`

- explain that we actually start erlang application

## Show System tab

- we have limited number of :atoms so lets crash it

`1..1_050_000 |> Enum.map(fn i -> :"#{i}" end)`  
`ls -al erl_crash.dump`

- Comment the size of dump file.

`mv erl_crash.dump ~/Downloads`

- Explain how it is hard to get erl_crash.dump if in docker, Why?
- Docker is stateless

## Crash dump file analysys

- First try to open crash dump file using iex observer

`erl -sname observer -hidden -setcookie MyCookie -run observer`  

- General tab has the answer => go to atoms tab

- Show other tabs

## Applications  tab

- map zg_elixir_3 application to source code and explain.

- Show process info for Stack Genserver

`1..1_000_000 |> Enum.map(fn i -> send(Process.whereis(Stack), {:push, "#{i * i}"}) end)`

- memory should go up

- reductions go up

`1..1_000_000 |> Enum.map(fn i -> send(Process.whereis(Stack), :pop) end)`

- memory down

- reduction up

`Process.info(pid(n,n,n))`

- because observer hangs

- why refresh is needed

- msq que

Do not forget to comment out push msg handler.

`1..60 |> Enum.map(fn i -> send(Process.whereis(Stack), {:push, "#{i * i}"}) end)`

- send message from observer