# Creating a trigger for {{ iot-short-name }} that passes messages to the {{ serverless-containers-name }} container

Create a [trigger](../concepts/trigger/iot-core-trigger.md) for a device topic or the {{ iot-name }} service registry and process copies of messages using a {{ serverless-containers-name}} [container](../concepts/container.md).

{% note warning %}

The trigger must be in the same cloud with the registry or device it reads messages from.

{% endnote %}

## Before you begin {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* The [registry](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) from whose topics a trigger will receive copies of messages. If you don't have either:

   * [Create a registry](../../iot-core/operations/registry/registry-create.md).
   * [Create a device](../../iot-core/operations/device/device-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Open **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ iot-name }}**.
      * In the Launched resource field, select **Container**.

   1. Under **{{ iot-name }} message settings**, specify the registry, device, and MQTT topic to create a trigger for. If you are creating a trigger for a registry topic, you don't need to specify a device or an MQTT topic.

   1. Under **Container settings**, select a container and specify:

      {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (optional) **Under Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run the command:

   ```bash
   yc serverless trigger create internet-of-things \
     --name <trigger_name> \
     --registry-id <registry_ID> \
     --device-id <device_ID> \
     --mqtt-topic '$devices/<device_ID>/events' \
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
   * `--device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you're creating a trigger for a registry topic, you can omit this parameter.
   * `--mqtt-topic`: The topic you want to create a trigger for.

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
       invoke_container:
         container_id: bba5jb38o8**********
         service_account_id: aje3932acd**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
   status: ACTIVE
   ```

- API

   You can create a trigger for {{ iot-name }} using the [create](../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that passes messages to the {{ sf-name }} function](../../functions/operations/trigger/iot-core-trigger-create.md).
