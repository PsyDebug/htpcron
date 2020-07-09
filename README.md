htpcron
=====

An OTP application

Build
-----

    $ rebar3 compile
    

   
## Start Task

```curl --header "Content-Type: application/json"   -X POST   --data '{"service-name":"rbp-testcron-service","task":"checker_every_min","url":"http://localhost:8080/task","ticket":"*/1 * * * *"}'   http://localhost:8081/task```

## Delete Task

```curl --header "Content-Type: application/json"   -X DELETE   --data '{"service-name":"rbp-testcron-service","task":"checker_every_min"}'   http://localhost:8081/task```
