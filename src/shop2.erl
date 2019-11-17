-module(shop2).

-import(shop, [cost/1]).

-import(lists, [sum/1]).

-export([total/1]).

total(L) ->
    sum(lists:map(fun ({What, N}) -> cost(What) * N end,
		  L)).
