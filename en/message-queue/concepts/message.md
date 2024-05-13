# Messages

Messages are sent through queues and can contain plain text in the body. Messages are received by consumers that delete them from the queue after processing.

A message can be in one of the following three states:

* A message is sent to a queue by the producer. If a message is sent to a queue but has not yet been accepted by a consumer, it is assumed to be in the queue.
* The message is received by the consumer. If the message is received by the consumer but has not yet been deleted from the queue, it is assumed that it is being processed.
* The message is deleted from the queue.

Standard queues can process up to 120,000 messages at once. To avoid exceeding the limit, messages should be deleted from the queue without considerable delay. FIFO queues can process up to 20,000 messages at once.

A message contains several fields:

1. Message body.
1. A set of message attributes indicating its sending time, the number of message receipts, and the time of its first receipt by the consumer.
1. Message receipt ID. Each time a message is received from the queue, an ID is generated to indicate that the message has been received. This ID is used when deleting the received message from the queue or changing its [visibility timeout](visibility-timeout.md). A message must be received by a consumer before being deleted. If a message is received more than once, it will be assigned a new receipt ID each time. Use the most recent ID to delete the message or change its visibility timeout.
1. Hash sum of the message body.
1. Message ID. Each message is assigned a unique ID that is returned in response to the [SendMessage](../api-ref/message/SendMessage.md) method call. This ID can be used to access messages, but to delete them from the queue, use the message receipt ID: `ReceiptHandle`.

View of a message with plain text and without any additional parameters:

~~~
{
            "Body": "Sample message",
            "Attributes": {
                "ApproximateFirstReceiveTimestamp": "1544718635323",
                "ApproximateReceiveCount": "1",
                "SentTimestamp": "1544718633138"
            },
            "ReceiptHandle": "EAsgu6Kfw_osKAE",
            "MD5OfBody": "5b792970792ac60da66329aa********",
            "MessageId": "fa6bcfb7-6f121e1d-fb3b33aa***-*****"
}
~~~
