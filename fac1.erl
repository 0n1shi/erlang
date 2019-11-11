-module(fac1).

-export([fac/1, main/1]).

main([A]) ->
    I = list_to_integer(atom_to_list(A)),
    F = fac(I),
    io:format("factorial ~w = ~w~n", [I, F]),
    init:stop().

fac(N) -> fac(N - 1, N).

fac(0, Acc) -> Acc;
fac(N, Acc) -> fac(N - 1, Acc * N).
