-module(lab7).
-export([
    on_competition/0,
    demo/0
]).

% Two athletes can participate in the same competition if 
% they are engaged in the same sport and have the same division.

% -> {Name, SportType, Class}
db_athletes() ->
    [
        {adam, swimming, 1},
        {bob, gambling, 1},
        {dick, running, 1},
        {john, swimming, 1},
        {mike, gambling, 2},
        {nick, gambling, 1}
    ].

on_competition() ->
    DB = db_athletes(),
    L = [
        {SportType, Class, [
            Name || {Name, ST, C} <- DB, SportType == ST, Class == C
        ]} || {_, SportType, Class} <- DB
    ],
    del_dbles_mod(L).

del_dbles_mod([{ST, C, L} | T]) ->
    Tclear = del_examples_mod(T, {ST, C}),
    [{ST, C, L} | del_dbles_mod(Tclear)];
del_dbles_mod([]) -> [].

del_examples_mod([], _) -> [];
del_examples_mod([{ST, C, L} | Xs], Obj) ->
    case {ST, C} == Obj of
        true -> del_examples_mod(Xs, Obj);
        false -> [{ST, C, L}|
        del_examples_mod(Xs, Obj)]
    end.

demo() ->
    Result = on_competition(),
    io:fwrite("on_competition(): ~p~n", [Result]).
