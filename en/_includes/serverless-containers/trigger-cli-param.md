* `--invoke-container-id`: Container ID.
* `--invoke-container-service-account-id`: Service account with rights to invoke the container.
* `--retry-attempts`: Time to retry invoking the container if the current attempt fails. Optional parameter. The values may range from 10 to 60 seconds. The default value is 10 seconds.
* `--retry-interval`: Number of invocation retries before the trigger moves a message to the Dead Letter Queue. Optional parameter. The values may range from 1 to 5. The default value is 1.
* `--dlq-queue-id`: Dead Letter Queue ID. Optional parameter.
* `--dlq-service-account-id`: Service account with the permission to write messages to the Dead Letter Queue. Optional parameter.