---
sourcePath: overlay/internals/errors_in_api_requests.md
---
## Определение ошибки по результату

### gRPC API

Результат выполнения запроса имеет тип `TYqlResponse`, в составе которого есть атрибут `KqpStatus`.
Он может принимать значение из перечня ниже.

### Python

Обработка ошибок в python-module описана в разделе про [python API]((../getting_started/start_python.md#_4)

## Перечень ошибок и краткое описание

В таблице перечислены все допустимые значения `KqpStatus`, для каждого есть принзак можно ли повторять запрос при получении ответа с таким статусом и дано краткое описание причин, которые приводят к ошибочным кодам ответов

&nbsp; | Код | IsRetryable | Описание
--|---|---|--
1 | STATUS_SUCCESS | Y | Нет ошибок, всё хорошо
2 | STATUS_BAD_REQUEST | N | Необходимо заполнить
3 | STATUS_PROCESS_ERROR | N | Необходимо заполнить
4 | STATUS_QUERY_ERROR | N | Необходимо заполнить
5 | STATUS_BAD_SESSION | N | Необходимо заполнить
6 | STATUS_NO_SESSION | N | Необходимо заполнить
7 | STATUS_BUSY_PENDING_QUERY | N | Необходимо заполнить
8 | STATUS_QUERY_TIMEOUT | N | Необходимо заполнить
9 | STATUS_LOCKS_INVALIDATED | Y | За время выполнения транзакции были изменены строки, на которые были взяты локи на чтение до начала транзакции.
10 | STATUS_LOCKS_ACQUIRE_FAILURE | Y | Необходимо заполнить
11 | STATUS_SCHEME_ERROR | N | Необходимо заполнить
12 | STATUS_TEMPORARILY_UNAVAILABLE | Y | Необходимо заполнить
13 | STATUS_OVERLOADED | Y | Необходимо заполнить


## Рецепты по устранению ошибок

### STATUS\_BAD\_REQUEST
### STATUS\_PROCESS\_ERROR
### STATUS\_QUERY\_ERROR
### STATUS\_BAD\_SESSION
### STATUS\_NO\_SESSION
### STATUS\_BUSY\_PENDING\_QUERY
### STATUS\_QUERY\_TIMEOUT
### STATUS\_LOCKS\_INVALIDATED
### STATUS\_LOCKS\_ACQUIRE\_FAILURE
### STATUS\_SCHEME\_ERROR
### STATUS\_TEMPORARILY\_UNAVAILABLE
### STATUS\_OVERLOADED