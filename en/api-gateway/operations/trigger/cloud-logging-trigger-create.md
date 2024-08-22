# Creating a trigger for {{ cloud-logging-name }} that sends messages to WebSocket connections

Create a [trigger for {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md) to send messages to [WebSocket connections](../../concepts/extensions/websocket.md) when you add entries to a [log group](../../../logging/concepts/log-group.md).

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* A log group that activates the trigger when entries are added there. If you do not have a log group, [create one](../../../logging/operations/create-group.md).

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}**, specify:

      {% include [logging-settings](../../../_includes/functions/logging-settings.md) %}

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * Batch size. The values may range from 1 to 1,000. The default value is 1.
      * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

      The trigger groups messages for a period not exceeding the specified wait time and sends them to WebSocket connections. However, the number of messages does not exceed the specified batch size.

   1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that sends messages to WebSocket connections, run this command:

   ```bash
   yc serverless trigger create logging \
     --name <trigger_name> \
     --log-group-name <log_group_name> \
     --batch-size 1 \
     --batch-cutoff 1s \
     --resource-ids <resource_ID> \
     --resource-types <resource_type> \
     --stream-names <logging_stream> \
     --log-levels <logging_level> \
     --gateway-id <API_gateway_ID> \
     --gateway-websocket-broadcast-path <path> \
     --gateway-websocket-broadcast-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--log-group-name`: Name of the log group that invokes a container when records are added.

   {% include [batch-settings-messages](../../../_includes/api-gateway/batch-settings-messages.md) %}

   {% include [logging-cli-param](../../../_includes/functions/logging-cli-param.md) %}

   {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2023-08-04T15:19:15.353909857Z"
   name: logging-trigger
   rule:
     logging:
       log_group_id: e23bidnftlh2********
       resource_type:
         - serverless.functions
       resource_id:
         - d4e1gpsgam78********
       stream_name:
         - test
       levels:
         - INFO
       batch_settings:
         size: "1"
         cutoff: 1s
       gateway_websocket_broadcast:
         gateway_id: d4eofc7n0mh2********
         path: /
         service_account_id: aje3932acdh2********
   status: ACTIVE
   ```

- API {#api}

   To create a trigger for {{ cloud-logging-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ cloud-logging-name }} that invokes a {{ sf-name }} function](../../../functions/operations/trigger/cloud-logging-trigger-create.md)
* [Trigger for {{ cloud-logging-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/cloud-logging-trigger-create.md)
