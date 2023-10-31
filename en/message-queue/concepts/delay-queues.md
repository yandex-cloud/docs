# Delay queues

You can hide messages when they're sent to a queue. This lets you postpone their delivery for a defined period time. You can configure the delay for an entire queue or an individual message.

## Delaying messages in queues {#delay-queues}

To configure hiding messages from a queue when sending them, set the **{{ ui-key.yacloud.ymq.queue.form.field_sending-delay }}** parameter when [creating a new queue](../operations/message-queue-new-queue.md) or change it for an existing one. The maximum delay period for message delivery is 15 minutes.

Changing the delay setting for standard queues does not affect the delay of messages that are already in the queue. For FIFO queues, changing the delay setting affects the delay of messages already in the queue.

Delay queues are similar to [visibility timeouts](visibility-timeout.md). The difference between the two features is that, for delay queues, a message is hidden immediately after it is added to a queue, while for visibility timeouts a message is hidden only after it is consumed from the queue.

## Delivery delay on individual messages {#delay-messages}

Individual messages can be hidden immediately after they are added to a queue. This is set using the `DelaySeconds` parameter of the [SendMessage](../api-ref/message/SendMessage.md) method. A hidden message cannot be consumed from the queue during the specified time. The maximum time a message can be hidden is 15 minutes. FIFO queues do not support per-message delays.

The per-message delay has a higher priority than the delay set on an entire queue. For example, if a message with a 10-minute delivery delay is added to a queue that has a 5-minute delay set, this message is hidden for 10 minutes.
