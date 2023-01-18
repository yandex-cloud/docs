# Receiving and deleting messages

After messages are received and processed, they should be deleted from a queue:

{% list tabs %}

- AWS CLI

   Run the following command in the terminal:

   ```bash
   aws sqs receive-message \
     --queue-url <message_queue_URL> \
     --endpoint <endpoint>/
   ```

   Where:

   * `queue-url`: Message queue URL, for example: `https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue`.
   * `endpoint`: Endpoint, for example: `https://message-queue.{{ api-host }}/`.

   Result:

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

   To delete a message, use the value of the `receipt-handle` parameter, that is, the ID of the message [receipt](../concepts/message.md). Run the following command in the terminal:

   ```bash
   aws sqs delete-message \
     --queue-url <message_queue_URL> \
     --endpoint <endpoint>/ \
     --receipt-handle <receipt_ID>
   ```

   Where:

   * `queue-url`: Message queue URL, for example: `https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue`.
   * `endpoint`: Endpoint, for example: `https://message-queue.{{ api-host }}/`.
   * `receipt-handle`: Message receipt ID.

{% endlist %}
