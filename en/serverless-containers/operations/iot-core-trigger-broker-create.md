---
title: Creating a trigger that transmits messages to a {{ serverless-containers-name }} container from an {{ iot-full-name }} broker topic
description: Create a trigger for an {{ iot-name }} broker topic to process message copies in a {{ serverless-containers-name }} container.
---

# Creating a trigger that will send messages to a {{ serverless-containers-name }} container from a {{ iot-full-name }} broker topic

Create a [trigger](../concepts/trigger/iot-core-trigger.md) for an {{ iot-name }} broker topic and process message copies using a {{ serverless-containers-name }} [container](../concepts/container.md).

{% note warning %}

The trigger must be in the same cloud as the broker whose topic it reads messages from.

{% endnote %}

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Broker](../../iot-core/concepts/index.md#broker) from the topic of which the trigger will collect message copies. If you do not have a broker, [create one](../../iot-core/operations/broker/broker-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot-broker }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_broker }}** field, specify the broker.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** field, specify an MQTT topic. If no MQTT topic is set, the trigger will fire for all broker topics.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      {% include [batch-settings](../../_includes/functions/batch-settings.md) %}

      {% include [batch-messages](../../_includes/serverless-containers/batch-messages.md) %}

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   ```bash
   yc serverless trigger create iot-broker \
     --name <trigger_name> \
     --broker-id <broker_ID> \
     --mqtt-topic '<MQTT_topic>' \
     --batch-size <message_batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts <number_of_retry_invocation_attempts> \
     --retry-interval <interval_between_retry_attempts> \
     --dlq-queue-id <dead_letter_queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--broker-id`: [Broker ID](../../iot-core/operations/broker/broker-list.md).
   * `--mqtt-topic`: MQTT topic you want to create a trigger for. This is an optional parameter. If this parameter is skipped, the trigger will fire for all broker topics.

   {% include [trigger-param](../../_includes/iot-core/trigger-param-sc.md) %}

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

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
       invoke_container:
         container_id: bba5jb38o8h2********
         service_account_id: aje3932acdh2********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
   status: ACTIVE
   ```

- API {#api}

   To create a trigger for {{ iot-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [{#T}](../../functions/operations/trigger/iot-core-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/iot-core-trigger-broker-create.md)
