## Message batching {#batching}

The batching settings allow sending several messages to WebSocket connections at a time. They set a top limit on a message batch size and its accumulation time. For example, if the message batch size is 3, WebSocket connections can receive batches containing from 1 to 3 messages.