-module(root_hdlr).

-export([init/2,print_job/1]).

print_job(Job)->
    io:format("It's testing message ~p .~n",[Job]).

run_tusk(TaskParams)->
    Ticket=binary:bin_to_list(maps:get(<<"ticket">>,TaskParams)),
    TaskName=binary:bin_to_list(maps:get(<<"task">>,TaskParams)),
    Url=binary:bin_to_list(maps:get(<<"url">>,TaskParams)),
    Res = ecron:add(list_to_atom(TaskName),Ticket,{http_task,send,[{Url,TaskName}]}),
    io:format("~p~n",[Res]).

init(Req0, Opts) ->
	Method = cowboy_req:method(Req0),
  {ok, Data, _} = cowboy_req:read_body(Req0),
	Req = echo(Method, Data, Req0),
	{ok, Req, Opts}.

echo(<<"POST">>, Data, Req) ->
  InputJson=maps:from_list(jsx:decode(Data)),
  run_tusk(InputJson),
	cowboy_req:reply(200,
  #{<<"content-type">> =>
     <<"application/json; charset=utf-8">>},
     <<"Task started">>, Req);



echo(<<"GET">>, _, Req) ->
  io:fwrite("~p~n", [Req]),
	cowboy_req:reply(200, #{
		<<"content-type">> => <<"text/plain; charset=utf-8">>
	},<<"TEST GET method.">> , Req);


echo(_, _, Req) ->
	%% Method not allowed.
	cowboy_req:reply(405, Req).
