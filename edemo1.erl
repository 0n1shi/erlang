-module(edemo1).

-export([start/2]).

start(Bool, M) ->
    A = spawn(fun () -> a() end),
    B = spawn(fun () -> b(A, Bool) end),
    C = spawn(fun () -> c2(B, M) end),
    msleep(1000),
    status(b, B),
    status(c, C).

%% システムプロセスなり、受信するメッセージを表示する
a() -> process_flag(trap_exit, true), wait(a).

%% システムプロセスなり、Aにリンク後、受信するメッセージを表示する
b(A, Bool) ->
    process_flag(trap_exit, Bool), link(A), wait(b).

%% プロセスにリンク後、引数に対応したプロセス終了処理を行う
c(B, M) ->
    link(B),
    case M of
      {die, Reason} -> exit(Reason);
      {divide, N} -> 1 / N, wait(c);
      normal -> true
    end.

c2(B, M) ->
    process_flag(trap_exit, true),
    link(B),
    exit(B, M),
    wait(c).

%% 受信したメッセージを表示する
wait(Prog) ->
    receive
      Any ->
	  io:format("Process ~p received ~p~n", [Prog, Any]),
	  wait(Prog)
    end.

msleep(T) -> receive  after T -> true end.

%% PIDに対応するプロセスの生死を表示する
status(Name, Pid) ->
    case erlang:is_process_alive(Pid) of
      true ->
	  io:format("process ~p (~p) is alive~n", [Name, Pid]);
      false ->
	  io:format("process ~p (~p) is dead~n", [Name, Pid])
    end.
