%%%-------------------------------------------------------------------
%% @doc htpcron public API
%% @end
%%%-------------------------------------------------------------------

-module(htpcron_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", root_hdlr, []}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8081}], #{
		env => #{dispatch => Dispatch}
	}),
    htpcron_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
