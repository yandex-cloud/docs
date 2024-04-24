# DeleteMessageBatch

Метод для удаления нескольких сообщений из очереди. Удалять можно не более 10 сообщений одновременно.

Результаты изменения таймаута видимости для каждого сообщения возвращаются по отдельности. Поскольку удаление сообщения может пройти как успешно, так и неуспешно, следует проверять все результаты, даже если ответ на вызов метода `DeleteMessageBatch` вернулся с кодом 200.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди, в которой находится сообщение.
`DeleteMessageBatchRequestEntry.N` | **array** | Да | Массив [DeleteMessageBatchRequestEntry](../data-types/DeleteMessageBatchRequestEntry.md), содержащий параметры `ReceiptHandle` сообщений, которые требуется удалить.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Поле | Тип | Описание
----- | ----- | -----
`BatchResultErrorEntry.N` | **array** | Массив `BatchResultErrorEntry`, содержащий ошибки выполнения запроса.
`DeleteMessageBatchResultEntry.N` | **array** | Массив [DeleteMessageBatchResultEntry](../data-types/DeleteMessageBatchResultEntry.md) содержащий идентификаторы успешно удаленных сообщений.

### Ошибки DeleteMessageBatch {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `BatchEntryIdsNotDistinct` | Для двух или более сообщений в списке имеют одинаковые идентификаторы..
400 | `EmptyBatchRequest` | Не передано ни одного сообщения.
400 | `InvalidBatchEntryId` | Неправильный идентификатор сообщения в группе.
400 | `TooManyEntriesInBatchRequest` | Слишком большое количество сообщений в группе.

## Пример запроса {#request-example}

```
Action=DeleteMessageBatch
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&DeleteMessageBatchRequestEntry.1.Id=dd2dd32b-eb1e7a37-f6b7a725***-*****
&DeleteMessageBatchRequestEntry.1.ReceiptHandle=EAEg89f********
&DeleteMessageBatchRequestEntry.2.Id=7e0e07f6-5c9a0a72-d304102f***-*****
&DeleteMessageBatchRequestEntry.2.ReceiptHandle=EAEgq5v********
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<DeleteMessageBatchResponse>
    <DeleteMessageBatchResult>
        <DeleteMessageBatchResultEntry>
            <Id>dd2dd32b-eb1e7a37-f6b7a725***-*****</Id>
        </DeleteMessageBatchResultEntry>
        <DeleteMessageBatchResultEntry>
            <Id>7e0e07f6-5c9a0a72-d304102f***-*****</Id>
        </DeleteMessageBatchResultEntry>
    </DeleteMessageBatchResult>
    <ResponseMetadata>
        <RequestId>e02ca0b-5e6b6d98-cef0a99c-150a53b3-07ee55365ba1b6fd876875f0********</RequestId>
    </ResponseMetadata>
</DeleteMessageBatchResponse>
```
