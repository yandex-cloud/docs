# Trigger for budgets that sends messages to WebSocket connections

A [trigger](../trigger/) for [budgets](../../../billing/concepts/budget.md) sends messages to [WebSocket connections](../extensions/websocket.md) when threshold values are exceeded.

A trigger for budgets requires a [service account](../../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.

For more information about creating a trigger for budgets, see [{#T}](../../operations/trigger/budget-trigger-create.md).

## Roles required for the proper operation of a trigger for budgets {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* To activate a trigger, the service account needs the `api-gateway.websocketBroadcaster` role for the folder containing the API gateway.

## Format of the message from the trigger for budgets {#format}

After the trigger fires, it will send the following message to WebSocket connections:

{% include [budget-format](../../../_includes/functions/budget-format.md) %}

## See also {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/budget-trigger.md)
* [{#T}](../../../functions/concepts/trigger/budget-trigger.md)