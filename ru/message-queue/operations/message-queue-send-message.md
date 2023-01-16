# Отправка сообщений

Чтобы отправить сообщение в очередь:

{% list tabs %}

- AWS CLI
  
  Выполните в терминале команду:
  
  ```bash
  aws sqs send-message \
    --message-body <текст_сообщения> \
    --queue-url <URL очереди сообщений> \
    --endpoint <эндпоинт>/
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
    --aws-sigv4 'aws:amz:ru-central1:sqs' \ 
    https://message-queue.api.cloud.yandex.net/
  ```

{% endlist %}
