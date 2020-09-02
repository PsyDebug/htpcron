-module(root_hdlr).

-export([init/2]).


init(Req0, Opts) ->
	Method = cowboy_req:method(Req0),
  Path = cowboy_req:path(Req0),
  {ok, Data, _} = cowboy_req:read_body(Req0),
	Req = task(Method, Data, Req0),
	{ok, Req, Opts}.

task(<<"POST">>, Data, Req) ->
  InputJson=maps:from_list(jsx:decode(Data)),
  Res=root_actions:action(InputJson),
  io:format("run task ~p~n",[Res]),
	cowboy_req:reply(200,
  #{<<"content-type">> =>
     <<"application/json; charset=utf-8">>},
     jsx:encode([Res]), Req);

task(<<"DELETE">>, Data, Req) ->
  InputJson=maps:from_list(jsx:decode(Data)),
  Res=root_actions:delete_task(InputJson),
  io:format("delete task ~p~n",[Res]),
	cowboy_req:reply(200,
  #{<<"content-type">> =>
     <<"application/json; charset=utf-8">>},
     jsx:encode([Res]), Req);

task(<<"GET">>, _, Req) ->
  io:fwrite("~p~n", [Req]),
	cowboy_req:reply(200,
  #{<<"content-type">> =>
     <<"application/json; charset=utf-8">>},
     <<"{\"status\":\"unknown method\"}">> , Req);


task(_, _, Req) ->
	%% Method not allowed.
	cowboy_req:reply(405, Req).
