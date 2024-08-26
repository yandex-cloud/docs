# DeleteMessage

Метод для удаления сообщения из очереди. Чтобы указать, какое сообщение следует удалить, используйте параметр `ReceiptHandle`. Сообщение можно удалить, даже если сообщение получено и обрабатывается другим получателем. Message Queue автоматически удаляет сообщения, если период, указанный в параметре `RetentionPeriod` закончился.

Параметр `ReceiptHandle` связан с конкретным экземпляром сообщения. Если сообщение получено несколько раз, оно будет получать разные значения `ReceiptHandle`. Чтобы удалить сообщения, следует использовать самое последнее значение `ReceiptHandle`, иначе запрос выполнится, но сообщение может быть не удалено.

В некоторых случаях копии сообщения могут оставаться в стандартных очередях на одном из серверов, если он был недоступен в момент вызова метода удаления сообщения. Убедитесь, что ваше приложение идемпотентно и повторное получение сообщений не вызывает ошибок.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди, в которой находится сообщение.
`ReceiptHandle` | **string** | Да | Параметр `ReceiptHandle` из запроса `ReceiveMessage`.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Ответ не содержит полей.

### Ошибки DeleteMessage {#errors}

Перечень возможных ответов смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `InvalidIdFormat` | Некорректный формат `ReceiptHandle`.
400 | `ReceiptHandleIsInvalid` | Неверный параметр `ReceiptHandle`.

## Пример запроса {#request-example}

```text
Action=DeleteMessage
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&ReceiptHandle=EAEggPjXhogtKAA
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<DeleteMessageResponse>
    <ResponseMetadata>
        <RequestId>c79cd3cb-ffb474f7-9d5a8a3e-e5db06c-7c4ef5d027dd4219c28bf6c2********</RequestId>
    </ResponseMetadata>
</DeleteMessageResponse>
```
