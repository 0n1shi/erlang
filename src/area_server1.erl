-module(area_server1).

-export([loop/0, rpc/2]).

%% Remote Procedure Call
rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive {Pid, Response} -> Response end.

loop() ->
    receive
      {From, {rectangle, Width, Height}} ->
	  From ! {self(), Width * Height}, loop();
      {From, {circle, R}} ->
	  From ! {self(), math:pi() * R * R}, loop();
      {From, _} -> From ! {self(), unknown}, loop()
    end.
