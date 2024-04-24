# SendMessageBatch

Метод для одновременной отправки до десяти сообщений в указанную очередь. При отправке сообщений в очередь FIFO они будут поступать в порядке отправления.

Результаты отправки для каждого сообщения возвращаются по отдельности. Поскольку отправка для сообщений может пройти как успешно, так и неуспешно, следует проверять все результаты, даже если ответ на вызов метода `SendMessageBatch` вернулся с кодом 200. Сообщение может содержать структуры XML, JSON и неформатированный текст. Поддерживаются следующие юникод-символы:

* `#x9`
* `#xA`
* `#xD`
* с `#x20` по `#xD7FF`
* с `#xE000` по `#xFFFD`
* с `#x10000` по `#x10FFFFF`

Максимальный размер всей группы сообщений — 256 КБ.

Если для сообщения в группе не указан параметр `DelaySeconds`, то будет использован параметр для очереди по умолчанию.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`SendMessageBatchRequestEntry.N` | **array** | Да | Массив [SendMessageBatchRequestEntry](../data-types/SendMessageBatchRequestEntry.md).
`QueueUrl` | **string** | Да | URL очереди, в которую посылаются сообщения.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Поле | Тип | Описание
----- | ----- | -----
`BatchResultErrorEntry.N` | **array** | Массив [BatchResultErrorEntry](../data-types/BatchResultErrorEntry.md), содержащих сведения о сообщениях, которые не удалось добавить в очередь.
`SendMessageBatchResultEntry.N` | **array** | Массив [SendMessageBatchResultEntry](../data-types/SendMessageBatchResultEntry.md), содержащий сведения об успешно отправленных в очередь сообщениях.

### Ошибки SendMessageBatch {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `BatchEntryIdsNotDistinct` | Для двух или более сообщений в списке указаны одинаковые идентификаторы.
400 | `BatchRequestTooLong` | Общая длина сообщений превышает разрешенный лимит.
400 | `EmptyBatchRequest` | Не передано ни одного сообщения.
400 | `InvalidBatchEntryId` | Неправильный идентификатор сообщения в группе.
400 | `TooManyEntriesInBatchRequest` | Слишком большое количество сообщений в группе.
400 | `UnsupportedOperation` | Неподдерживаемая операция.

## Пример запроса {#request-example}

```
Action=SendMessageBatch
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&SendMessageBatchRequestEntry.1.Id=123********
&SendMessageBatchRequestEntry.1.MessageBody=HelloWorld
&SendMessageBatchRequestEntry.2.Id=321********
&SendMessageBatchRequestEntry.2.MessageBody=WorldHello
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<SendMessageBatchResponse>
    <SendMessageBatchResult>
        <SendMessageBatchResultEntry>
            <Id>321********</Id>
            <MD5OfMessageBody>aa1e70b237224fdeff0d04e8********</MD5OfMessageBody>
            <MessageId>13b0e327-8aa4cd4e-92feed42***-*****</MessageId>
        </SendMessageBatchResultEntry>
        <SendMessageBatchResultEntry>
            <Id>123********</Id>
            <MD5OfMessageBody>68e109f0f40ca72a15e05cc2********</MD5OfMessageBody>
            <MessageId>10e93fc8-266eb1c1-15e67924***-*****</MessageId>
        </SendMessageBatchResultEntry>
    </SendMessageBatchResult>
    <ResponseMetadata>
        <RequestId>7b4175bf-4a7a7572-94e7a240-15ccbeb-c3d59faf841a51e0fd1184b1********</RequestId>
    </ResponseMetadata>
</SendMessageBatchResponse>
```
