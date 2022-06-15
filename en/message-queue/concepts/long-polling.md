# Long Polling

The Long Polling technique is implemented to optimize the use of {{ message-queue-full-name }} by reducing the number of [ReceiveMessage](../api-ref/message/ReceiveMessage.md) requests sent to empty queues. Instead of making repeated requests, {{ message-queue-full-name }} lets consumers wait for messages to arrive in a queue and read them immediately. In addition, a longer poll time allows Long Polling to avoid false empty responses.

## Using {#set-up-long-polling}

You can use Long Polling by setting a non-zero value for the `WaitTimeSeconds` parameter of the `ReceiveMessage` method. This parameter determines how long a client will wait for messages to arrive in an empty queue. An empty response is returned to the client only after this time has passed. The maximum `WaitTimeSeconds` value is 20 sec.

In response to `ReceiveMessage`, at least one of the messages from the queue is returned. The maximum number of messages to return is limited by the `MaxNumberOfMessages` parameter.

## Advantages over Short Polling {#advantages}

Standard behavior of the `ReceiveMessage` method implies that the Short Polling technique is used: the method does not wait for messages to arrive in a queue, and only part of the queue's shards are polled when it is called. There might be no new messages in the selected shards, while new messages in the shards that have not been selected will remain unread. This results in false empty responses: `ReceiveMessage` reports no messages while there are messages in the queue.

Long Polling allows you to avoid false empty responses thanks to polling all the shards in the queue during the set wait time, and not just the shards selected when executing a request with the `WaitTimeSeconds` parameter set to zero.