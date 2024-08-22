# Trigger for {{ container-registry-name }} that invokes a {{ serverless-containers-name }} container

A [trigger](../trigger/) for {{ container-registry-name }} invokes a {{ serverless-containers-name }} [container](../container.md) when specific events occur with a {{ container-registry-name }} [Docker image](../../../container-registry/concepts/docker-image.md). The trigger must be in the same cloud as the [registry](../../../container-registry/concepts/registry.md) whose events it is subscribed to.

A trigger for {{ container-registry-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the container.

For more information about creating a trigger for {{ container-registry-name }}, see [{#T}](../../operations/cr-trigger-create.md).

{% include [cr-event](../../../_includes/functions/cr-event.md) %}

{% include [batching-events](../../../_includes/serverless-containers/batching-events.md) %}

## Roles required for the proper operation of a trigger for {{ container-registry-name }} {#roles}

* To create a trigger, you need:
   * Permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.
   * The `{{ roles-cr-puller }}` role for the registry whose events are processed by the trigger.
* To run a trigger, the service account needs the `serverless.containers.invoker` role for the folder with the container to be invoked by the trigger.

Read more about [access management](../../security/index.md).

## {{ container-registry-name }} trigger message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [cr-format](../../../_includes/functions/cr-format.md) %}

## See also {#see-also}

* [{#T}](../../../functions/concepts/trigger/cr-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/cr-trigger.md)
