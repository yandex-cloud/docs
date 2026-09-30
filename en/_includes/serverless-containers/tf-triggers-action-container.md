* `action`: Target settings. You can specify this section multiple times so the trigger calls multiple resources, including those of different types. There are [limits](../../serverless-containers/concepts/limits.md#serverless-containers-limits) on the maximum number of resources.

    * `invoke_container`: Container settings:

        * `container_id`: Container ID.
        * `path`: HTTP path to call the container at. This is an optional parameter.
        * `service_account_id`: ID of the service account with permissions to invoke the container.

    {% include [tf-trigger-params](../functions/tf-trigger-params.md) %}
