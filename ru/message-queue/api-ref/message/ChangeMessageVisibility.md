# ChangeMessageVisibility

Метод для установки таймаута видимости сообщению, находящемуся в обработке. Суммарная длительность таймаута не может быть более 12 часов.

Пример: есть сообщение с таймаутом видимости в пять минут. Спустя три минуты вызывается `ChangeMessageVisibility` с новым таймаутом в десять минут. Можно повышать таймаут видимости, постепенно увеличивая значение параметра `MessageVisibility`, пока не будет достигнут разрешенный максимум. Если суммарное время таймаута превысит 12 часов, запрос будет отклонен.

При попытке установить таймаут видимости больше, чем оставшееся время до разрешенного максимума, Message Queue вернет ошибку.

Значение таймаута, заданное сообщению с помощью `ChangeMessageVisibility`, не сохраняется навсегда. Если сообщение было принято, но не было удалено из очереди, его таймаут видимости вернется к начальному значению при следующей попытке считать сообщение из очереди.

Подробнее о видимости сообщений см. [Сообщения](../../concepts/message.md) и [Таймаут видимости](../../concepts/visibility-timeout.md).

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди, в которой находится сообщение.
`ReceiptHandle` | **string** | Да | Параметр `ReceiptHandle` из запроса `ReceiveMessage`.
`VisibilityTimeout` | **integer** | Да | Новое значение [таймаута видимости](../../concepts/visibility-timeout.md) сообщений в очереди в секундах. Возможные значения: от 0 до 43200 секунд. Значение по умолчанию: 30.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Ответ не содержит полей.

### Ошибки ChangeMessageVisibility {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `MessageNotInflight` | Сообщение не находится в обработке.
400 | `ReceiptHandleIsInvalid` | Указан неверный параметр `ReceiptHandle`.

## Пример запроса {#request-example}

```
Action=ChangeMessageVisibility
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&ReceiptHandle=EAIgloPDh4gtKAI
&VisibilityTimeout=35
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<ChangeMessageVisibilityResponse>
    <ResponseMetadata>
        <RequestId>4ead5a64-f3b95d31-f3705dcf-150cb879-666abba2bcc160987e4d9e46********</RequestId>
    </ResponseMetadata>
</ChangeMessageVisibilityResponse>
```
