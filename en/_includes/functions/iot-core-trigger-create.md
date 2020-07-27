{% include [triggers-preview](triggers-preview-stage.md) %}

Create a trigger for the device [topic](../../iot-core/concepts/topic.md) or {{ iot-name }} service registry, and process message copies using a [function](../../functions/concepts/function.md) {{ sf-name }}.

{% note warning %}

The trigger must be in the same cloud with the registry or device it reads messages from.

{% endnote %}

## Before you start {#before-begin}

To create a trigger, you need:

1. A service account with rights for function call. If you don't have a service account, [create one](../../iam/operations/sa/create.md).
1. [Registries](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) whose topics the trigger will accept copies of messages from. If you don't have either:
    - [Create a registry](../../iot-core/operations/registry/registry-create.md).
    - [Create a device](../../iot-core/operations/device/device-create.md).
1. [Functions](../../functions/concepts/function.md) the trigger will send messages to for processing. If you don't have a function:
    - [Create a function](../../functions/operations/function/function-create.md).
    - [Create a version of the function and upload the function code to it](../../functions/operations/function/version-manage.md#func-version-create).

## Create a trigger {#trigger-create}

Create a trigger for the device topic.

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Create a trigger:
    - `--name`: Trigger name.
    - `--registry-id`: A [unique registry ID](../../iot-core/operations/registry/registry-list.md).
    - `--device-id`: [The unique device ID](../../iot-core/operations/device/device-list.md). If you are creating a trigger for a registry topic, you can skip this parameter.
    - `--mqtt-topic`: The topic you want to create a trigger for.
    - `--invoke-function-id`: Unique function ID.
    - `--invoke-function-service-account-id`: Service account with rights to call the function.

    ```
    $ yc serverless trigger create internet-of-things 
        --name iot-trigger \
        --registry-id arenou2oj4ct42eq8g3n \
        --device-id areqjd6un3afc3cefcvm \
        --mqtt-topic '$devices/areqjd6un3afc3cefcvm/events' \
        --invoke-function-id d4eofc7n0m03lmudse8l \
        --invoke-function-service-account-id aje3932acd0c5ur7dagp
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
    ```

{% endlist %}

## Check the results {#check-result}

Check the function logs to see if the function was run:

1. The function logs should contain information about the function call. In this example, the function outputs information about the messages processed.

    ```
    $ yc serverless function logs b09e5lu91ta21vdrrgma
    
    2019-09-25 14:00:00     MESSAGE_BATCH
    2019-09-25 14:00:00     {
    2019-09-25 14:00:00       "event_metadata": {
    2019-09-25 14:00:00         "event_id": "9e016299-866f-4900-8830-d674cbff3577",
    2019-09-25 14:00:00         "event_type": "yandex.cloud.events.iot.IoTMessage",
    2019-09-25 14:00:00         "created_at": "2019-09-25T13:59:59.208724628Z"
    2019-09-25 14:00:00       },
    2019-09-25 14:00:00       "details": {
    2019-09-25 14:00:00         "registry_id": "arenou2oj4ct42eq8g3n",
    2019-09-25 14:00:00         "device_id": "areqjd6un3afc3cefcvm",
    2019-09-25 14:00:00         "mqtt_topic": "$devices/areqjd6un3afc3cefcvm/events",
    2019-09-25 14:00:00         "payload": "VGVzdCA0"
    2019-09-25 14:00:00       }
    2019-09-25 14:00:00     }
    2019-09-25 14:00:00     END RequestID: 1ba57cbe-c2ce-4d1a-91a3-9592e945b45a
    2019-09-25 14:00:00     REPORT RequestID: 1ba57cbe-c2ce-4d1a-91a3-9592e945b45a Duration: 368.362 ms Billed Duration: 400 ms Memory Size: 128 MB Max Memory Used: 13 MB
    ```

