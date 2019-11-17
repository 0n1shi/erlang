-module(clock).

-export([alarm/2, start/2, start_alarm/2, stop/0]).

start(Time, Fun) ->
    register(clock, spawn(fun () -> tick(Time, Fun) end)).

stop() -> clock ! stop.

tick(Time, Fun) ->
    receive
      stop -> void after Time -> Fun(), tick(Time, Fun)
    end.

alarm(Time, Fun) -> receive  after Time -> Fun() end.

start_alarm(Time, Fun) ->
    register(alarm, spawn(fun () -> alarm(Time, Fun) end)).
