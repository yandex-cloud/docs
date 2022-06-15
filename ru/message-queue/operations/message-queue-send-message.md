# Отправка сообщений

Чтобы отправить сообщение в очередь:

{% list tabs %}

- AWS CLI
  
  Выполните в терминале команду:
  
  ```bash
  aws sqs send-message \
    --message-body "Hello World" \
    --endpoint https://message-queue.{{ api-host }}/ \
    --queue-url https://message-queue.{{ api-host }}/aoeaql9r10cd9cfue7v6/000000000000002l034r/sample-queue
  ```

  Результат:

  ```
  {
      "MD5OfMessageBody": "67e63db14341b5a696596634bbf19796", 
      "MessageId": "765ff4d2-fa4bc83-6cfcc68e-21a49"
  }
  ```

{% endlist %}
