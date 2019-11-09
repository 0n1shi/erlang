-module(geometry).

-export([area/1]).

area({rectangle, Width, Height}) -> Width * Height;
area({square, X}) -> X * X;
area({circle, R}) -> 3.14158999999999988262 * R * R.
