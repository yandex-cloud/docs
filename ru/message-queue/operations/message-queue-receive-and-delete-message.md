# Прием и удаление сообщений

После приема сообщений и их обработки их следует удалять из очереди:

{% list tabs %}

- AWS CLI
  
  Выполните в терминале команду:
  
  ```bash
  aws sqs receive-message \
    --endpoint https://message-queue.api.cloud.yandex.net/ \
    --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue
  ```
  
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
  
  Чтобы удалить сообщение, используйте значение параметра `receipt-handle` полученного сообщения. Выполните в терминале команду:
  
  ```bash
  aws sqs delete-message \
    --endpoint https://message-queue.api.cloud.yandex.net/ \
    --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
    --receipt-handle EAEggbjIg_8sKAM
  ```

{% endlist %}
