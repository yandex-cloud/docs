* `--invoke-function-id`: Function ID.
* `--invoke-function-service-account-id`: Service account with rights to invoke the function.
* `--retry-attempts`: Number of invocation retries before the trigger moves a message to the Dead Letter Queue. This is an optional parameter. You can specify values from 1 to 5, 1 being default.
* `--retry-interval`: Time after which the function will be invoked again if the current attempt fails. This is an optional parameter. You can specify values from 10 to 60 seconds, 10 being default.
* `--dlq-queue-id`: Dead Letter Queue ID. This is an optional parameter.
* `--dlq-service-account-id`: Service account with the permission to write messages to the Dead Letter Queue. This is an optional parameter.