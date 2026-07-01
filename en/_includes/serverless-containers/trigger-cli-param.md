* `--invoke-container-id`: Container ID.
* `--invoke-container-service-account-id`: ID of the service account with permissions to invoke the container.
* `--retry-attempts`: Number of invocation retries before the trigger moves a message to the dead-letter queue. This is an optional setting. The values may range from 1 to 5. The default value is 1.
* `--retry-interval`: Time to wait before retrying the container invocation if it fails. This is an optional setting. The values may range from 10 to 60 seconds. The default value is 10 seconds.
* `--dlq-queue-id`: Dead-letter queue ID. This is an optional setting.
* `--dlq-service-account-id`: ID of the service account with write permissions for the dead-letter queue. This is an optional setting.