# Объект Operation


Каждая операция, которая изменяет состояние ресурса, приводит к созданию объекта
 `Operation`. Этот объект содержит информацию об операции: статус,
 идентификатор, время вызова и т. д. [Подробнее о формате объекта Operation](#operation-format)

С помощью объекта `Operation` вы можете:
 
- [Отслеживать статус операций](#monitoring),
 которые занимают неопределенное время. К таким операциям относится, например, запуск виртуальной машины или подключение диска.
- [Отменять операции](#cancel).

## Формат объекта Operation {#operation-format}

Объект
 `Operation` представлен в формате JSON:

```json
{
  "id": "<string>",
  "createdAt": "<string>",
  "createdBy": "<string>",
  "modifiedAt": "<string>",
  "done": <boolean>,
 ["response": <object>,]
 ["error": <object>,]
 ["metadata": <object>,]
 ["description": "<string>"]
}
```

Поле | Тип | Описание
----- | ----- | -----
`id` * | string | Идентификатор операции.
`createdAt` * | string  | Время запуска операции. Указывается в формате [[RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt)].
`createdBy` * |  string | Идентификатор пользователя, запустившего операцию. Указывается в формате [[RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt)].
`modifiedAt` * | string | Время последнего изменения ресурса. Указывается в формате [[RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt)].
`done` * | boolean | Статус операции. Принимает одно из двух значений:<br/><q>true</q> — операция завершена. Обратите внимание, операция считается завершенной, даже если в ходе ее выполнения возникла ошибка.<br/><q>false</q> — операция не завершена.
`response` | object | Поле присутствует только в том случае, если операция была завершена (поле `done` выставлено в <q>true</q>). <br/><br/> Для операций create и update поле `response` содержит JSON-представление созданного или измененного ресурса. Для других операций поле может содержать пустой JSON (например, при удалении ресурса).<br/><br/>Поля `response` и `error` являются взаимоисключающими. Ответ не может одновременно содержать оба поля.
`error` | object | Поле присутствует в том случае, если в ходе выполнения операции возникла ошибка. Содержит описание ошибки.<br/><br/> Поле `error` может появиться в ответе до того, как операция была завершена. Когда возникает ошибка, сервис сразу добавляет поле `error` в объект `Operation`. Одновременно с этим сервис начинает откатываться к предыдущему состоянию: завершает все запущенные процедуры и удаляет ресурсы, которые были созданы в ходе операции. Только когда сервис вернется к предыдущему состоянию, операция будет считаться завершенной и значение ее поля `done` будет выставлено в <q>true</q>.<br/><br/>Поля `response` и `error` являются взаимоисключающими. Ответ не может содержать одновременно оба поля.
`metadata` | object | Метаданные операции. В gRPC это поле имеет тип google.protobuf.Any. В формат JSON это поле преобразуется по правилам, указанным в [таблице](https://developers.google.com/protocol-buffers/docs/proto3#json) (см. тип Any).
`description` | string | Описание операции. Максимальная длина составляет 256 символов.

\* Обязательное поле.

## Отслеживание статуса операции {#monitoring}

Чтобы узнать статус операции, необходимо с помощью GET-запроса получить нужный объект
 `Operation`. Статус операции будет отображаться в поле
 `done`.
 
> Пример отслеживания статуса операции.<br/>
> Отправим запрос на создание диска:
> 
> ```
> POST https://compute.api.cloud.yandex.net/compute/v1/disks
>
> {
>   "folderId": "a3s17h9sbq5asdgss12",
>   "name": "disk-1",
>   "description": "Test disk",
>   "zoneId" : "ru-central1-a",
>   "typeId" : "network-nvme"
>   "size" : 10737418240   
> }
> ```
> 
> В теле ответа будет объект `Operation`:
> 
> ```json
> {
>  "id": "fcmq0j5033e516c56ctq",
>  "createdAt": "2018-08-29T18:31:15.311Z",
>  "createdBy": "v1swrh5sbqs5sdgss15",
>  "done": false,
>  "metadata": {
>   "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateDiskMetadata",
>   "diskId": "sfg36d6sbq5asdgfs01"
>  }
> }
> ```
> 
> Спустя некоторое время проверим статус операции. Для этого отправим запрос:
> 
> ```
> GET https://operation.api.cloud.yandex.net/operations/fcmq0j5033e516c56ctq
> ```
> 
> В ответ сервер вернет JSON-представление объекта `Operation`.
> 
> ```json
> {
>   "id": "fcmq0j5033e516c56ctq",
>   "createdAt": "2018-08-29T18:31:15.311Z",
>   "createdBy": "v1swrh5sbqs5sdgss15",
>   "done": true,
>   "metadata": {
>     "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateDiskMetadata",
>     "diskId": "sfg36d6sbq5asdgfs01"
>   },
>  "response": {
>    "@type": "type.googleapis.com/yandex.cloud.compute.v1.Disk",
>    "id": "sfg36d6sbq5asdgfs01",
>    "folderId": "a3s17h9sbq5asdgss12",
>    "name": "disk-1",
>    "description": "Test disk",
>    "zoneId" : "ru-central1-a",
>    "typeId" : "network-nvme",
>    "size" : 10737418240 
>  }
> }
> ```

## Отмена операции {#cancel}

Отменить операцию можно с помощью метода `cancel`. Пример:

```
POST https://operation.api.cloud.yandex.net/operations/a3s17h9sbq5asdgss12:cancel
```

В ответ сервер вернет новый объект `Operation`. Он будет содержать статус
 операции удаления.

Отменять можно только те операции, которые изменяют состояние ресурсов. В справочниках к API
 все операции, для которых возможна отмена, отмечены явно.

> [!NOTE]
>
> Метод `cancel` работает по принципу Best Effort. Вызов метода не
 гарантирует, что операция будет отменена. Операция может находиться на стадии, когда
 отмена уже невозможна.

