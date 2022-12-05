* `--invoke-container-id`: Container ID.
* `--invoke-container-service-account-id`: Service account with rights to invoke container.
* `--retry-attempts`: Time to retry invoking container if current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
* `--retry-interval`: The number of invocation retries before the trigger moves a message to the Dead Letter Queue. Optional. Values can be from 1 to 5. The default is 1.
* `--dlq-queue-id`: Dead Letter Queue ID. Optional.
* `--dlq-service-account-id`: Service account with rights to write messages to the Dead Letter Queue. Optional.