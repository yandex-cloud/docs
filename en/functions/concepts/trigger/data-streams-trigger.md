# Trigger for {{ yds-name }} that invokes a {{ sf-name }} function

 [Trigger](../trigger/) for {{ yds-name }} calls a {{ sf-name }} [function](../function.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts). 

A trigger for {{ yds-name }} needs [service accounts](../../../iam/concepts/users/service-accounts.md) to manage a stream and invoke a function. You can use the same service account for both operations.

For more information about creating a trigger for {{ yds-name }}, see [{#T}](../../operations/trigger/data-streams-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ yds-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, service accounts need the following roles:
   * `{{ roles-functions-invoker }}` for the function that the trigger invokes.
   * `yds.admin` for the stream that invokes the trigger when data is sent there.

## Format of the message from the trigger for {{ yds-name }} {#format}

After the trigger is activated, it sends a message to the function. The message format depends on the source and is an array of `messages`:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}

## See also {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/data-streams-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/data-streams-trigger.md)
