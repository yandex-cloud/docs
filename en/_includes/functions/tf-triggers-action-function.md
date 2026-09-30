* `action`: Target settings. You can specify this section multiple times so that the trigger calls multiple resources, including those of different types. There are [limits](../../functions/concepts/limits.md#functions-limits) on the maximum number of resources.

    * `invoke_function`: Function settings:

        * `function_id`: Function ID.
        * `function_tag`: Function version tag. This is an optional parameter. If it is not specified, the latest version of the function is called.
        * `service_account_id`: ID of the service account with permissions to invoke the function.

    {% include [tf-trigger-params](tf-trigger-params.md) %}
