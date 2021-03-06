htpcron
=====

Prototype of centralized cron for microservices


Install
-----
`docker run --name htpcron -p 8081:8081 psydebug/htpcron:latest`
  
## Start Task

```curl --header "Content-Type: application/json"   -X POST   --data '{"service-name":"testcron-service","task":"checker_every_min","url":"http://localhost:8080/task","ticket":"*/1 * * * *"}'   http://localhost:8081/task```

Http task example

`{
  "service-name": "testcron-service",
  "task": "checker_every_min",
  "type": "http",
  "url": "http://localhost:8080/task",
  "ticket": "*/1 * * * *"
}`

Amqp task example

`{
  "service-name": "testcron-service",
  "task": "checker_every_min",
  "type": "amqp",
  "message": "{Activation over amqp message}",
  "queue": "cronq.test",
  "ticket": "*/1 * * * *"
}`

## Delete Task

```curl --header "Content-Type: application/json"   -X DELETE   --data '{"service-name":"testcron-service","task":"checker_every_min"}'   http://localhost:8081/task```
