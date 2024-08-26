# Объект Operation

Каждая операция, которая изменяет состояние ресурса, приводит к созданию объекта [Operation](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation.proto). Этот объект содержит информацию об операции: статус, идентификатор, время вызова и т. д.

С помощью объекта `Operation` вы можете:

- [Отслеживать статус операций](#monitoring), которые занимают неопределенное время. Например, запуск [виртуальной машины](../../glossary/vm.md) или подключение диска.
- [Отменять операции](#cancel).
- [Просматривать список операций](#operation-listing), которые были выполнены над заданным ресурсом.

## Формат объекта Operation {#operation-format}

Объект `Operation` содержит поля:

Поле |  Описание
----- | -----
`id`* | <b>string</b><br/>Идентификатор операции. Генерируется на стороне сервиса.
`created_at`* | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)<br/>Время запуска операции. Указывается в формате [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt).
`created_by`* |  <b>string</b><br/>Идентификатор пользователя, запустившего операцию.
`modified_at`* | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)<br/>Время последнего изменения ресурса. Указывается в формате [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt).
`done`* | <b>bool</b><br/>Статус операции. Принимает одно из двух значений:<br/><q>true</q> — операция завершена. Обратите внимание, операция считается завершенной, даже если в ходе ее выполнения возникла ошибка.<br/><q>false</q> — операция не завершена.
`response` | [google.protobuf.Any](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/any.proto)<br/>Поле присутствует только в том случае, если операция была успешно завершена.<br/><br/> Для методов `Create` и `Update` поле `response` содержит представление созданного или измененного ресурса. Для других операций поле может содержать пустое сообщение [google.protobuf.Empty](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/empty.proto) (например, при удалении ресурса).<br/></br>Поля `response` и `error` являются взаимоисключающими. Ответ не может одновременно содержать оба поля.
`error` | [google.rpc.Status](https://github.com/grpc/grpc/blob/master/src/proto/grpc/status/status.proto)<br/>Сообщение об ошибке. Поле присутствует в том случае, если в ходе выполнения операции возникла ошибка.<br/><br/><br/>Поле `error` может появиться в ответе до того, как операция была завершена: когда возникает ошибка, сервис сразу добавляет поле `error` в объект `Operation`. Одновременно с этим сервис начинает откатываться к предыдущему состоянию: завершает все запущенные процедуры и удаляет ресурсы, которые были созданы в ходе операции. Только когда сервис вернется к предыдущему состоянию, операция будет считаться завершенной и значение ее поля `done` будет выставлено в <q>true</q>.<br/><br/>Поля `response` и `error` являются взаимоисключающими. Ответ не может одновременно содержать оба поля.
`metadata` | [google.protobuf.Any](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/any.proto)<br/>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает объект `Operation`, в описании метода приведена структура соответствующего ему поля `metadata`.
`description` | <b>string</b><br/>Описание операции. Максимальная длина составляет 256 символов.

\* Обязательное поле.

## Отслеживание статуса операции {#monitoring}

Узнать статус операции можно с помощью метода [Get](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation_service.proto):
```protobuf
 // Возвращает объект Operation по заданному идентификатору.
 rpc Get (GetOperationRequest) returns (operation.Operation) {
   option (google.api.http) = {
     get: "/operations/{operation_id}"
   };
 }
 message GetOperationRequest {
   // Идентификатор операции.
   string operation_id = 1;
 }
```

Пример REST запроса на получение статуса операции:
```http
GET https://operation.{{ api-host }}/operations/fcmq0j5033e516c56ctq
```

## Отмена операции {#cancel}

Отменить операцию можно с помощью метода [Cancel](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation_service.proto):

```protobuf
 // Отменяет заданную операцию.
 rpc Cancel (CancelOperationRequest) returns (operation.Operation) {
   option (google.api.http) = {
     post: "/operations/{operation_id}:cancel"
   };
 }
 message CancelOperationRequest {
   // Идентификатор операции, которую нужно отменить.
   string operation_id = 1;
 }
```

Пример отмены операции в REST:
```http
POST https://operation.{{ api-host }}/operations/a3s17h9sbq5asdgss12:cancel
```
В ответ сервер вернет объект `Operation`, который будет содержать текущий статус отменяемой операции.

Отменять можно только те операции, которые изменяют состояние ресурсов. В справочниках все операции, для которых возможна отмена, отмечены явно.

{% note info %}

Метод `Cancel` работает по принципу Best Effort. Вызов метода не гарантирует, что операция будет отменена. Операция может находиться на стадии, когда отмена уже невозможна.

{% endnote %}

## Просмотр списка операций {#operation-listing}

Для просмотра списка операций, которые были выполнены над заданным ресурсом, предназначен метод `ListOperations`. Метод поддерживает [постраничное отображение результатов](pagination.md).

Обратите внимание, метод `ListOperations` позволяет получить список операций только над конкретным ресурсом, но не над категорией ресурсов. Например, вы не сможете посмотреть историю операций, которые производились над всеми дисками в вашем облаке.

Пример gRPC-описания метода [ListOperations](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) для просмотра списка операций над диском:
```protobuf
 // Выводит список операций, которые были произведены над заданным диском.
 rpc ListOperations (ListDiskOperationsRequest)
   returns (ListDiskOperationsResponse) {
     option (google.api.http) = {
       get: "/compute/v1/disks/{disk_id}/operations"
     };
   }
 message ListDiskOperationsRequest {
   // Идентификатор диска.
   string disk_id = 1;
   // Максимальное количество результатов на странице ответа.
   int64 page_size = 2;
   // Токен запрашиваемой страницы с результатами.
   string page_token = 3;
 }

 message ListDiskOperationsResponse {
   // Список операций, выполненных над заданным диском.
   repeated operation.Operation operations = 1;
   // Токен следующей страницы с результатами.
   string next_page_token = 2;
 }
```

{% include [page-size-field](../_includes/page-size-field.md) %}

Пример запроса списка операций в REST:
```http
GET https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03/operations
```
Ответ сервера:
```json
 {
   "operations": [
     {
       "id": "fcmq0j5033e516c56ctq",
       "createdAt": "2018-08-29T18:31:15.311Z",
       "createdBy": "v1swrh5sbqs5sdgss15",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateDiskMetadata",
         "diskId": "sfg36d6sbq5asdgfs01"
       },
      "response": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.Disk",
        "id": "sfg36d6sbq5asdgfs01",
        "folderId": "a3s17h9sbq5asdgss12",
        "name": "disk-1",
        "description": "Test disk",
        "zoneId" : "{{ region-id }}-a",
        "typeId" : "network-nvme",
        "size" : 10737418240
      }
    },
    ...
   ]
 }
```
