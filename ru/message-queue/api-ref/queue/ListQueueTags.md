# ListQueueTags

Метод для получения [меток очереди](../../concepts/tags.md).

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Поле | Тип | Описание
----- | ----- | -----
`Tags.N.*` | **array** | Массив меток очереди.

### Ошибки ListQueueTags {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

## Пример запроса {#request-example}

```
Action=ListQueueTags
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<?xml version="1.0"?>
<ListQueueTagsResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
    <ListQueueTagsResult>
        <Tag>
            <Key>environment</Key>
            <Value>production</Value>
        </Tag>
    </ListQueueTagsResult>
    <ResponseMetadata>
        <RequestId>02c89a6b-9fc0-564a-9ed1-c61b5cacdc6d</RequestId>
    </ResponseMetadata>
</ListQueueTagsResponse>
```
