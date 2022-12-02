Для описания ошибок в API используется сообщение [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto). Данная модель ошибок используется как в gRPC, так и в REST интерфейсах.

В [таблице ниже](#error-list) приведен список ошибок, которые поддерживаются в API.
Ознакомиться с .proto-спецификацией можно в [репозитории на GitHub](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

## Формат сообщения об ошибке {#error-message-format}

Сообщение `Status` содержит три поля:

Поле | Описание
----------- | -----------
`code` | <b>int32</b></br>gRPC-код ошибки. Доступные коды ошибок определены в [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).
`message` |<b>string</b></br>Описание ошибки.
`details` | <b>repeated google.protobuf.Any</b></br>Дополнительные сведения об ошибке. Поле содержит детальную информацию об ошибке, например, какие параметры были указаны некорректно.</br> </br>В [google.rpc.ErrorDetails](https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto) определены типы сообщений, которые используются в данном поле.

Ниже представлено gRPC-описание сообщения `Status`:

```protobuf
message Status {
  // gRPC-код ошибки. Доступные значения определены
  // в [google.rpc.Code].
  int32 code = 1;

  // Описание ошибки.
  string message = 2;

  // Детальная информация об ошибке.
  repeated google.protobuf.Any details = 3;
}
```

## Соответствие с HTTP {#http-mapping}

Соответствия gRPC-статусов с HTTP-кодами описаны в [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

Ниже приведен пример ошибки, которую может вернуть сервер в ответ на REST запрос:

```json
{
  "code": 16,
  "message": "Token is invalid or has expired.",
  "details": [
    {
      "@type": "type.googleapis.com/google.rpc.RequestInfo",
      "requestId": "e38e71c3-adc6-4584-98a4-b0f103d55f61"
    }
  ]
}
```

## Список возможных ошибок {#error-list}
gRPC-код | gRPC-статус | HTTP-код |Описание ошибки
----- | ----- | ----- | -----
1 | CANCELLED | 499 | Операция была прервана на стороне клиента.
2 | UNKNOWN | 500 | Неизвестная ошибка.
3 | INVALID_ARGUMENT | 400 | Клиент некорректно указал параметры запроса. Детальная информация представлена в поле `details`.
4 | DEADLINE_EXCEEDED | 504 | Превышено время ожидания ответа от сервера.
5 | NOT_FOUND | 404 | Запрашиваемый ресурс не найден.
6 | ALREADY_EXISTS | 409 | Попытка создать ресурс, который уже существует.
7 | PERMISSION_DENIED | 403 | Клиент не обладает необходимыми полномочиями для выполнения операции.
8 | RESOURCE_EXHAUSTED | 429 | Клиент превысил лимит запросов.
9 | FAILED_PRECONDITION | 400 | Операция отменена, так как не выполняются условия, необходимые для проведения операции. Примеры: попытка удалить непустой каталог или вызов команды rmdir для объекта, который не является каталогом.
10 | ABORTED | 409 | Операция была прервана из-за конфликта параллельных вычислений, таких как нарушение последовательности команд или прерванная транзакция.
11 | OUT_OF_RANGE | 400 | Выход за пределы диапазона. Например, поиск или чтение за границами файла.
12 | NOT_IMPLEMENTED | 501 | Операция не поддерживается сервисом.
13 | INTERNAL | 500 | Внутренняя ошибка сервера. Ошибка означает, что операция не может быть выполнена из-за технического состояния сервера. Например, из-за нехватки вычислительных ресурсов.
14 | UNAVAILABLE | 503 | Сервис на данный момент недоступен. Следует повторить запрос через несколько секунд.
15 | DATA_LOSS | 500 | Необратимая потеря или повреждение данных.
16 | UNAUTHENTICATED | 401 | Для выполнения операции необходима авторизация.