-module(lab1).
-export([
    fact/1,
    hello_world/0
]).

fact(N) when N>0 ->
    N * fact(N-1);
fact(0) ->
    1.

hello_world() ->
    io:fwrite("Hello World!\n").

