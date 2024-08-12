---
title: "Creating a trigger that sends messages to {{ api-gw-full-name }} WebSocket connections from an {{ iot-full-name }} broker topic"
description: "Create a trigger for an {{ iot-name }} broker topic to send message copies to {{ api-gw-full-name }} WebSocket connections."
---

# Creating a trigger that sends messages to WebSocket connections from an {{ iot-full-name }} broker

Create a [trigger](../../concepts/trigger/iot-core-trigger.md) for an {{ iot-name }} broker topic and send message copies to {{ api-gw-full-name }} [WebSocket connections](../../concepts/extensions/websocket.md).

{% note warning %}

The trigger must be in the same cloud as the broker whose topic it reads messages from.

{% endnote %}

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* [Broker](../../../iot-core/concepts/index.md#broker) whose topic the trigger will collect copies of messages from. If you do not have a broker, [create one](../../../iot-core/operations/broker/broker-create.md).

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot-broker }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select the `API gateway`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_broker }}** field, specify the broker.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** field, specify an MQTT topic. If no MQTT topic is set, the trigger will fire for all broker topics.

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
   yc serverless trigger create iot-broker \
     --name <trigger_name> \
     --broker-id <broker_ID> \
     --mqtt-topic '<broker_MQTT_topic>' \
     --batch-size <message_batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --gateway-id <API_gateway_ID> \
     --gateway-websocket-broadcast-path <path> \
     --gateway-websocket-broadcast-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--broker-id`: [Broker ID](../../../iot-core/operations/broker/broker-list.md).
   * `--mqtt-topic`: MQTT topic you want to create a trigger for. This is an optional parameter. If this parameter is skipped, the trigger will fire for all broker topics.

   {% include [batch-settings-messages](../../../_includes/api-gateway/batch-settings-messages.md) %}

   {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: iot-broker-trigger
   rule:
     iot_broker_message:
       broker_id: arenou2oj4h2********
       mqtt_topic: topic-for-broker
       batch_settings:
         size: "1"
         cutoff: 0s
       gateway_websocket_broadcast:
         gateway_id: d4eofc7n0mh2********
         path: /
         service_account_id: aje3932acdh2********
   status: ACTIVE
   ```

- API {#api}

   To create a trigger for {{ iot-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that sends messages from topics to a {{ sf-name }} function](../../../functions/operations/trigger/iot-core-trigger-broker-create.md)
* [Trigger for {{ iot-name }} that sends messages from topics to a {{ serverless-containers-name }} container](../../../serverless-containers/operations/iot-core-trigger-broker-create.md)
