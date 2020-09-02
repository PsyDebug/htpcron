-module(root_actions).

-export([action/1,delete_task/1]).

action(TaskParams)->
    Res = case binary:bin_to_list(maps:get(<<"type">>,TaskParams)) of
              "http" -> http_task(TaskParams);
              "amqp" -> amqp_task(TaskParams);
              _ -> {error,'unknown task type'}
          end,
    Res.

amqp_task(TaskParams)->
    io:fwrite("~p~n", [TaskParams]),
    {status,'ok'}.

http_task(TaskParams)->
    Ticket=binary:bin_to_list(maps:get(<<"ticket">>,TaskParams)),
    TaskName=binary:bin_to_list(maps:get(<<"task">>,TaskParams))
    ++"_of_"++  binary:bin_to_list(maps:get(<<"service-name">>,TaskParams)),
    Url=binary:bin_to_list(maps:get(<<"url">>,TaskParams)),
    Res = ecron:add(list_to_atom(TaskName),Ticket,{http_task,send,[{Url,TaskName}]}),
    Res.

delete_task(TaskParams)->
    TaskName=binary:bin_to_list(maps:get(<<"task">>,TaskParams))
    ++"_of_"++  binary:bin_to_list(maps:get(<<"service-name">>,TaskParams)),
    Res = ecron:delete(list_to_atom(TaskName)),
    Res.
