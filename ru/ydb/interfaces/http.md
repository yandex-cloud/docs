# YQL HTTP API
## Введение {#introduction}
Мы хотим в ближайшее время полностью перейти на данный HTTP API вместо текущего MessageBus API и со временем закопать последний. Таким образом все возможности YQL, за вычетом  событий, происходящих на клиенте (например, повторные попытки соединения), будут доступны через HTTP API. В будущем, вероятно, будет добавлен режим работы через WebSocket, чтобы была возможность получать обновления статусов операций без polling.

HTTP API построен по принципу REST, то есть каждой сущности соответствует URL. Типа HTTP-запроса определяет, какая операция будет выполненена:

* `GET` — получение данных;
* `POST` — создание;
* `PUT` — изменение;
* `DELETE` — удаление.

<blockquote>Могут быть доступны не все типы операций.</blockquote>

Практически все ручки требуют OAuth-аутентификации. Разменять свою паспортную куку на OAuth-токен можно здесь: <https://yql.yandex-team.ru/?settings_mode=token>

![](https://jing.yandex-team.ru/files/blinkov/YQL-08.png)

## Справочная документация по API {#api-reference-documentation}
Полный список всех ручек:
[yql.yandex-team.ru/docs/http/reference](https://yql.yandex-team.ru/docs/http/reference/)

## Клиентские библиотеки {#client-library}
Обертки YQL HTTP API для:

* [Python](python.md)
* [JDBC](jdbc.md) (Java)

## Пример запуска запроса {#example-of-running-a-query}
``` sh
$ export YQL_TOKEN="XXXXX" # получаем с https://yql.yandex.net/api/oauth/new
$ curl -X POST \
    -d '{"content": "SELECT 2+2;", "action": "RUN", "type": "SQL"}' \
    -H "Content-Type: application/json" \
    -H "Authorization: OAuth $YQL_TOKEN" \
    https://yql.yandex.net/api/v2/operations \
    # в ответе получаем id, например YYYYY
$ curl -X GET \
    -H "Authorization: OAuth $YQL_TOKEN" \
    https://yql.yandex.net/api/v2/operations/YYYYY # статус и метаданные
$ curl -X GET \
    -H "Authorization: OAuth $YQL_TOKEN" \
    https://yql.yandex.net/api/v2/operations/YYYYY/results?filters=DATA # статус и результаты
```
<details markdown="1">
<summary>Результаты этих команд</summary>
``` sh
$ export YQL_TOKEN="XXXXXXXX"
$ curl -s -X POST -d '{"content":"SELECT 2+2;", "action":"RUN", "type":"SQL"}' -H "Content-Type: application/json" -H "Authorization: OAuth $YQL_TOKEN" <https://yql.yandex.net/api/v2/operations> | json_pp
{
   "username" : "blinkov",
   "updatedAt" : "2016-01-18T12:09:46.390Z",
   "id" : "569cd60a64731001f8417df1",
   "tabletId" : 72075186224037908,
   "status" : "PENDING",
   "createdAt" : "2016-01-18T12:09:46.335Z",
   "queryData" : {
      "content" : "SELECT 2+2;",
      "type" : "SQL",
      "files" : []
   }
}
$ curl -s -X GET -H "Authorization: OAuth $YQL_TOKEN" <https://yql.yandex.net/api/v2/operations/569cd60a64731001f8417df1> | json_pp
{
   "id" : "569cd60a64731001f8417df1",
   "username" : "blinkov",
   "updatedAt" : "2016-01-18T12:09:55.122Z",
   "status" : "COMPLETED",
   "createdAt" : "2016-01-18T12:09:46.335Z",
   "queryData" : {
      "type" : "SQL",
      "content" : "SELECT 2+2;",
      "files" : []
   },
   "tabletId" : 72075186224037908
}
$ curl -s -X GET -H "Authorization: OAuth $YQL_TOKEN" <https://yql.yandex.net/api/v2/operations/569cd60a64731001f8417df1/results?filters=DATA> | json_pp
{
   "status" : "COMPLETED",
   "id" : "569cd60a64731001f8417df1",
   "data" : [
      {
         "Write" : [
            {
               "Type" : [
                  "ListType",
                  [
                     "StructType",
                     [
                        [
                           "column0",
                           [
                              "DataType",
                              "Int64"
                           ]
                        ]
                     ]
                  ]
               ],
               "Data" : [
                  [
                     4
                  ]
               ]
            }
         ]
      }
   ]
}
```
</details>
<details markdown="1">
<summary>Запуск запроса на s-expressions вместо SQL</summary>
``` sh
$ export YQL_TOKEN="XXXXX" # получаем с https://yql.yandex.net/api/oauth/new
$ cat /var/tmp/query.yql # текст запроса в файле, чтобы меньше возиться с экранированием кавычек
{"content": "
(
(let world (block '(
  (let output (block '(
    (let select (block '(
      (let core (AsList (Void)))
      (let core (FlatMap core (lambda '(row) (block '(
        (let res (Struct))
        (let res (AddMember res '\"column0\" (\"+\" (Int64 '\"2\") (Int64 '\"2\"))))
        (let res (AsList res))
        (return res)
)
))))
      (return core)
)
))
", "action": "RUN", "type": "YQL"}
$ curl -X POST \
    -d @/var/tmp/query.yql \
    -H "Content-Type: application/json" \
    -H "Authorization: OAuth $YQL_TOKEN" \
    https://yql.yandex.net/api/v2/operations \
    # в ответе получаем id, далее аналогично SQL
```
</details>

## Websocket {#websocket}
Также HTTP API YQL предоставляет возможность получения push-уведомлений об изменении статусов операций через Websocket.

* URL для подключения (также требуется аутентификация): `wss://yql.yandex.net/websocket`
* Демо: <https://yql.yandex.net/api/ws/index2.html>

Сам протокол обмена сообщениями еще не до конца сформировался, будет подробнее описан позже, текущий вариант см. [в демо](https://yql.yandex.net/api/ws/index2.html).
