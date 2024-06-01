---
title: "How to send messages in {{ message-queue-full-name }}"
description: "Follow this guide to send messages."
---

# Sending messages

Messages are sent through [message queues](../concepts/queue.md) in {{ message-queue-name }} and may contain plain text in the message body. Consumers get messages and delete them from the queue after receiving and processing them.

To send a message to a queue:

1. If you do not have a message queue in {{ message-queue-name }}, [create](message-queue-new-queue.md) one.
1. Run the following command in the terminal:

   {% list tabs group=programming_language %}

   - AWS CLI {#aws_cli}

      ```bash
      aws sqs send-message \
        --message-body "<message_text>" \
        --endpoint <endpoint> \
        --queue-url <queue_URL>
      ```

      Where:

      * `--message-body`: Text of the message to be sent to the queue, e.g., `Hello World`.
      * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
      * `--queue-url`: URL of the queue the message is sent to.

      Result:

      ```json
      {
          "MD5OfMessageBody": "67e63db14341b5a696596634********",
          "MessageId": "765ff4d2-fa4bc83-6cfcc***-*****"
      }
      ```

   - cURL {#curl}

      ```bash
      curl -X POST \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode 'Action=SendMessage' \
        --data-urlencode 'MessageBody=<message_text>' \
        --data-urlencode 'QueueUrl=<message_queue_URL>' \
        --user '<access_key_ID>:<secret_key>' \
        --aws-sigv4 'aws:amz:{{ region-id }}:sqs' \
        https://message-queue.{{ api-host }}/
      ```

      Where:

      * `--header`: HTTP request headers.
      * `--data-urlencode`: Parameters for [generating an API request](../api-ref/index.md).
         * `MessageBody`: Text of the message to be sent to the queue.
         * `QueueURL`: URL of the queue the message will be sent to.
      * `--user`: [Static key](../../iam/concepts/authorization/access-key.md) components (ID and secret key).
      * `--aws-sigv4`: Parameter for generating AWS-compatible authorization headers.

      Result:

      ```text
      <?xml version="1.0" encoding="UTF-8"?>
      <SendMessageResponse><SendMessageResult><MD5OfMessageBody>fa46dfdbe2396ac930bfa896********</MD5OfMessageBody><MessageId>31bebd6e-5b61e482-7aaaa45a***-*****</MessageId></SendMessageResult><ResponseMetadata><RequestId>7c65c427-be26a31a-cf93dee9-dd4989d8-ab97b54614e49d7fe560b779********</RequestId></ResponseMetadata></SendMessageResponse>
      ```

   {% endlist %}
