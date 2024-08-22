# Email trigger sending messages to WebSocket connections

An email [trigger](../trigger/) sends messages to [WebSocket connections](../extensions/websocket.md) when an email arrives. The service automatically generates an email address when creating the trigger.

An email trigger requires a [service account](../../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.

For more information about creating an email trigger, see [{#T}](../../operations/trigger/mail-trigger-create.md).

{% include [batching-messages](../../../_includes/api-gateway/batching-messages.md) %}

## Roles required for email trigger to run properly {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* To activate a trigger, the service account needs the `api-gateway.websocketBroadcaster` role for the folder containing the API gateway.
* {% include [attachments-requirements](../../../_includes/functions/attachments-requirements.md) %}

## Email trigger message format {#format}

After the trigger fires, it will send the following message to WebSocket connections:

{% include [mail-format](../../../_includes/functions/mail-format.md) %}

## See also {#see-also}

* [Email trigger that runs a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/mail-trigger.md)
* [Email trigger that runs a {{ sf-name }} function](../../../functions/concepts/trigger/mail-trigger.md)
