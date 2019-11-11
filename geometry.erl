-module(geometry).

-export([area/1]).

area({rectangle, Width, Height}) -> Width * Height;
area({triangle, Width, Heigth}) -> Width * Heigth / 2;
area({square, X}) -> X * X;
area({circle, R}) -> math:pi() * R * R.
