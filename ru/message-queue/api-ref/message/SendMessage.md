# SendMessage

Метод для отправки сообщения в указанную очередь. В теле сообщения можно передавать только XML, JSON и неформатированный текст.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`DelaySeconds` | **integer** | Нет | Время в секундах, на которое сообщение будет [скрыто после отправки](../../concepts/delay-queues.md#delay-messages). Возможные значения: от 0 до 900. Если параметр не указан, используется значение параметра из очереди. Параметр не работает для сообщений, отправляемых в очереди FIFO — в этом случае используется параметр из очереди.
`MessageAttributeName.N`<br/>`MessageAttributeValue.N` | **array** | Нет | Массив имен и соответствующих им значений пользовательских атрибутов сообщения. См. тип данных [Message](../data-types/Message.md).
`QueueUrl` | **string** | Да | URL очереди, в которой находится сообщение.
`MessageBody` | **string** | Да | Тело отправляемого сообщения. Максимальный размер — 256 КБ. Может содержать структуры XML, JSON и неформатированный текст. Поддерживаются следующие символы Unicode: <ul><li>`#x9`</li> <li>`#xA`</li> <li>`#xD`</li> <li>`от #x20 до #xD7FF`</li> <li>`от #xE000 до #xFFFD`</li> <li>`от #x10000 до #x10FFFF`</li></ul>

#### Параметры очередей FIFO {#fifo-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`MessageDeduplicationId` | **string** | Да | Идентификатор токена для дедупликации сообщений, используется в очередях FIFO. Каждое сообщение должно иметь уникальный `MessageDeduplicationId`. Если `MessageDeduplicationId` не указан, отправка сообщения в очередь не будет выполнена. Максимальная длина — 128 символов. Разрешено использование цифр, больших и маленьких латинских букв и знаков пунктуации. Подробнее см. [Дедупликация](../../concepts/deduplication.md).
`MessageGroupId` | **string** | Да | Идентификатор группы сообщений, используется в очередях FIFO. Максимальная длина — 128 символов. Разрешено использование цифр, больших и маленьких латинских букв и знаков пунктуации. Подробнее см. [Дедупликация](../../concepts/deduplication.md).

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Поле | Тип | Описание
----- | ----- | -----
`MD5OfMessageAttributes` | **string** | MD5-хэш строки атрибута.
`MD5OfMessageBody` | **string** | MD5-хэш тела сообщения.
`MessageId` | **string** | Идентификатор отправленного сообщения.
`SequenceNumber` | **string** | Номер сообщения, используется в очередях FIFO в рамках группы сообщений с одинаковым `MessageGroupId`. Длина номера — 128 бит, `SequenceNumber` наращивается в пределах группы с одинаковым `MessageGroupId`.

### Ошибки SendMessage {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `UnsupportedOperation` | Неподдерживаемая операция.
400 | `InvalidMessageContents` | В сообщении есть запрещенные символы.

## Пример запроса {#request-example}

```
Action=SendMessage
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&MessageBody=Hello+world
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<SendMessageResponse>
    <SendMessageResult>
        <MD5OfMessageBody>3e25960a79dbc69b674cd4ec********</MD5OfMessageBody>
        <MessageId>cddcbbe4-b0571f5c-d7b94ce4***-*****</MessageId>
    </SendMessageResult>
    <ResponseMetadata>
        <RequestId>75eb03b2-fba0e60e-b1c5641-12f7a5bc-2bf4e677831c06c5f9d7ea10********</RequestId>
    </ResponseMetadata>
</SendMessageResponse>
```
