-module(server).
-import(lists, [reverse/1]).
-export([get_url/2, start_tcp_server/0, tcp_client/1, start_tcp_seq_server/0]).

get_url(URL, Path) ->
    {ok, Socket} = gen_tcp:connect(URL, 80, [binary, {packet, 0}]),
    ok = gen_tcp:send(Socket, io_lib:format("GET ~s HTTP/1.0\r\n\r\n", [Path])),
    receive_data(Socket, []).

receive_data(Socket, SoFar) ->
    receive
        {tcp, Socket, Bin} ->
            receive_data(Socket, [Bin|SoFar]);
        {tcp_closed, Socket} ->
            list_to_binary(reverse(SoFar))
        end.

start_tcp_server() ->
    {ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 4}, {reuseaddr, true}, {active, true}]),
    {ok, Socket} = gen_tcp:accept(Listen),
    gen_tcp:close(Listen),
    loop(Socket),
    start_tcp_server().

start_tcp_seq_server() ->
    {ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 4}, {reuseaddr, true}, {active, true}]),
    seq_loop(Listen).

seq_loop(Listen) ->
    {ok, Socket} = gen_tcp:accept(Listen),
    loop(Socket),
    seq_loop(Listen).

loop(Socket) ->
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
