# Creating a trigger for {{ message-queue-name }} that sends messages to WebSocket connections

Create a [trigger for {{ message-queue-short-name }} message queue](../../concepts/trigger/ymq-trigger.md) to send messages to [WebSocket connections](../../concepts/extensions/websocket.md).

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* Message queue the trigger will collect messages from. If you do not have a queue, [create one](../../../message-queue/operations/message-queue-new-queue.md).

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select a message queue and a service account with permissions to read messages from this queue.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * Batch size. The values may range from 1 to 1,000. The default value is 1.
      * Maximum wait time. The values may range from 0 to 20 seconds. The default value is 10 seconds.

      The trigger groups messages for a period not exceeding the specified wait time and sends them to WebSocket connections. However, the number of messages does not exceed the specified batch size.

   1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that sends messages to WebSocket connections, run this command:

   ```bash
     yc serverless trigger create message-queue \
       --name <trigger_name> \
       --queue <queue_ID> \
       --queue-service-account-id <service_account_ID> \
       --gateway-id <API_gateway_ID> \
       --gateway-websocket-broadcast-path <path> \
       --gateway-websocket-broadcast-service-account-id <service_account_ID> \
       --batch-size <message_batch_size>
       --batch-cutoff <maximum_wait_time>
   ```

   Where:

   * `--name`: Trigger name.
   * `--queue`: Queue ID.

      {% include [ymq-id](../../../_includes/serverless-containers/ymq-id.md) %}

   * `--queue-service-account-id`: Service account with permissions to read messages from the queue.

   {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 to 1,000. The default value is 1.
   * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to WebSocket connections. The number of messages cannot exceed `batch-size`.

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: ymq-trigger
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:my-mq
       service_account_id: bfbqqeo6jkh2********
       batch_settings:
         size: "1"
         cutoff: 10s
       gateway_websocket_broadcast:
         gateway_id: d4eofc7n0mh2********
         path: /
         service_account_id: aje3932acdh2********
   status: ACTIVE
   ```

- API {#api}

   To create a trigger for {{ message-queue-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- {{ api-gw-full-name }}

   {% include [check-result](../../../_includes/api-gateway/check-result.md) %}

- {{ message-queue-name }}

   Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:

   1. In the [management console]({{ link-console-main }}), open **{{ ui-key.yacloud.iam.folder.dashboard.label_ymq }}**.
   1. Select the queue that you created the trigger for.
   1. Go to **{{ ui-key.yacloud.common.monitoring }}**. Check the **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}** chart.

{% endlist %}


## See also {#see-also}

* [Trigger for {{ message-queue-name }} that sends messages to a {{ sf-name }} function](../../../functions/operations/trigger/ymq-trigger-create.md)
* [Trigger for {{ message-queue-name }} that sends messages to a {{ serverless-containers-name }} container](../../../serverless-containers/operations/ymq-trigger-create.md)
