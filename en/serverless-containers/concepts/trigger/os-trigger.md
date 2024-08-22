# Trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container

A [trigger](../trigger/) for {{ objstorage-name }} runs a {{ serverless-containers-name }} [container](../container.md) when a specific event occurs with a {{ objstorage-name }} [object](../../../storage/concepts/object.md). The trigger must be in the same cloud as the bucket whose events it is subscribed to.

A trigger for {{ objstorage-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the container.

For more information about creating a trigger for {{ objstorage-name }}, see [{#T}](../../operations/os-trigger-create.md).

{% include [os-event](../../../_includes/functions/os-event.md) %}

{% include [batching-events](../../../_includes/serverless-containers/batching-events.md) %}

## Roles required for the proper operation of a trigger for {{ objstorage-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.
* To run a trigger, the service account needs the `serverless.containers.invoker` role for the folder with the container to be invoked by the trigger.

Read more about [access management](../../security/index.md).

## {{ objstorage-name }} trigger message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [os-format](../../../_includes/functions/os-format.md) %}

## See also {#see-also}

* [{#T}](../../../functions/concepts/trigger/os-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/os-trigger.md)
