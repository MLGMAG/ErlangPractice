-module(lab4).
-export([
    unique/1,
    demo/0
]).

unique([]) -> [];
unique([Head | Tail]) ->
  [Head | unique(lists:delete(Head, Tail))].

demo() ->
    Input = [1,2,3,4,4,5,1,2,3],
    Result = unique(Input),
    io:fwrite("unique(~p): ~p~n", [Input, Result]).
