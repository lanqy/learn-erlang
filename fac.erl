%% 编译 c(fac).
%% 运行 fac:fac(10).
%% 打印 3628800.

-module(fac).
-export([fac/1]).

fac(0) ->
    1;
fac(N) when N > 0 -> 
    N * fac(N - 1).