Create a [trigger](../../functions/concepts/trigger/iot-core-trigger.md) for an {{ iot-name }} device or registry topic and process message copies using a [{{ sf-name }} function](../../functions/concepts/function.md).

{% note warning %}

The trigger must be in the same cloud with the registry or device it reads messages from.

{% endnote %}

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Registry](../../iot-core/concepts/index.md#registry) or [device](../../iot-core/concepts/index.md#device) from whose topics the trigger will receive copies of messages. If you have neither:

   * [Create a registry](../../iot-core/operations/registry/registry-create.md).
   * [Create a device](../../iot-core/operations/device/device-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**, specify the registry, device, and MQTT topic to create a trigger for. When creating a trigger for a registry topic, you do not need to specify a device or an MQTT topic. If no MQTT topic is set, the trigger fires for all registry or device topics.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

      {% include [function-settings](function-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request.md](repeat-request.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that invokes a function, run this command:

   ```bash
   yc serverless trigger create internet-of-things \
     --name <trigger_name> \
     --registry-id <registry_ID> \
     --device-id <device_ID> \
     --mqtt-topic '$devices/<device_ID>/events' \
     --batch-size <message_batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --invoke-function-id <function_ID> \
     --invoke-function-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--registry-id`: [Registry ID](../../iot-core/operations/registry/registry-list.md).
   * `--device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you're creating a trigger for a registry topic, you can omit this parameter.
   * `--mqtt-topic`: MQTT topic you want to create a trigger for. This is an optional parameter. If this parameter is skipped, the trigger fires for all registry or device topics.

   {% include [trigger-param](../iot-core/trigger-param-cf.md) %}

   {% include [trigger-cli-param](trigger-cli-param.md) %}

   Result:

   ```text
   id: a1sl0mkmimfj********
   folder_id: b1g88tflru0e********
   created_at: "2019-09-25T13:54:35.654935Z"
   name: iot-trigger
   rule:
     iot_message:
       registry_id: arenou2oj4ct********
       device_id: areqjd6un3af********
       mqtt_topic: $devices/areqjd6un3af********/events
       batch_settings:
         size: "1"
         cutoff: 0s
       invoke_function:
         function_id: d4eofc7n0m03********
         function_tag: $latest
         service_account_id: aje3932acd0c********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
   status: ACTIVE
   ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger for {{ iot-name }}:

   1. In the configuration file, describe the trigger parameters.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<trigger_name>"
        description = "<trigger_description>"
        iot {
          registry_id = "<registry_ID>"
          device_id   = "<device_ID>"
          topic       = "<topic_ID>"
        }
        function {
          id                 = "<function_ID>"
          service_account_id = "<service_account_ID>"
        }
      }
      ```

      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `iot`: [Topic](../../iot-core/concepts/topic/) parameters:
         * `registry-id`: [Registry ID](../../iot-core/operations/registry/registry-list.md).
         * `device-id`: [Device ID](../../iot-core/operations/device/device-list.md). If you're creating a trigger for a registry topic, you can omit this parameter.
         * `topic`: ID of the [topic](../../iot-core/concepts/topic/) you want to create a trigger for. If no topic is set, the trigger fires for all registry or device topics.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.
         * `service_account_id`: ID of the service account with rights to invoke a function.

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

- API

   To create a trigger for {{ iot-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that sends messages from registry or device topics to a {{ serverless-containers-name }} container](../../serverless-containers/operations/iot-core-trigger-create.md).
