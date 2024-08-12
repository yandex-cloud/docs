# Trigger for {{ objstorage-name }} that sends messages to WebSocket connections

A [trigger](../trigger/) for {{ objstorage-name }} sends messages to [WebSocket connections](../extensions/websocket.md) when a specific event occurs with an {{ objstorage-name }} [object](../../../storage/concepts/object.md). The trigger must be in the same cloud as the bucket whose events it is subscribed to.

A trigger for {{ objstorage-name }} requires a [service account](../../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.

For more information about creating a trigger for {{ objstorage-name }}, see [{#T}](../../operations/trigger/os-trigger-create.md).

## Events for setting up a trigger {#event}

Events with bucket objects that can be tracked using a trigger:
- [Creating an object](../../../storage/operations/objects/upload.md).
- [Editing an object ACL](../../../storage/operations/objects/edit-acl.md).
- [Deleting an object](../../../storage/operations/objects/delete.md).

### Filtering events by object {#filter}

Events are filtered using prefixes and suffixes for an object [key](../../../storage/concepts/object.md#key).
* The prefix is the part of the object key that contains the beginning of the object key.
* The suffix is the part of the object key that contains the end of the object key.

Prefixes and suffixes can be of any length. When using a prefix and suffix at the same time, filtering is based on the logical `AND`: for the trigger to work, the object key must match both the prefix and suffix.

{% include [batching-events](../../../_includes/api-gateway/batching-events.md) %}

## Roles required for the proper operation of a trigger for {{ objstorage-name }} {#roles}

- To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.
- To activate a trigger, the service account needs the `api-gateway.websocketBroadcaster` role for the folder containing the API gateway.

Read more about [access management](../../security/index.md).

## {{ objstorage-name }} trigger message format {#format}

After the trigger fires, it will send the following message to WebSocket connections:

{% include [os-format](../../../_includes/functions/os-format.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that runs a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/os-trigger.md)
* [Trigger for {{ objstorage-name }} that runs a {{ sf-name }} function](../../../functions/concepts/trigger/os-trigger.md)
