-module(stimer).

-export([cancel/1, start/2]).

start(Time, Fun) ->
    spawn(fun () -> timer(Time, Fun) end).

cancel(Pid) -> Pid ! cancel.

timer(Time, Fun) ->
    receive cancel -> void after Time -> Fun() end.
