-module(notifierl).


-export([start/0,stop/0,restart/0]).


-export([send_message/2]).


start() ->
    application:start(sasl),
    application:start(?MODULE).


stop() ->
    application:stop(sasl),
    application:stop(?MODULE).


restart() ->
    stop(),
    start().


send_message(Title, Message) ->
    notifierl_server:send_message(Title, Message).
