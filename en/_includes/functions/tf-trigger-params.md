* `filter`: Filtering events before sending them to the target. This is an optional section.

    * `jq`: [jq template](https://jqlang.github.io/jq/manual/) to filter events sent to the target. It not specified, all events reach the target.

* `transformer`: Transforming events before sending them to the target. This is an optional section.

    * `jq`: jq template to transform events before sending them to the target. It omitted, no transformations apply to the events.

* `retry_policy`: Repeated request settings. This is an optional section.

    * `interval`: Time interval before a retry attempt to send the event if the current attempt fails.
    * `retry_attempts`: Number of retry attempts before the trigger moves the event to the dead-letter queue.

* `dead_letter`: Dead-letter queue settings. This is an optional section.

    * `dead_letter_queue`: Queue settings:

        * `queue_arn`: Queue ARN.
        * `service_account_id`: ID of the service account with permissions to write to the queue.
        * `message_attributes`: Attributes to add to each message in the queue, in `key:value` format. This is an optional parameter.
