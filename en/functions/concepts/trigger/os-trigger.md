# Trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function

[Triggers](../trigger/) for {{ objstorage-name }} run a {{ sf-name }} [function](../function.md) when a certain event occurs with a {{ objstorage-name }} [object](../../../storage/concepts/object.md). The trigger must be in the same cloud as the bucket whose events it's subscribed to.

A trigger for {{ objstorage-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function.

## Events for setting up a trigger {#event}

Events with bucket objects that can be tracked using a trigger:
- [Creating an object](../../../storage/operations/objects/upload.md).
- [Editing an object ACL](../../../storage/operations/objects/edit-acl.md).
- [Deleting an object](../../../storage/operations/objects/delete.md).

### Filtering events by object {#filter}

Events are filtered using prefixes and suffixes for an object [key](../../../storage/concepts/object.md#key):
* The prefix is the part of the object key that contains the beginning of the object key.
* The suffix is the part of the object key that contains the end of the object key.

Prefixes and suffixes can be any length. When using a prefix and suffix at the same time, filtering is done based on the logical `AND`: for the trigger to work, the object key must match both the prefix and suffix.

## Roles required for the proper operation of a trigger for {{ objstorage-name }} {#roles}

- To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
- To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../../security/index.md).

## Trigger for {{ objstorage-name }} message format {#format}

After the trigger is activated, it sends the following message to the function:

{% include [os-format](../../../_includes/functions/os-format.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that calls a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/os-trigger.md).
