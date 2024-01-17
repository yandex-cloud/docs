* `--invoke-container-id`: Container ID.
* `--invoke-container-service-account-id`: Service account with rights to invoke the container.
* `--retry-attempts`: Number of invocation retries before the trigger moves a message to the dead letter queue. This is an optional parameter. The values may range from 1 to 5. The default value is 1.
* `--retry-interval`: Time to retry invoking the container if the current attempt fails. This is an optional parameter. The values may range from 10 to 60 seconds. The default value is 10 seconds.
* `--dlq-queue-id`: Dead letter queue ID. This is an optional parameter.
* `--dlq-service-account-id`: Service account with the permission to write messages to the dead letter queue. Optional parameter.