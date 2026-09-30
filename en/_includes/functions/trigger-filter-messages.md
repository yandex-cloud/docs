## Filtering events {#filter-messages}

You can configure a filter for each resource invoked in a trigger. The filter is a [jq expression](https://jqlang.github.io/jq/manual/) applied to the event before delivery. The filter returns a boolean value. If the result is:
* `true`, the event is forwarded to the target.
* `false` or if the event fails to parse, the event is dropped and not sent.

Filters are defined separately for each target, i.e., a single trigger can deliver different events to different targets. If no filter is set, all events are sent to the target.
