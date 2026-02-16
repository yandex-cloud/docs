# UntagQueue

Метод для удаления [меток очереди](../../concepts/tags.md). Изменение меток может занять до 60 секунд.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди.
`TagKeys.N` | **array** | Да | Список ключей.

#### Список ключей {#tag-keys}

Список ключей для удаления соответствующих меток очереди. Метки передаются в виде списка.

```
TagKey.N (ключ)
```

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Ответ не содержит полей.

### Ошибки UntagQueue {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

## Пример запроса {#request-example}

```
Action=UntagQueue
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&TagKey.1=environment
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<UntagQueueResponse>
    <ResponseMetadata>
        <RequestId>87acfbed-5254a88a-ef8d6306-e5fd93e-74626d14b02d992c99e5fa1b********</RequestId>
    </ResponseMetadata>
</UntagQueueResponse>
```
