# Timer that sends messages to WebSocket connections

A _timer_ is a [trigger](../trigger/) that sends messages to [WebSocket connections](../extensions/websocket.md) on schedule. The schedule is entered as a [cron expression](#cron-expression). The cron expression uses [UTC+0](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

A timer requires a [service account](../../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.

For more information about creating a timer, see [{#T}](../../operations/trigger/timer-create.md).

{% include [cron-expression](../../../_includes/functions/cron-expression.md) %}

## Roles required for timers to run correctly {#roles}

* To create a timer, you need a permission for the service account under which the timer executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.
* To activate a timer, the service account needs the `api-gateway.websocketBroadcaster` role for the folder containing the API gateway.

Read more about [access management](../../security/index.md).

## Timer message format {#format}

After the trigger fires, it will send the following message to WebSocket connections:

{% include [timer-format](../../../_includes/functions/timer-format.md) %}

## See also {#see-also}

* [Timer to run a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/timer.md)
* [Timer to run a {{ sf-name }} function](../../../functions/concepts/trigger/timer.md)
