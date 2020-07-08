-module(http_task).

-export([send/1]).

send({URL,TaskName})->
    case  httpc:request(URL) of
    {ok, {{Version, 200, ReasonPhrase}, Headers, Body}} ->
            io:format("~p ~p ~p is ok.~n",[TaskName,erlang:localtime(),Body]);
        _ -> io:format("~p ~p Fail.~n",[TaskName,erlang:localtime()])
    end.
