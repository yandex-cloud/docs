---
title: "Creating a trigger that transmits messages to a {{ serverless-containers-name }} container from an {{ iot-full-name }} registry or device topic"
description: "Create a trigger for an {{ iot-name }} device or registry topic to process message copies in a {{ serverless-containers-name }} container."
---

# Creating a trigger that will send messages to a {{ serverless-containers-name }} container from a {{ iot-full-name }} registry or device topic

Create a [trigger](../concepts/trigger/iot-core-trigger.md) for an {{ iot-name }} device or registry topic and process copies of messages using a {{ serverless-containers-name }} [container](../concepts/container.md).

{% note warning %}

The trigger must be in the same cloud with the registry or device it reads messages from.

{% endnote %}

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Registry](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) from whose topics the trigger will receive copies of messages. If you have neither:

   * [Create a registry](../../iot-core/operations/registry/registry-create.md).
   * [Create a device](../../iot-core/operations/device/device-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**, specify the registry, device, and MQTT topic to create a trigger for. When creating a trigger for a registry topic, you do not need to specify a device or an MQTT topic. If no MQTT topic is set, the trigger fires for all registry or device topics.

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   ```bash
   yc serverless trigger create internet-of-things \
     --name <trigger_name> \
     --registry-id <registry_ID> \
     --device-id <device_ID> \
     --mqtt-topic '$devices/<device_ID>/events' \
     --batch-size <message_batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--registry-id`: [Registry ID](../../iot-core/operations/registry/registry-list.md).
   * `--device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you are creating a trigger for a registry topic, you can omit this parameter.
   * `--mqtt-topic`: MQTT topic you want to create a trigger for. This is an optional parameter. If this parameter is skipped, the trigger fires for all registry or device topics.

   {% include [trigger-param](../../_includes/iot-core/trigger-param-sc.md) %}

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktij**********
   folder_id: b1gmit33hg**********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: iot-trigger
   rule:
     iot_message:
       registry_id: arenou2oj4**********
       device_id: areqjd6un3**********
       mqtt_topic: $devices/areqjd6un**********/events
       batch_settings:
         size: "1"
         cutoff: 0s
       invoke_container:
         container_id: bba5jb38o8**********
         service_account_id: aje3932acd**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
   status: ACTIVE
   ```

- API

   To create a trigger for {{ iot-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that sends messages from registry or device topics to a {{ sf-name }} function](../../functions/operations/trigger/iot-core-trigger-create.md).
