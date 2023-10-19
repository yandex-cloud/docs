A [trigger](../../functions/concepts/trigger/index.md) for {{ sf-name }} launches a [function](../../functions/concepts/function.md) when certain events occur with a {{ container-registry-name }} [Docker image](../../container-registry/concepts/docker-image.md). The trigger must be in the same cloud as the [registry](../../container-registry/concepts/registry.md) to whose events it is subscribed.

A trigger for {{ container-registry-name }} needs a [service account](../../iam/concepts/users/service-accounts.md) to call the function.

For more information about creating a trigger for {{ container-registry-name }}, see [{#T}](../../functions/operations/trigger/cr-trigger-create.md).

{% include [cr-event](cr-event.md) %}

{% include [batching-events](batching-events.md) %}

## Roles required for the proper operation of a trigger for {{ container-registry-name }} {#roles}

* To create a trigger, you need:
   * Permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../iam/concepts/access-control/roles.md#editor) roles and higher.
   * The `{{ roles-cr-puller }}` role for the registry whose events the trigger handles.
* To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../../functions/security/index.md).

## Trigger for {{ container-registry-name }} message format {#format}

After the trigger is activated, it sends the following message to the function:

{% include [cr-format](cr-format.md) %}

## See also {#see-also}

* [Trigger for {{ container-registry-name }} that calls a {{ serverless-containers-name }} container](../../serverless-containers/concepts/trigger/cr-trigger.md).