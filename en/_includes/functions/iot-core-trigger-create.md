Create a [trigger](../../functions/concepts/trigger/iot-core-trigger.md) for a device topic or the {{ iot-name }} service registry and process copies of messages using a [{{ sf-name }} function](../../functions/concepts/function.md).

{% note warning %}

The trigger must be in the same cloud with the registry or device it reads messages from.

{% endnote %}

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* The [registry](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) from whose topics a trigger will receive copies of messages. If you don't have either:

   * [Create a registry](../../iot-core/operations/registry/registry-create.md).
   * [Create a device](../../iot-core/operations/device/device-create.md).

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
      * In the **Type** field, select **{{ iot-name }}**.
      * In the **Launched resource** field, select **Function**.

   1. Under **{{ iot-name }} message settings**, specify the registry, device, and MQTT topic to create a trigger for. If you are creating a trigger for a registry topic, you don't need to specify a device or an MQTT topic.

   1. Under **Function settings**, select a function and specify:

      {% include [function-settings](function-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request.md](repeat-request.md) %}

   1. (optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that invokes a function, run the command:

   ```bash
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

   {% include [trigger-cli-param](trigger-cli-param.md) %}

   Result:

   ```text
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

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger for {{ iot-name }}:

   1. In the configuration file, describe the trigger parameters.

      Example configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<trigger name>"
        description = "<trigger description>"
        iot {
          registry_id = "<registry ID>"
          device_id   = "<device ID>"
          topic       = "<topic ID>"
        }
        function {
          id                 = "<function ID>"
          service_account_id = "<service account ID>"
        }
      }
      ```

      Where:

      * `name`: Trigger name. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `iot`: [Topic](../../iot-core/concepts/topic/) parameters:
         * `registry-id`: [Registry ID](../../iot-core/operations/registry/registry-list.md).
         * `device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you're creating a trigger for a registry topic, you can omit this parameter.
         * `topic`: ID of the [topic](../../iot-core/concepts/topic/) you want to create a trigger for.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.
         * `service_account_id`: ID of the service account with rights to invoke a function.

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that passes messages to the {{ serverless-containers-name }} container](../../serverless-containers/operations/iot-core-trigger-create.md).
