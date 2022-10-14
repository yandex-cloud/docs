Create a trigger for a device [topic](../../iot-core/concepts/topic/index.md) or the {{ iot-name }} service registry and process copies of messages using a {{ serverless-containers-name}} [container](../../serverless-containers/concepts/container.md).

For more information about creating a trigger for {{ iot-name }} that calls a function, see the [{{ sf-name }} documentation](../../functions/operations/trigger/cr-trigger-create.md).

{% note warning %}

The trigger must be in the same cloud with the registry or device it reads messages from.

{% endnote %}

## Before you begin {#before-begin}

{% include [trigger-before-you-begin](./trigger-before-you-begin.md) %}

* The [registry](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) from whose topics a trigger will receive copies of messages. If you don't have either:

   * [Create a registry](../../iot-core/operations/registry/registry-create.md).
   * [Create a device](../../iot-core/operations/device/device-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Open **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Yandex IoT Core**.
      * In the Launched resource field, select **Container**.

   1. Under **Yandex IoT Core message settings**, specify the registry, device, and MQTT topic to create a trigger for. If you are creating a trigger for a registry topic, you don't need to specify a device or an MQTT topic.

   1. Under **Container settings**, select a container and specify:

      * A [container revision](../../serverless-containers/concepts/container.md#revision).
      * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
