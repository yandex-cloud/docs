# TagQueue

Метод для задания [меток очереди](../../concepts/tags.md). Изменение меток может занять до 60 секунд.

Новая метка с ключом, идентичным ключу существующей метки, заменяет существующую метку.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди.
`Tags.N.*` | [список меток](#tags) | Да | Список меток очереди.

#### Метки {#tags}

Метки очереди. Метки передаются в виде списка. Подробнее о передаче списочных параметров см. [Использование API](../index.md#array-parameters).

```
Tag.N.Key (метка)
Tag.N.Value (значение метки)
```

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Ответ не содержит полей.

### Ошибки TagQueue {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

## Пример запроса {#request-example}

```
Action=TagQueue
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&Tag.1.Key=environment
&Tag.1.Value=production
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<TagQueueResponse>
    <ResponseMetadata>
        <RequestId>87acfbed-5254a88a-ef8d6306-e5fd93e-74626d14b02d992c99e5fa1b********</RequestId>
    </ResponseMetadata>
</TagQueueResponse>
```
