# ListQueues

Метод для получения списка очередей в каталоге. Максимальное количество очередей в ответе — 1000. Очереди можно отфильтровать с помощью параметра `QueueNamePrefix`.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueNamePrefix` | **string** | Нет | Префикс для фильтрации имен очередей. Чувствителен к регистру.

## Ответ {#response}

Перечень возможных ответов смотрите в разделе [{#T}](../common-errors.md).

### Поля успешного ответа {#response-parameters}

Поле | Тип | Описание
----- | ----- | -----
`QueueUrl.N` | **array** | Массив строк URL очередей. До 1000 записей.

### Ошибки ListQueues {#errors}

Метод не возвращает специальных ошибок. Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

## Пример запроса {#request-example}

```text
Action=ListQueues
&Version=2012-11-05
&QueueNamePrefix=test
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#request-example}

```xml
<ListQueuesResponse>
    <ListQueuesResult>
        <QueueUrl>
            https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
        </QueueUrl>
        </ListQueuesResult>
    <ResponseMetadata>
        <RequestId>
            ccb047ed-a4807112-c601522a-e5f876d-b1837e78119702da4e347fdd********
        </RequestId>
    </ResponseMetadata>
</ListQueuesResponse>
```
