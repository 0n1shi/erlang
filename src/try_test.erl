-module(try_test).

-export([catcher/1, demo1/0, demo2/0, demo3/0,
	 generate_exception/1]).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> erlang:error(a).

demo1() -> [catcher(I) || I <- [1, 2, 3, 4, 5]].

demo2() ->
    [{I, catch generate_exception(I)}
     || I <- [1, 2, 3, 4, 5]].

demo3() ->
    try generate_exception(5) catch
      error:X -> {X, erlang:get_stacktrace()}
    end.

catcher(N) ->
    try generate_exception(N) of
      Val -> {N, normal, Val}
    catch
      X -> {X, caught, thrown, X};
      exit:X -> {X, caught, exited, X};
      error:X -> {X, caught, error, X}
    end.
