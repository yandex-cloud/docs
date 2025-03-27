* `--invoke-function-id`: Function ID.
* `--invoke-function-service-account-id`: ID of the service account with permissions to call the function.
* `--retry-attempts`: Number of invocation retries before the trigger sends a message to the dead-letter queue. This is an optional parameter. The values may range from 1 to 5. The default value is 1.
* `--retry-interval`: Time after which the function will be invoked again if the current attempt fails. This is an optional parameter. The values may range from 10 to 60 seconds. The default value is 10 seconds.
* `--dlq-queue-id`: Dead-letter queue ID. This is an optional parameter.
* `--dlq-service-account-id`: ID of the service account with write permissions for the dead-letter queue. This is an optional parameter.