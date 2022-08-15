Create a trigger for a device [topic](../../iot-core/concepts/topic/index.md) or the {{ iot-name }} service registry and process copies of messages using a {{ sf-name }} [function](../../functions/concepts/function.md) or a {{ serverless-containers-name}} [container](../../serverless-containers/concepts/container.md).

{% note warning %}

The trigger must be in the same cloud with the registry or device it reads messages from.

{% endnote %}

## Before you start {#before-begin}

To create a trigger, you need:

* A [function](../../functions/concepts/function.md) or a [container](../../serverless-containers/concepts/container.md) the trigger will launch.

   * If you don't have a function:

      * [Create a function](../../functions/operations/function/function-create.md).
      * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

   * If you don't have a container:

      * [Create a container](../../serverless-containers/operations/create.md).
      * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* The [registry](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) from whose topics a trigger will receive copies of messages. If you don't have either:

   * [Create a registry](../../iot-core/operations/registry/registry-create.md).
   * [Create a device](../../iot-core/operations/device/device-create.md).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function or a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights to invoke a function or a container and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Yandex IoT Core**.
      * Choose what the trigger will launch — a function or a container.

   1. Under **Yandex IoT Core message settings**, specify the registry, device, and MQTT topic to create a trigger for. If you are creating a trigger for a registry topic, you don't need to specify a device or an MQTT topic.

   1. If the trigger launches:

      * A function, select one under **Function settings** and specify:

         * [Tag of the function version](../../functions/concepts/function.md#tag);
         * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

      * A container, select one under **Container settings** and specify:

         * [A container revision](../../serverless-containers/concepts/container.md#revision);
         * [A service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function or the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that launches a function, run the command:

   ```
   yc serverless trigger create internet-of-things \
     --name <trigger name> \
     --registry-id <registry ID> \
     --device-id <device ID> \
     --mqtt-topic '$devices/<device ID>/events' \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--registry-id`: [Registry ID](../../iot-core/operations/registry/registry-list.md).
   * `--device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you're creating a trigger for a registry topic, you can omit this parameter.
   * `--mqtt-topic`: The topic you want to create a trigger for.
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
   * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional. Values can be from 1 to 5. The default is 1.
   * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. Optional.
   * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional.

   Result:

   ```
   id: a1sl0mkmimfj3uv52fr8
   folder_id: b1g88tflru0ek1omtsu0
   created_at: "2019-09-25T13:54:35.654935Z"
   name: iot-trigger
   rule:
     iot_message:
       registry_id: arenou2oj4ct42eq8g3n
       device_id: areqjd6un3afc3cefcvm
       mqtt_topic: $devices/areqjd6un3afc3cefcvm/events
       invoke_function:
         function_id: d4eofc7n0m03lmudse8l
         function_tag: $latest
         service_account_id: aje3932acd0c5ur7dagp
         retry_settings:
           retry_attempts: "1"
           interval: 10s
   status: ACTIVE
   ```

- API

   You can create a trigger for {{ iot-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md).

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
