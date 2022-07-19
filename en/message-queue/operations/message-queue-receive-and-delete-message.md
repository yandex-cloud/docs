# Receiving and deleting messages

After messages are received and processed, they should be deleted from a queue:

{% list tabs %}

- AWS CLI

   Run the following command in the terminal:

   ```bash
   aws sqs receive-message \
     --endpoint https://message-queue.{{ api-host }}/ \
     --queue-url https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue
   ```

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

   To delete a message, use the `receipt-handle` parameter value of the received message. Run the following command in the terminal:

   ```bash
   aws sqs delete-message \
     --endpoint https://message-queue.{{ api-host }}/ \
     --queue-url https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
     --receipt-handle EAEggbjIg_8sKAM
   ```

{% endlist %}
