-module(lab8).
-export([
    filter_letters1/1,
    filter_letters2/1,
    filter_letters3/1,
    filter_letters4/1,
    demo/0
]).

% Remove the letters z, w from the given list of Latin letters.



% ver.1
filter_letters1([X | Xs]) when (X =:= 'z') or (X =:= 'w') ->
    filter_letters1(Xs);
filter_letters1([X | Xs]) when (X =/= 'z') and (X =/= 'w') ->
    [X | filter_letters1(Xs)];
filter_letters1([]) -> [].



% ver.2
filter_letters2([X | Xs]) ->
    case X of
        'z' ->
            filter_letters2(Xs);
        'w' ->
            filter_letters2(Xs);
        _ ->
            [X | filter_letters2(Xs)]
    end;
filter_letters2([]) -> [].



% ver.3
filter_letters3(Xs)->
    lists:filter(fun (X) -> (X =/= 'z') and (X =/= 'w') end, Xs).



% ver.4
filter_letters4(Xs)->
    [X || X <- Xs, (X =/= 'z') and (X =/= 'w')].



demo() ->
    InputLetters = ['a', 'b', 'c', 'z', 'w', 'a', 'c', 'w', 'w'],
    Result1 = filter_letters1(InputLetters),
    io:fwrite("filter_letters1(~p): ~p~n", [InputLetters, Result1]),
    Result2 = filter_letters2(InputLetters),
    io:fwrite("filter_letters2(~p): ~p~n", [InputLetters, Result2]),
    Result3 = filter_letters3(InputLetters),
    io:fwrite("filter_letters3(~p): ~p~n", [InputLetters, Result3]),
    Result4 = filter_letters4(InputLetters),
    io:fwrite("filter_letters4(~p): ~p~n", [InputLetters, Result4]).
