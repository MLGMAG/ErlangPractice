-module(lab9).
-export([
    swap_elements_sequential/1,
    swap_elements_parallel/1,
    ch/3,
    demo/0
]).

% Swap the second element of the second row and the second element 
% of the penultimate row of the matrix.

% swap_elements_parallel2(Matrix) ->
%     [FL, [SLF, SLS | SLTail] | MatrixTail] = Matrix,
% 
%     [UL, [PULF, PULS | PULTail] | MatrixMiddleReverse] = lists:reverse(MatrixTail),
% 
%     MatrixMiddle = lists:reverse(MatrixMiddleReverse),
% 
%     [FL] ++ [[SLF, PULS | SLTail]] ++ 
%     MatrixMiddle ++
%     [[PULF, SLS | PULTail]] ++ [UL].

swap_elements_parallel([FL, [SLF, SLS | SLTail] | MatrixTail]) ->
    Pid = self(),
    spawn(lab9, ch, [MatrixTail, SLS, Pid]),
    receive
        {puls, PULS} -> PULS
    end,
    receive
        {newMatrixTail, NewMatrixTail} -> NewMatrixTail
    end,
    [FL, [SLF, PULS | SLTail] | NewMatrixTail].

ch(MatrixTail, SLS, Pid) ->
    Pid ! {newMatrixTail, ch1(MatrixTail, SLS, Pid)}.

ch1([[PULF, PULS | PULTail], UL], SLS, Pid) ->
    Pid ! {puls, PULS},
    [[PULF, SLS | PULTail], UL];
ch1([MatrixHead | MatrixTail], SLS, Pid) ->
    [MatrixHead | ch1(MatrixTail, SLS, Pid)].

swap_elements_sequential([FL, [SLF, SLS | SLTail] | MatrixTail]) ->
    [_UL, [_PULF, PULS | _PULTail] | _MatrixMiddleReverse] = lists:reverse(MatrixTail),
    [FL, [SLF, PULS | SLTail] | ch2(MatrixTail, SLS)].

ch2([[PULF, _PULS | PULTail], UL], SLS) ->
    [[PULF, SLS | PULTail], UL];
ch2([MatrixHead | MatrixTail], SLS) ->
    [MatrixHead | ch2(MatrixTail, SLS)].

mtr_gn1(N) ->
    [lists:map(fun(X) -> X end, lists:seq(1, N))] ++
    [lists:map(fun(X) -> X / 100 end, lists:seq(1, N))] ++
    [[R || R <- lists:seq(1, N)] || _K <- lists:seq(1, N - 2)].

demo() ->
    Matrix = mtr_gn1(100_000),
    %swap_elements_sequential(Matrix).
    %swap_elements_parallel(Matrix).
    %swap_elements_parallel2(Matrix).

    {ParallelTime , _ParallelValue} = timer:tc(fun() -> swap_elements_parallel(Matrix) end),
    io:format("Parallel execution time: ~p~n", [ParallelTime]),
    {SequentialTime , _SequentialValue} = timer:tc(fun() -> swap_elements_sequential(Matrix) end),
    io:format("Sequential execution time: ~p~n", [SequentialTime]).




% Sequential 10 x 10:
% 3.02e-5
% Parallel   10 x 10:
% 0.0112
%
% Sequential 1000 x 1000:
% 0.0254
% Parallel   1000 x 1000:
% 0.0932
%
% Sequential 10_000 x 10_000:
% 12
% Parallel   10_000 x 10_000:
% 
%
