# Creating a timer that sends messages to WebSocket connections

Create a [timer](../../concepts/trigger/timer.md), i.e., a trigger to send messages to [WebSocket connections](../../concepts/extensions/websocket.md) on schedule.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

   1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** field, specify a schedule for sending messages to WebSocket connections as a [cron expression](../../concepts/trigger/timer.md#cron-expression).
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-payload }}** field, specify the message that will be sent to WebSocket connections if the timer fires in the `payload` field. The data type is a string up to 4,096 characters long.

   1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that sends messages to WebSocket connections, run this command:

   ```bash
   yc serverless trigger create timer \
     --name <trigger_name> \
     --cron-expression '<cron_expression>' \
     --payload <message> \
     --gateway-id <API_gateway_ID> \
     --gateway-websocket-broadcast-path <path> \
     --gateway-websocket-broadcast-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Timer name.
   * `--cron-expression`: Schedule for sending messages to WebSocket connections as a [cron expression](../../concepts/trigger/timer.md#cron-expression).
   * `--payload`: Message that will be sent to WebSocket connections if the timer fires. The string length must not exceed 4,096 characters.

   {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2023-08-04T15:19:15.353909857Z"
   name: timer
   rule:
     timer:
       cron_expression: 5 10 ? * * *
       payload: <message>
       gateway_websocket_broadcast:
         gateway_id: d4eofc7n0mh2********
         path: /
         service_account_id: aje3932acdh2********
   status: ACTIVE
   ```

- API {#api}

   To create a timer, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Timer that invokes a {{ sf-name }} function](../../../functions/operations/trigger/timer-create.md)
* [Timer that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/timer-create.md)
