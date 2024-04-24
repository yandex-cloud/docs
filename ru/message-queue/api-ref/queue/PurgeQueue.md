# PurgeQueue

Метод для очистки очереди сообщений. Удаление сообщений занимает некоторое время. Чтобы убедиться, что в очереди не осталось сообщений, приостановите отправку сообщений в очередь и вызовите метод [GetQueueAttributes](GetQueueAttributes.md).

Сообщения, отправленные в очередь до вызова `PurgeQueue` могут быть приняты получателями, но будут удалены из очереди в течение следующей минуты.

Сообщения, отправленные в очередь после вызова `PurgeQueue` не будут удалены.

{% note alert %}

Удаленные из очереди сообщения невозможно восстановить.

{% endnote %}

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди. Чувствителен к регистру.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Ответ не содержит полей.

### Ошибки PurgeQueue {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `NonExistentQueue` | Указанная очередь не существует.
403 | `PurgeQueueInProgress` | Для указанной очередь уже был вызван метод `PurgeQueue` за последние 60 секунд.

## Пример запроса {#request-example}

```
Action=PurgeQueue
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<PurgeQueueResponse>
    <ResponseMetadata>
        <RequestId>c89ea19f-37d3a529-58142774-e25a26f-2618ff0043df35a802b77c94********</RequestId>
    </ResponseMetadata>
</PurgeQueueResponse>
```
