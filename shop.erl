-module(shop).

-export([cost/1, sum/1, sum/2, total/1]).

cost(orange) -> 5;
cost(newspaper) -> 8;
cost(apple) -> 2;
cost(pear) -> 9;
cost(milk) -> 7.

total([{What, N} | List]) ->
    cost(What) * N + total(List);
total([]) -> 0.

sum(L) -> sum(L, 0).

sum([], N) -> N;
sum([H | T], N) -> sum(T, H + N).
