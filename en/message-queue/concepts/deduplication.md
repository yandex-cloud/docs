# Deduplication

FIFO queues implement message deduplication by using a special set of parameters. These parameters ensure that messages are delivered and processed only once and in the order in which they are sent.

## ID-based deduplication {#deduplication-id}

Messages that are sent to a FIFO queue are assigned an ID used for deduplication of enqueued messages (`MessageDeduplicationId`). If a message with an ID is received, all other messages with the same ID will be queued but will not be delivered to a consumer within the 5-minute deduplication interval. If no ID is specified, the message will not be sent to a FIFO queue.

Each message sent to a FIFO queue must have a unique deduplication ID. If a message is delivered, duplicate messages with the same ID will not be delivered.

The `MessageDeduplicationId` parameter is available to the message consumer and can be used for troubleshooting message delivery issues.

If a message is sent successfully but the response acknowledging its receipt is lost, Message Queue will not detect a duplicate if a message with the same ID arrives after the deduplication window.

## Content-based deduplication {#content-based-deduplication}

Content-based deduplication can be enabled on a queue. Messages sent to such a queue without a deduplication ID will be assigned one automatically. The ID is generated using an SHA-256 hash of the message body.

The deduplication mechanism depends on the settings for queue and message deduplication:

1. If a sent message has no deduplication ID and content-based deduplication is disabled on a FIFO queue, an error will be returned to the producer.
1. If the sent message has a deduplication ID and content-based deduplication is enabled on the FIFO queue, the ID value from the message will be used.

Messages with duplicate content arriving in a queue with content-based deduplication enabled during the deduplication window are considered duplicates, and only one copy of the message is delivered to a consumer.

If you send a message to a queue with content-based deduplication enabled and then send another message with the same content but with a deduplication ID, both messages will be considered duplicates and only one of them will be delivered to a consumer.

## Repeated attempts to receive messages {#request-attempts}

When receiving a message from a FIFO queue, the  receive request attempt ID is used (`ReceiveRequestAttemptId`).

If an application lost its connection to Message Queue, this ID can be used to retrieve a set of messages again. The parameter can be used for 5 minutes after calling the `ReceiveMessage` method. When requesting messages, you can specify the ID explicitly or use automatically generated IDs.

Repeated attempts to receive messages with the same `ReceiveRequestAttemptId` are possible if the content and visibility of a message have not changed. During the visibility timeout, repeated requests for messages with the same `ReceiveRequestAttemptId` will return the same messages with the identical `ReceiptHandle`.

