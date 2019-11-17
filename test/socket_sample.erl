-module(socket_sample).
-export([tcp_server/0, tcp_client/1, sleep/1]).

tcp_server() ->
    {ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 4}, {reuseaddr, true}, {active, true}]),
    server_loop(Listen).

% server_loop(Listen) ->
%     {ok, Socket} = gen_tcp:accept(Listen),
%     spawn(fun() -> server_loop(Listen) end),
%     loop(Socket).

server_loop(Listen) ->
    {ok, Socket} = gen_tcp:accept(Listen),
    spawn(fun() -> loop(Socket) end),
    server_loop(Listen).

loop(Socket) ->
    io:format("loop started.~n"),
    receive
        {tcp, Socket, Bin} ->
            io:format("Server received binary = ~p~n", [Bin]),
            Str = binary_to_term(Bin),
            io:format("Server (unpacked) ~p~n", [Str]),
            loop(Socket);
        {tcp_closed, Socket} ->
            io:format("Server socket closed~n")
        end.

tcp_client(Val) ->
    {ok, Socket} = gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
    gen_tcp:send(Socket, term_to_binary(Val)),
    gen_tcp:close(Socket).

sleep(Msec) ->
    receive
        after Msec -> ok
            end.
