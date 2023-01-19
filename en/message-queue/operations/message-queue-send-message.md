# Sending messages

To send a message to a queue:

{% list tabs %}

- AWS CLI

   Run the following command in the terminal:

   ```bash
   aws sqs send-message \
     --message-body <message_text> \
     --queue-url <message_queue_URL> \
     --endpoint <endpoint>/
   ```

   Where:

   * `message-body`: The text of the message, for example, `"Hello World"`.
   * `queue-url`: Message queue URL, for example: `https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue`.
   * `endpoint`: Endpoint, for example: `https://message-queue.{{ api-host }}/`.

   Result:

   ```json
   {
       "MD5OfMessageBody": "67e63db14341b5a696596634bbf19796",
       "MessageId": "765ff4d2-fa4bc83-6cfcc68e-21a49"
   }
   ```

{% endlist %}
