%%%-------------------------------------------------------------------
%% @doc htpcron top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(htpcron_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).


%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% supervisor.

init([]) ->
	Procs = [],
	{ok, {{one_for_one, 10, 10}, Procs}}.
%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
%%init([]) ->
%%    SupFlags = #{strategy => one_for_all,
%%                 intensity => 0,
%%                 period => 1},
%%    ChildSpecs = [],
%%    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
