# Trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container

[Triggers](../trigger/) for {{ objstorage-name }} invoke a {{ serverless-containers-name }} [container](../container.md) when a certain event occurs with a {{ objstorage-name }} [object](../../../storage/concepts/object.md). The trigger must be in the same cloud as the bucket whose events it's subscribed to.

A trigger for {{ objstorage-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the container.

{% include [os-event](../../../_includes/functions/os-event.md) %}

## Roles required for the proper operation of a trigger for {{ objstorage-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, the service account needs the `serverless.containers.invoker` role for the folder with the container to be invoked by the trigger.

Read more about [access management](../../security/index.md).

## Trigger for {{ objstorage-name }} message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [os-format](../../../_includes/functions/os-format.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function](../../../functions/concepts/trigger/os-trigger.md).