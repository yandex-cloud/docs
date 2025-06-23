## Event batching {#batching}

The grouping settings allow sending several events to WebSocket connections in one go. They set a top limit on event group size and on event group accumulation time. For example, if the event group size is 3, WebSocket connections can receive groups containing from 1 to 3 events.
