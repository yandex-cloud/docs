# Creating a trigger for {{ iot-short-name }}

Create a [trigger](../concepts/trigger/iot-core-trigger.md) for a device topic or the {{ iot-name }} service registry and process copies of messages using a {{ serverless-containers-name }} [container](../concepts/container.md).

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

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also

* [{{ iot-name }} trigger that passes messages to the {{ sf-name }} function](../../functions/operations/trigger/iot-core-trigger-create.md).
