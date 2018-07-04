%% 编译 c(helloworld).
%% 运行 helloworld:start().
%% 打印 Hello world.

-module(helloworld).
-import(io,[fwrite/1]).
-export([start/0]).

start() ->
    fwrite("Hello world\n").