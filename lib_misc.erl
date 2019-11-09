-module(lib_misc).

-export([factorial/1, factorial/2, filter/2, for/3,
	 odds_and_evens_acc/1, odds_and_evens_acc/3, perms/1,
	 pythag/1, qsort/1]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I + 1, Max, F)].

qsort([]) -> [];
qsort([Pivot | T]) ->
    qsort([X || X <- T, X < Pivot]) ++
      [Pivot] ++ qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
    [{A, B, C}
     || A <- lists:seq(1, N), B <- lists:seq(1, N),
	C <- lists:seq(1, N), A + B + C =< N,
	A * A + B * B =:= C * C].

perms([]) -> [[]];
perms(L) -> [[H | T] || H <- L, T <- perms(L -- [H])].

filter(Func, [H | T]) ->
    case Func(H) of
      true -> [H | filter(Func, T)];
      false -> filter(Func, T)
    end;
filter(_, []) -> [].

odds_and_evens_acc(L) -> odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H | T], Odds, Evens) ->
    case H rem 2 of
      1 -> odds_and_evens_acc(T, [H | Odds], Evens);
      0 -> odds_and_evens_acc(T, Odds, [H | Evens])
    end;
odds_and_evens_acc([], Odds, Evens) ->
    {lists:reverse(Odds), lists:reverse(Evens)}.

factorial(N) -> factorial(N - 1, N).

factorial(N, A) when N > 0 -> factorial(N - 1, A * N);
factorial(_, A) -> A.
