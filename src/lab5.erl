-module(lab5).
-export([
    manipulate/1,
    demo/0
]).

manipulate(List) ->
  Length = length(List),
  if
    Length rem 4 =/= 0 ->
      erlang:error(badarg, "List length must be a multiple of 4");
    true ->
      QuarterLength = Length div 4,
      List2 = lists:sublist(List, QuarterLength + 1, QuarterLength),
      List3 = lists:sublist(List, 2 * QuarterLength + 1, QuarterLength),
      List3_reverse = lists:reverse(List3),
      List4 = lists:sublist(List, 3 * QuarterLength + 1, QuarterLength),
      List2 ++ List3_reverse ++ List4
  end.

demo() ->
    Input = [1,2,3,4,5,6,7,8,9,10,11,12],
    Result = manipulate(Input),
    io:fwrite("manipulate(~p): ~p~n", [Input, Result]).
