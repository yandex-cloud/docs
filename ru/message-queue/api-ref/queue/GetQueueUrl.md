# Метод GetQueueUrl

Метод для получения URL указанной очереди. Укажите имя очереди, чтобы получить ее URL.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueName` | **string** | Да | Имя очереди. Максимальная длина — 80 символов. В имени можно использовать цифры, буквы, подчеркивания и дефисы. Чувствительно к регистру.
`QueueOwnerAWSAccountId` | **string** | Нет | Параметр игнорируется.

## Ответ {#response}

### Поля ответа {#response-parameters}

Поле | Тип | Описание
----- | ----- | -----
`QueueUrl` | **string** | URL очереди.

### Ошибки GetQueueUrl {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `NonExistentQueue` | Очереди с указанным именем не существует.

## Пример запроса {#request-example}

```
Action=GetQueueUrl
&Version=2012-11-05
&QueueName=sample-queue
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<GetQueueUrlResponse>
    <GetQueueUrlResult>
        <QueueUrl>
            https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
        </QueueUrl>
    </GetQueueUrlResult>
    <ResponseMetadata>
        <RequestId>
            9637ef3c-d4356097-ea190ef9-e1d566f-c57b2cd6d7abea7ae7c94371********
        </RequestId>
    </ResponseMetadata>
</GetQueueUrlResponse>
```
