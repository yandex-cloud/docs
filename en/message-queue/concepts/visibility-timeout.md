# Visibility timeout

The visibility timeout is the period during which messages are hidden from a queue after one of the consumers has picked a message. As long as the message is hidden, other consumers cannot fetch the message from the queue. During the timeout period, the consumer has to process the message and delete it from the queue. If the message is not deleted when the visibility timeout is reached, it reappears in the queue and can be picked by other consumers.

The minimum visibility timeout is 30 seconds, the maximum one is 12 hours. You can extend the visibility timeout of a specified message by calling `ChangeMessageVisibility`.

