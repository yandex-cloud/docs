# Trigger for {{ container-registry-name }} that sends messages to WebSocket connections

A [trigger](../trigger/) for {{ container-registry-name }} sends messages to [WebSocket connections](../extensions/websocket.md) when certain events occur with a {{ container-registry-name }} [Docker image](../../../container-registry/concepts/docker-image.md). The trigger must be in the same cloud as the [registry](../../../container-registry/concepts/registry.md) whose events it is subscribed to.

A trigger for {{ container-registry-name }} requires a [service account](../../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.

For more information about creating a trigger for {{ container-registry-name }}, see [{#T}](../../operations/trigger/cr-trigger-create.md).

{% include [cr-event](../../../_includes/functions/cr-event.md) %}

{% include [batching-events](../../../_includes/api-gateway/batching-events.md) %}

## Roles required for the proper operation of a trigger for {{ container-registry-name }} {#roles}

* To create a trigger, you need:
   * Permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.
   * The `{{ roles-cr-puller }}` role for the registry whose events are processed by the trigger.
* To activate a trigger, the service account needs the `api-gateway.websocketBroadcaster` role for the folder containing the API gateway.

Read more about [access management](../../security/index.md).

## {{ container-registry-name }} trigger message format {#format}

After the trigger fires, it will send the following message to WebSocket connections:

{% include [cr-format](../../../_includes/functions/cr-format.md) %}

## See also {#see-also}

* [Trigger for {{ container-registry-name }} that runs a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/cr-trigger.md)
* [Trigger for {{ container-registry-name }} that runs a {{ sf-name }} function](../../../functions/concepts/trigger/cr-trigger.md)