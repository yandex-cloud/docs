# Trigger for {{ container-registry-name }} that invokes a {{ serverless-containers-name }} container

A {{ container-registry-name }} [trigger](../trigger/) invokes a {{ serverless-containers-name }} [container](../container.md) when certain events occur with a {{ container-registry-name }} [Docker image](../../../container-registry/concepts/docker-image.md). The trigger must be in the same cloud as the [registry](../../../container-registry/concepts/registry.md) whose events it's subscribed to.

A trigger for {{ container-registry-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the container.

For more information about creating a trigger for {{ container-registry-name }}, see [{#T}](../../operations/cr-trigger-create.md).

{% include [cr-event](../../../_includes/functions/cr-event.md) %}

## Roles required for the proper operation of a trigger for {{ container-registry-name }} {#roles}

* To create a trigger, you need:
   * Permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
   * The `{{ roles-cr-puller }}` role for the registry whose events the trigger handles.
* To run a trigger, the service account needs the `serverless.containers.invoker` role for the folder with the container to be invoked by the trigger.

Read more about [access management](../../security/index.md).

## Trigger for {{ container-registry-name }} message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [cr-format](../../../_includes/functions/cr-format.md) %}

## See also {#see-also}

* [Trigger for {{ container-registry-name }} that invokes a {{ sf-name }} function](../../../functions/concepts/trigger/cr-trigger.md).