-module(lab3).
-import(math,[cos/1]).
-export([
    math_expression/4,
    demo/0
]).

logic(X, I) ->
    (cos(X + 2 * I) / (I * I + 1)) - (2 * X * X).

sum_func(N, I, X) when N =< I ->
    logic(X, I);
sum_func(N, I, X) when N > I ->
    CurrentIterRes = logic(X, I),
    CurrentIterRes + sum_func(N, I + 1, X).

math_expression(X, Xf, H, N) when X =< Xf ->
    Y = sum_func(N, 1, X),
    [Y|math_expression(X + H, Xf, H, N)];
math_expression(X, Xf, _H, _N) when X > Xf -> [].

demo() ->
    Result = math_expression(1, 2, 0.1, 10),
    io:fwrite("math_expression(1, 2, 0.1, 10): ~p~n", [Result]).
