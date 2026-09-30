## Transforming events {#transform-messages}

For each target in a trigger, you can specify a [jq](https://jqlang.github.io/jq/manual/) transformation template that is used to transform the event before it is sent. You can use transformation, e.g., to:

* Convert the event to the format expected by the target.
* Keep only the required fields in the event.
* Add custom fields and values to the event.

The template is defined separately for each target, so one trigger can send different representations of the same event to different targets. If no template is specified, the event is sent to the target as is.
