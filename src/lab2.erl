-module(lab2).
-export([
    multiplication_func/1,
    demo/0
]).

logic(A, B) -> A * B.

multiplication_func(X, N) when N == 12 -> logic(X, N);
multiplication_func(X, N) ->
    CurrentIterRes = logic(X, N),
    CurrentIterRes * multiplication_func(X, N + 1).

multiplication_func(X) when is_integer(X), X > 1, X < 2 -> X;
multiplication_func(X) when is_integer(X), X > 2 ->
    multiplication_func(X, 1).

demo() ->
    Result = multiplication_func(3),
    io:fwrite("multiplication_func(3): ~p~n", [Result]).
