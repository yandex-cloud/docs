# ChangeMessageVisibilityBatch

Метод для установки таймаута видимости группе сообщений в указанной очереди. Можно отправить до 10 вызовов `ChangeMessageVisibility` в одном вызове `ChangeMessageVisibilityBatch`.

Результаты изменения таймаута видимости для каждого сообщения возвращаются по отдельности. Поскольку изменение видимости может пройти как успешно, так и неуспешно, следует проверять все результаты, даже если ответ на вызов метода `ChangeMessageVisibilityBatch` вернулся с кодом 200.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди, в которой находится сообщение. Чувствителен к регистру.
`ChangeMessageVisibilityBatchRequestEntry.N` | **array** | Да | Массив [ChangeMessageVisibilityBatchRequestEntry](../data-types/ChangeMessageVisibilityBatchRequestEntry.md), содержащих параметры `ReceiptHandle` сообщений, которым требуется изменить таймауты видимости.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Поле | Тип | Описание
----- | ----- | -----
`BatchResultErrorEntry.N` | **array** | Массив [BatchResultErrorEntry](../data-types/BatchResultErrorEntry.md), содержащих ошибки выполнения запроса.
`ChangeMessageVisibilityBatchResultEntry.N` | **array** | Массив [ChangeMessageVisibilityBatchResultEntry](../data-types/ChangeMessageVisibilityBatchResultEntry.md) содержащий идентификаторы сообщений с успешно измененным таймаутом.

### Ошибки ChangeMessageVisibilityBatch {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `BatchEntryIdsNotDistinct` | Для двух или более сообщений в списке указаны одинаковые идентификаторы.
400 | `EmptyBatchRequest` | Не передано ни одного сообщения.
400 | `InvalidBatchEntryId` | Неправильный идентификатор сообщения в группе.
400 | `TooManyEntriesInBatchRequest` | Слишком большое количество сообщений в группе.

## Пример запроса {#request-example}

```
Action=ChangeMessageVisibilityBatch
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&ChangeMessageVisibilityBatchRequestEntry.1.Id=8b6f1be7-effe631a-7b3cb***-*****
&ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=EAUg9bz********
&ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=30
&ChangeMessageVisibilityBatchRequestEntry.2.Id=54fe7789-da6cfbfd-3664814a***-*****
&ChangeMessageVisibilityBatchRequestEntry.2.ReceiptHandle=EAEgrqv********
&ChangeMessageVisibilityBatchRequestEntry.2.VisibilityTimeout=30
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<ChangeMessageVisibilityBatchResponse>
    <ChangeMessageVisibilityBatchResult>
        <ChangeMessageVisibilityBatchResultEntry>
            <Id>8b6f1be7-effe631a-7b3cbef1***-*****</Id>
        </ChangeMessageVisibilityBatchResultEntry>
        <ChangeMessageVisibilityBatchResultEntry>
            <Id>54fe7789-da6cfbfd-3664814a***-*****</Id>
        </ChangeMessageVisibilityBatchResultEntry>
    </ChangeMessageVisibilityBatchResult>
    <ResponseMetadata>
        <RequestId>4e249f0e-74ac41aa-aa8c6354-12fd717f-a9761e7b848e70720ec61d81********</RequestId>
    </ResponseMetadata>
</ChangeMessageVisibilityBatchResponse>
```
