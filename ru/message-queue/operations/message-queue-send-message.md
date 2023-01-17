# Отправка сообщений

Чтобы отправить сообщение в очередь:

{% list tabs %}

- AWS CLI
  
  Выполните в терминале команду:
  
  ```bash
  aws sqs send-message \
    --message-body <текст_сообщения> \
    --queue-url <URL_очереди_сообщений> \
    --endpoint <эндпоинт>
  ```

  Где:

  * `message-body` — текст сообщения, например `"Hello World"`.
  * `queue-url` — URL очереди сообщений, например: `https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue`.
  * `endpoint` — эндпоинт, например: `https://message-queue.{{ api-host }}/`.
  
  Результат:

  ```json
  {
      "MD5OfMessageBody": "67e63db14341b5a696596634bbf19796", 
      "MessageId": "765ff4d2-fa4bc83-6cfcc68e-21a49"
  }
  ```
  
- cURL
  
  Выполните в терминале команду:
  
  ```
  curl -X POST \                          
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'Action=SendMessage' \
    --data-urlencode 'MessageBody=<текст_сообщения>' \
    --data-urlencode 'QueueUrl=<URL очереди сообщений>' \
    --user 'ACCESS_KEY:<SECRET_KEY>' \
    --aws-sigv4 'aws:amz:{{ region-id }}:sqs' \ 
    https://message-queue.{{ api-host }}/
  ```

- cURL

  Выполните в терминале команду:

  ```bash
  curl -X POST \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'Action=SendMessage' \
    --data-urlencode 'MessageBody=<текст_сообщения>' \
    --data-urlencode 'QueueUrl=<URL_очереди_сообщений>' \
    --user '<ACCESS_KEY_ID>:<SECRET_KEY>' \
    --aws-sigv4 'aws:amz:ru-central1:sqs' \
    https://message-queue.api.cloud.yandex.net/
  ```

  Где:

  * `header` — заголовки HTTP-запроса.
  * `data-urlencode` — параметры для [формирования запроса к API](../api-ref/index.md). С помощью `MessageBody` и `QueueURL` укажите сообщение для отправки и URL очереди.
  * `user` — компоненты [статического ключа](../../iam/concepts/authorization/access-key.md): идентификатор и секретный ключ.
  * `aws-sigv4` — параметр для формирования AWS-совместимых заголовков авторизации.

  Результат:

  ```text
  <?xml version="1.0" encoding="UTF-8"?>
  <SendMessageResponse><SendMessageResult><MD5OfMessageBody>fa46dfdbe2396ac930bfa89609c51603</MD5OfMessageBody><MessageId>31bebd6e-5b61e482-7aaaa45a-cdfc0acc</MessageId></SendMessageResult><ResponseMetadata><RequestId>7c65c427-be26a31a-cf93dee9-dd4989d8-ab97b54614e49d7fe560b7797c0b7576</RequestId></ResponseMetadata></SendMessageResponse>
  ```

{% endlist %}
