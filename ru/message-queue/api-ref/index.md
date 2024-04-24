# {{ message-queue-full-name }} API

{{ message-queue-full-name }} предоставляет HTTP [API](../../glossary/rest-api.md), частично совместимый с Amazon SQS API.

## Выполнение запроса к API {#api-request}

Для выполнения запроса к API {{ message-queue-full-name }} необходимо выполнить POST запрос по пути `/` на адрес `https://message-queue.{{ api-host }}`.

```
POST / HTTP/1.1
Host: message-queue.{{ api-host }}
Content-Length: length
Content-Type: application/x-www-form-urlencoded
Authorization: authorization string (AWS Signature Version 4)

Request parameters
```

### Заголовки запроса {#request-headers}

Все запросы должны содержать стандартные заголовки:

* `Content-Type` — `application/x-www-form-urlencoded`.
* `Authorization` — Подпись запроса согласно разделу [Authenticating Requests](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-api-request-authentication.html) документации Amazon SQS. При использовании [SDK или консольного клиента](../instruments/index.md) запрос и подпись запроса формируются автоматически, вам необходимо только передавать параметры запроса.

### Параметры запроса {#request-parameters}

Все запросы должны содержать стандартные параметры:

* `Action` — название вызываемого метода API.
* `Version` — всегда равен `2012-11-05`.

Параметры передаются в теле запроса, в формате [form-urlencoded](https://en.wikipedia.org/wiki/Percent-encoding).

### Передача массивов параметров {#array-parameters}

Некоторые параметры сообщения, например, атрибуты сообщения или очереди, передаются в виде массивов. Каждый элемент массива передается в виде двух или более параметров запроса. Например, для атрибутов это имя и значение элемента массива.

Пример использования атрибута из нескольких параметров:

```
Attribute.1.Name=VisibilityTimeout
Attribute.1.Value=40
Attribute.2.Name=MessageRetentionPeriod
Attribute.2.Value=1000
```

В этом примере атрибутом 1 служит `VisibilityTimeout`, которому присваивается значение 40 и атрибутом 2 — `MessageRetentionPeriod`, которому присваивается значение 1000.

## Ответ на запрос к API {#api-response}

В ответ на запрос {{ message-queue-name }} возвращает XML-структуру, содержащую результат запроса.

### Успешный ответ {#success}

Если запрос выполнился успешно, основной элемент ответа получает название по имени вызываемого метода с добавлением суффикса `Response` (`<Action> + "Response"`).

Этот элемент содержит следующие дочерние элементы:

Тег | Описание
----- | -----
`ActionNameResult` | Содержит элементы, зависящие от вызываемого метода. Возможные элементы описаны в документации каждого метода. Например, `CreateQueueResult` содержит элемент `QueueUrl`, который содержит URL созданной очереди.
`ResponseMetadata` | Содержит `RequestId`, который, в свою очередь, содержит UUID запроса.

Пример успешного ответа:

```
<?xml version="1.0" encoding="UTF-8"?>
<CreateQueueResponse>
   <CreateQueueResult>
      <QueueUrl>https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue</QueueUrl>
   </CreateQueueResult>
   <ResponseMetadata>
      <RequestId>3c9b76fb-f35fb266-48e9c5bf-faca-ddc10b592cfce6ffdf83329a********</RequestId>
   </ResponseMetadata>
</CreateQueueResponse>
```

### Ошибочный ответ {#error}

Если запрос выполнился с ошибкой, основной элемент носит название `ErrorResponse`. Этот элемент содержит дочерние элементы `Error` и `RequestId`.

Элемент Error содержит следующие дочерние элементы:

Тег | Описание
----- | -----
`Type` | Тип ошибки, указывающий, на чьей стороне произошла ошибка: отправителя или получателя.
`Code` | Идентификатор ошибки.<br/><br/>Перечень стандартных ошибок смотрите в разделе [{#T}](common-errors.md).
`Message` | Описание ошибки на английском языке.
`Detail` | Дополнительные сведения об ошибке (опционально).

Элемент `RequestId` содержит UUID запроса.

Пример ответа с ошибкой:

```xml
<ErrorResponse>
   <Error>
      <Type>Sender</Type>
      <Code>InvalidParameterValue</Code>
      <Message>
         Value (queuename_nonalpha) for parameter QueueName is invalid.
         Must be an alphanumeric String of 1 to 80 in length.
      </Message>
   </Error>
   <RequestId>42d59b56-7407-4c4a-be0f-4c88********</RequestId>
</ErrorResponse>
```
