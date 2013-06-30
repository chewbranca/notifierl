-module(notifierl_server).
-behavior(gen_server).


-export([
    start_link/0,
    send_message/2
]).


-export([
    init/1,
    terminate/2,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    code_change/3
]).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


send_message(Title, Message) ->
    gen_server:call(?MODULE, {send_message, Title, Message}).


init(_) ->
    {ok, nil}.


terminate(_Reason, _St) ->
    ok.


handle_cast(Msg, St) ->
    {stop, {invalid_cast, Msg}, St}.


handle_info(Msg, St) ->
    {stop, {invalid_info, Msg}, St}.


code_change(_OldVsn, St, _Extra) ->
    {ok, St}.


handle_call({send_message, Title, Message}, _From, St) ->
    Cmd = "terminal-notifier -message '" ++ Message ++ "' -title '" ++ Title ++ "'",
    error_logger:info_msg("Running OS cmd: (~p)~n", [Cmd]),
    _Resp = os:cmd(Cmd),
    {reply, ok, St};
handle_call(Msg, _From, St) ->
    {stop, {invalid_call, Msg}, {invalid_call, Msg}, St}.
