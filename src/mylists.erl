-module(mylists).

-export([map/2, sum/1]).

sum([H | T]) -> H + sum(T);
sum([]) -> 0.

map(_, []) -> [];
map(F, [H | T]) -> [F(H) | map(F, T)].
