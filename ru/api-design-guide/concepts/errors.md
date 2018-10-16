# Обработка ошибок
Если операция завершилась успешно, сервер возвращает клиенту статус OK. Если в
 ходе выполнения операции возникла ошибка, сервер возвращает сообщение с
описанием ошибки.

Для описания ошибок в API используется сообщение [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto).
Данная модель ошибок используется как в gRPC, так и в REST интерфейсах. 

В [таблице](#error-list) можно ознакомиться со списком ошибок, которые поддерживаются в API на данный момент. 

## Формат сообщения об ошибке
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
  // в google.rpc.Code.
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

>```json
> {
>   "error": {
>     "code": "499",
>     "message": "The operation was cancelled, typically by the caller.",
>     "status": "CANCELLED",
>     "details": [{
>       "@type": "type.googleapis.com/google.rpc.RetryInfo",
>       ...
>     }]
>   }
> }
>```

## Список возможных ошибок {#error-list}
HTTP | gRPC | Описание ошибки
----- | ----- | -----
400 | INVALID_ARGUMENT | Клиент некорректно указал параметры запроса. Детальная информация представлена в поле `details`.
401 | UNAUTHENTICATED | Для выполнения операции необходима авторизация.
403 | PERMISSION_DENIED	 | Клиент не обладает необходимыми полномочиями для выполнения операции.
404 | NOT_FOUND | Запрашиваемый ресурс не найден.
409 | ALREADY_EXISTS | Попытка создать ресурс, который уже существует.
429 | RESOURCE_EXHAUSTED | Клиент превысил лимит запросов. 
499 | CANCELLED | Операция была прервана на стороне клиента.
500 | UNKNOWN | Неизвестная ошибка.
500 | INTERNAL | Внутренняя ошибка сервера. Ошибка означает, что операция не может быть выполнена из-за технического состояния сервера. Например, из-за нехватки вычислительных ресурсов.
501 | NOT_IMPLEMENTED | Операция не поддерживается сервисом.
503 | UNAVAILABLE| Сервис на данный момент недоступен. Следует повторить запрос через несколько секунд.

## Обработка ошибок в асинхронных вызовах {#async-errors}
При вызове асинхронных операций сервер возвращает объект [Operation](operation.md). В случае возникновения ошибки,
сообщение `Status` будет добавлено в объект `Operation` в поле `error`. 


