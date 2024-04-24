# SetQueueAttributes

Метод для задания атрибутов указанной очереди. Изменение атрибутов может занять до 60 секунд. Изменение атрибута `MessageRetentionPeriod` может занять до 15 минут.

## Запрос {#request}

### Параметры запроса {#request-parameters}

Параметр | Тип | Обязательный параметр | Описание
----- | ----- | ----- | -----
`QueueUrl` | **string** | Да | URL очереди.
`Attributes.N.*` | [список атрибутов](#attributes) | Да | Список атрибутов очереди.

#### Атрибуты {#attributes}

Атрибуты очереди. Атрибуты передаются в виде списка. Подробнее о передаче списочных параметров см. [Использование API](../index.md#array-parameters).

```
Attribute.N.Name (атрибут)
Attribute.N.Value (значение атрибута)
```

Атрибут | Тип | Описание
----- | ----- | -----
`DelaySeconds` | **integer** | Время в секундах, на которое сообщения будут [скрыты после отправки](../../concepts/delay-queues.md#delay-queues). Возможные значения от 0 до 900 секунд (15 минут). Значение по умолчанию: 0.
`MaximumMessageSize` | **integer** | Максимальный размер сообщения в байтах. Возможные значения: 1024 байта (1 КБ) до 262144 байт (256 КБ). Значение по умолчанию: 262144 (256 КБ).
`MessageRetentionPeriod` | **integer** | Срок хранения сообщений в секундах. Возможные значения: от 60 секунда (1 минута) до 1209600 секунд (14 дней). Значение по умолчанию: 345600 (4 дня).
`ReceiveMessageWaitTimeSeconds` | **integer** | Время ожидания для метода [ReceiveMessage](../message/ReceiveMessage) в секундах. Возможные значения: от 0 to 20 секунд. Значение по умолчанию: 0.
`RedrivePolicy` | **string** | Политика перенаправления сообщений в [Dead Letter Queue](../../concepts/dlq.md). Тип исходной очереди и очереди DLQ должны быть одинаковыми: для очередей FIFO очередь DLQ тоже должна быть очередью FIFO. Включает два параметра: <ul><li>`deadLetterTargetArn` — ARN очереди, в которую будут перенаправляться сообщения. ARN очереди можно получить с помощью вызова метода [GetQueueAttributes](GetQueueAttributes.md).</li><li>`maxReceiveCount` — максимальное количество попыток считывания сообщения из очереди перед перенаправлением в DLQ. Когда значение параметра `ReceiveCount` у сообщения превышает значение `maxReceiveCount`, сообщение перенаправляется в DLQ.</li></ul>
`VisibilityTimeout` | **integer** | [Таймаут видимости](../../concepts/visibility-timeout.md) сообщений в очереди в секундах. Возможные значения: от 0 до 43000 секунд. Значение по умолчанию: 30.

#### Атрибуты очередей FIFO {#fifo-path-parameters}

Атрибут | Описание
----- | -----
`ContentBasedDeduplication` | Флаг, включающий [дедупликацию по содержимому сообщения](../../concepts/deduplication.md#content-based-deduplication). Возможные значения: `true` или `false`.

#### Неподдерживаемые атрибуты {#non-supported-attributes}

Атрибут | Тип | Описание
----- | ----- | -----
`KmsMasterKeyId` | **string** | Атрибут не поддерживается в {{ message-queue-full-name }}.
`KmsDataKeyReusePeriodSeconds` | **string** | Атрибут не поддерживается в {{ message-queue-full-name }}.

## Ответ {#response}

### Поля успешного ответа {#response-parameters}

Ответ не содержит полей.

### Ошибки SetQueueAttributes {#errors}

Перечень общих для всех методов ошибок смотрите в разделе [{#T}](../common-errors.md).

Код HTTP | Идентификатор ошибки | Описание
----- | ----- | -----
400 | `InvalidAttributeName` | Неверное имя атрибута.

## Пример запроса {#request-example}

```
Action=SetQueueAttributes
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&Attribute.1.Name=DelaySeconds
&Attribute.1.Value=10
&Attribute.2.Name=VisibilityTimeout
&Attribute.2.Value=20
```

Подробнее о формировании запросов см. в разделе [Общий вид запросов к API](../index.md#api-request).

## Пример ответа {#response-example}

```xml
<SetQueueAttributesResponse>
    <ResponseMetadata>
        <RequestId>87acfbed-5254a88a-ef8d6306-e5fd93e-74626d14b02d992c99e5fa1b********</RequestId>
    </ResponseMetadata>
</SetQueueAttributesResponse>
```
