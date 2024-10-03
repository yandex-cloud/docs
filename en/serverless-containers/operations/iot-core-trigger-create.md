---
title: Creating a trigger that transmits messages to a {{ serverless-containers-name }} container from a {{ iot-full-name }} registry or device topic
description: Create a trigger for an {{ iot-name }} device or registry topic to process message copies in a {{ serverless-containers-name }} container.
---

# Creating a trigger that will send messages to a {{ serverless-containers-name }} container from a {{ iot-full-name }} registry or device topic

Create a [trigger](../concepts/trigger/iot-core-trigger.md) for an {{ iot-name }} device or registry topic and process copies of messages using a {{ serverless-containers-name }} [container](../concepts/container.md).

{% note warning %}

The trigger must be in the same cloud as the registry or device whose topic it reads messages from.

{% endnote %}

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Registry](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) from whose topics the trigger will receive message copies. If you have neither:

   * [Create a registry](../../iot-core/operations/registry/registry-create.md).
   * [Create a device](../../iot-core/operations/device/device-create.md).

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**, specify the registry, device, and MQTT topic to create a trigger for. When creating a trigger for a registry topic, you do not need to specify a device or an MQTT topic. If no MQTT topic is set, the trigger fires for all registry or device topics.

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
   yc serverless trigger create internet-of-things \
     --name <trigger_name> \
     --registry-id <registry_ID> \
     --device-id <device_ID> \
     --mqtt-topic '<broker_MQTT_topic>' \
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
   * `--registry-id`: [Registry ID](../../iot-core/operations/registry/registry-list.md).
   * `--device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you are creating a trigger for a registry topic, you can omit this parameter.
   * `--mqtt-topic`: MQTT topic you want to create a trigger for. This is an optional parameter. If this parameter is skipped, the trigger fires for all registry or device topics.

   {% include [trigger-param](../../_includes/iot-core/trigger-param-sc.md) %}

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: iot-trigger
   rule:
     iot_message:
       registry_id: arenou2oj4h2********
       device_id: areqjd6un3h2********
       mqtt_topic: $devices/areqjd6unh2********/events
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

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a trigger for {{ iot-name }}:

   1. In the configuration file, describe the trigger parameters:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name = "<trigger_name>"
        container {
          id                 = "<container_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = "<number_of_retry_invocation_attempts>"
          retry_interval     = "<interval_between_retry_attempts>"
        }
        iot {
          registry_id  = "<registry_ID>"
          device_id    = "<device_ID>"
          topic        = "<broker_MQTT_topic>"
          batch_cutoff = "<maximum_wait_time>"
          batch_size   = "<message_batch_size>"
        }
        dlq {
         queue_id           = "<dead_letter_queue_ID>"
         service_account_id = "<service_account_ID>"
       }
      }
      ```

      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `container-name`: Container parameters:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

         {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      * `iot`: Trigger parameters:

         * `registry-id`: [Registry ID](../../iot-core/operations/registry/registry-list.md).
         * `device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you are creating a trigger for a registry topic, you can omit this parameter.
         * `topic`: MQTT topic you want to create a trigger for. This is an optional parameter. If this parameter is skipped, the trigger fires for all registry or device topics.
         * `batch_cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch_cutoff` and sends them to a container. The number of messages cannot exceed `batch_size`.
         * `batch-size`: Size of the message batch from MQTT topics. This is an optional parameter. The values may range from 1 to 10. The default value is 1.

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

      ```bash
      yc serverless trigger list
      ```

- API {#api}

   To create a trigger for {{ iot-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [{#T}](../../functions/operations/trigger/iot-core-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/iot-core-trigger-create.md)
