* `name`: Trigger name. The name format is as follows:

   {% include [name-format](../name-format.md) %}

* `description`: Trigger description.

* `function`: Function parameters:

   * `id`: Function ID.
   * `service_account_id`: ID of the service account with permissions to invoke the function.
   * `retry_attempts`: Number of invocation retries before the trigger moves a message to the dead-letter queue. This is an optional parameter. The values may range from 1 to 5. The default value is 1.
   * `retry_interval`: Time until another attempt is made to invoke the function if the current attempt fails. This is an optional parameter. The values may range from 10 to 60 seconds. The default value is 10 seconds.