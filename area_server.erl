-module(area_server).

-export([loop/0, test/0]).

-import(geometry, [area/1]).

loop() ->
    receive
      {rectangle, Width, Height} ->
	  io:format("Area of rectangle is ~p~n",
		    [area({rectangle, Width, Height})]),
	  loop();
      {triangle, Width, Height} ->
	  io:format("Area of circle is ~p~n",
		    [area({triangle, Width, Height})]),
	  loop();
      {circle, R} ->
	  io:format("Area of circle is ~p~n",
		    [area({circle, R})]),
	  loop();
      _ -> io:format("Unknown~n"), loop()
    end.

test() ->
    io:format("Area of rectangle is ~p~n",
	      [area({rectangle, 10, 20})]).
