-module(kvs).

-export([lookup/1, start/0, store/2]).

rpc(Query) ->
    kvs ! {self(), Query},
    receive {kvs, Reply} -> Reply end.

lookup(Key) -> rpc({lookup, Key}).

store(Key, Value) -> rpc({store, Key, Value}).

start() -> register(kvs, spawn(fun () -> loop() end)).

loop() ->
    receive
      {From, {store, Key, Value}} ->
	  put(Key, {ok, Value}), From ! {kvs, true}, loop();
      {From, {lookup, Key}} -> From ! {kvs, get(Key)}, loop()
    end.
