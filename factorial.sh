#!/usr/bin/env escript

main([A]) ->
    I = list_to_integer(A),
    F = fac(I),
    io:format("factorial ~w = ~w~n", [I, F]).

fac(N) -> fac(N - 1, N).

fac(0, Acc) -> Acc;
fac(N, Acc) -> fac(N - 1, Acc * N).
