# Trigger for Telegram that sends messages to WebSocket connections

A Telegram [trigger](../trigger/) sends messages to [WebSocket connections](../extensions/websocket.md) whenever the Telegram bot receives an update: message, command, button callback, and other events. To receive updates, the trigger uses the Telegram bot's token.

A trigger for Telegram requires a [service account](../../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.

For more information about creating a trigger for Telegram, see [{#T}](../../operations/trigger/telegram-trigger-create.md).

## Roles required for the proper operation of a trigger for Telegram {#roles}

* To create a trigger, you need a permission for the service account under which the trigger runs the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, the service account needs the `api-gateway.websocketBroadcaster` role for the folder where the API gateway resides.

## Telegram trigger message format {#format}

After the trigger fires, it will send an [Update](https://core.telegram.org/bots/api#update) object from the Telegram Bot API to WebSocket connections.

## Useful links {#see-also}

* [Trigger for Telegram that runs a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/telegram-trigger.md)
* [Trigger for Telegram that runs a {{ sf-name }} function](../../../functions/concepts/trigger/telegram-trigger.md)
