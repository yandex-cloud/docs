# Trigger for Telegram that invokes a {{ serverless-containers-name }} container

A Telegram [trigger](../trigger/) runs a {{ serverless-containers-name }} [container](../container.md) whenever the Telegram bot receives a new update: message, command, button callback, and other events. To receive updates, the trigger uses the Telegram bot's token.

A Telegram trigger needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke a container.

For more information about creating a trigger for Telegram, see [{#T}](../../operations/telegram-trigger-create.md).

## Roles required for the proper operation of a trigger for Telegram {#roles}

* To create a trigger, you need a permission for the service account under which the trigger runs the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to work, the service account needs the `{{ roles-serverless-containers-invoker }}` role for the container that invokes the trigger.

## Telegram trigger message format {#format}

After the trigger fires, it will send an [Update](https://core.telegram.org/bots/api#update) object from the Telegram Bot API to the container.

## Useful links {#see-also}

* [{#T}](../../../functions/concepts/trigger/telegram-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/telegram-trigger.md)
