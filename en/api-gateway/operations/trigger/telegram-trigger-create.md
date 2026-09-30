# How to create a Telegram trigger that sends messages to WebSocket connections

Create a [Telegram trigger](../../concepts/trigger/telegram-trigger.md) that sends messages to {{ api-gw-full-name }} [WebSocket connections](../../concepts/extensions/websocket.md) when your Telegram bot receives an update.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* Telegram bot and its token. If you do not have a bot, create one using [@BotFather](https://core.telegram.org/bots/features#botfather) and copy the issued token.

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

    1. [Navigate]({{ link-console-main }}/link/api-gateway) to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Optionally, enter a trigger name and description.

        * {% include [triggers-labels-step](../../../_includes/functions/triggers-labels-step.md) %}

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `Telegram`.

    1. Under **Telegram settings**, specify the Telegram bot token you received from [@BotFather](https://core.telegram.org/bots/features#botfather).

    1. {% include [batch-settings](../../../_includes/functions/batch-settings.md) %}

    1. Under **Targets**:

        1. In the **Target type** field, select `API gateway`.

        1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

        1. {% include [trigger-console-filter](../../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../../_includes/functions/trigger-console-template.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    To create a trigger for Telegram that sends messages to WebSocket connections:

    1. Describe the trigger in the configuration file:

       ```hcl
       resource "yandex_serverless_triggers" "my_trigger" {
         name = "<trigger_name>"
         source {
           telegram_message {
             bot_token       = "<Telegram_bot_token>"
             allowed_updates = [ "<update_type>", "<update_type>" ]
             force           = true
           }
         }
         action {
           gateway_websocket_broadcast {
             gateway_id         = "<API_gateway_ID>"
             path               = "<WebSocket_connection_path>"
             service_account_id = "<service_account_ID>"
           }
           filter {
             jq = ".message.text | startswith(\"/\")"
           }
           transformer {
             jq = ".message"
           }
           retry_policy {
             retry_attempts = "<number_of_retries>"
             interval       = "<interval_between_retries>"
           }
           dead_letter {
             dead_letter_queue {
               queue_arn          = "<Dead_Letter_Queue_ARN>"
               service_account_id = "<service_account_ID>"
             }
           }
         }
       }
       ```

       Where:

       {% include [tf-triggers-common-params](../../../_includes/tf-triggers-common-params.md) %}

       * `source`: Event source settings:

         * `telegram_message`: Telegram bot settings:

           * `bot_token`: Telegram bot token received from [@BotFather](https://core.telegram.org/bots/features#botfather). The value is only provided when creating or updating a trigger. {{ TF }} does not return the value in its output. When the token changes, the webhook is re-registered.
           * `allowed_updates`: List of [Telegram update](https://core.telegram.org/bots/api#update) types the bot subscribes to. This is an optional setting. The default value is `[ "message" ]`.
           * `force`: Reinstalling the webhook if the bot already has a webhook configured for another URL. Without this setting, creating a trigger will fail with an error. If the webhook already points to the trigger, this setting has no effect. This is an optional parameter.

       {% include [tf-triggers-action-gateway](../../../_includes/api-gateway/tf-triggers-action-gateway.md) %}

       For more on the properties of the `yandex_serverless_triggers` resource, see [this provider guide]({{ tf-provider-resources-link }}/serverless_triggers).

    1. Create the resources:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

        {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

        ```bash
        yc serverless trigger list
        ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

#### Useful links {#see-also}

* [Telegram Trigger that invokes a function from {{ sf-name }}](../../../functions/operations/trigger/telegram-trigger-create.md)
* [Telegram Trigger that invokes a container from {{ serverless-containers-name }}](../../../serverless-containers/operations/telegram-trigger-create.md)
