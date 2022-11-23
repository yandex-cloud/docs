# Прием и удаление сообщений

После приема сообщений и их обработки их следует удалять из очереди:

{% list tabs %}

- AWS CLI
  
  Выполните в терминале команду:
  
  ```bash
  aws sqs receive-message \
    --queue-url <URL_очереди_сообщений> \
    --endpoint <эндпоинт>/
  ```
  
  Где:

  * `queue-url` — URL очереди сообщений, например: `https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue`.
  * `endpoint` — эндпоинт, например: `https://message-queue.{{ api-host }}/`.
  
  Результат:

  ```json
  {
      "Messages": [
          {
              "MessageId": "948de7-9ec8d787-cbf3465c-c",
              "ReceiptHandle": "EAEggbjIg_8sKAM",
              "MD5OfBody": "ed076287532e86365e841e92bfc50d8c",
              "Body": "Hello World",
              "Attributes": {
                  "ApproximateFirstReceiveTimestamp": "1545927269377",
                  "ApproximateReceiveCount": "1",
                  "SentTimestamp": "1545922344034"
              }
          }
      ]
  }
  ```
  
  Чтобы удалить сообщение, используйте значение параметра `receipt-handle` — [идентификатор получения](../concepts/message.md) для сообщения. Выполните в терминале команду:
  
  ```bash
  aws sqs delete-message \
    --queue-url <URL_очереди_сообщений> \
    --endpoint <эндпоинт>/ \
    --receipt-handle <идентификатор_получения>
  ```
 
  Где:

  * `queue-url` — URL очереди сообщений, например: `https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue`.
  * `endpoint` — эндпоинт, например: `https://message-queue.{{ api-host }}/`.
  * `receipt-handle` — идентификатор получения.
  
{% endlist %}
