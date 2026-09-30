# Telegram trigger that invokes a function from {{ sf-name }}

A Telegram [trigger](../trigger/) invokes a [function](../function.md) from {{ sf-name }} when your Telegram bot receives a new update, such as a message, command, button callback, or other event. To receive updates, the trigger uses the Telegram bot's token.

A Telegram trigger needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke functions.

For more information about creating a Telegram trigger, see [this guide](../../operations/trigger/telegram-trigger-create.md).

## Roles required for the proper operation of a trigger for Telegram {#roles}

* To create a trigger, you need a permission for the service account under which the trigger runs the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, the service account requires the `{{ roles-functions-invoker }}` role for the function invoked by the trigger.

## Telegram trigger message format {#format}

After the trigger fires, it will send an [Update](https://core.telegram.org/bots/api#update) object from the Telegram Bot API to the function.

## Useful links {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/telegram-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/telegram-trigger.md)
