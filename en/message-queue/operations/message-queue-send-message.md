# Sending messages

To send a message to a queue:

{% list tabs %}

- AWS CLI

   Run the following command in the terminal:

   ```bash
   aws sqs send-message \
     --message-body <message_text> \
     --queue-url <message_queue_URL> \
     --endpoint <endpoint>
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

- cURL

   Run the following command in the terminal:

   ```bash
   curl -X POST \
     --header 'Content-Type: application/x-www-form-urlencoded' \
     --data-urlencode 'Action=SendMessage' \
     --data-urlencode 'MessageBody=<message_text>' \
     --data-urlencode 'QueueUrl=<message_queue_URL>' \
     --user '<ACCESS_KEY_ID>:<SECRET_KEY>' \
     --aws-sigv4 'aws:amz:{{ region-id }}:sqs' \
     https://message-queue.{{ api-host }}/
   ```

   Where:

   * `header`: HTTP request headers.
   * `data-urlencode`: Parameters for [generating an API request](../api-ref/index.md). Use `MessageBody` and `QueueURL` to specify the message to send and the URL of the queue.
   * `user`: [Static key](../../iam/concepts/authorization/access-key.md) components (ID and secret key).
   * `aws-sigv4`: Parameter for generating AWS-compatible authorization headers.

   Result:

   ```text
   <?xml version="1.0" encoding="UTF-8"?>
   <SendMessageResponse><SendMessageResult><MD5OfMessageBody>fa46dfdbe2396ac930bfa89609c51603</MD5OfMessageBody><MessageId>31bebd6e-5b61e482-7aaaa45a-cdfc0acc</MessageId></SendMessageResult><ResponseMetadata><RequestId>7c65c427-be26a31a-cf93dee9-dd4989d8-ab97b54614e49d7fe560b7797c0b7576</RequestId></ResponseMetadata></SendMessageResponse>
   ```

{% endlist %}
