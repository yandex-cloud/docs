# Create a trigger for {{ message-queue-name }} that sends messages to the {{ sf-name }} function

Create a [trigger](../../concepts/trigger/ymq-trigger.md) for a message queue in {{ message-queue-short-name }} and process the messages using the {{ sf-name }} [function](../../concepts/function.md).

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

## Getting started {#before-begin}

To create a trigger, you need:

* A function that the trigger will invoke. If you do not have a function:

   * [Create a function](../function/function-create.md).
   * [Create a function version](../function/version-manage.md).

* [Service accounts](../../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a function.
   * To read from the queue the trigger receives messages from.
   * (Optional) To write to a [Dead Letter Queue](../../concepts/dlq.md).

   You can use the same service account or different ones. If you do not have a service account, [create one](../../../iam/operations/sa/create.md).

* A message queue that the trigger receives messages from. If you do not have a queue, [create one](../../../message-queue/operations/message-queue-new-queue.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

   1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}**.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select a message queue and a service account with rights to read messages from this message queue.

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. The values may range from 0 to 20 seconds. The default value is 10 seconds.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. The values may range from 1 to 10. The default value is 1.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. However, the number of messages does not exceed the specified group size.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

      {% include [function-settings](../../../_includes/functions/function-settings.md) %}

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a function, run this command:

   ```bash
   yc serverless trigger create message-queue \
     --name <trigger name> \
     --queue <queue ID> \
     --queue-service-account-id <service account ID> \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --batch-size 1 \
     --batch-cutoff 10s
   ```

   Where:

   * `--name`: Trigger name.
   * `--queue`: Queue ID.

      To find out the queue ID:

      1. In the [management console]({{ link-console-main }}), select the folder containing the queue.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
      1. Select the desired queue.
      1. You can see the queue ID under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** in the **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}** field.

   * `--invoke-function-id`: Function ID.
   * `--queue-service-account-name`: Service account with rights to read messages from the queue.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 to 10. The default value is 1.
   * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The number of messages cannot exceed `batch-size`.

   Result:
   ```text
   id: dd0cspdch6**********
   folder_id: aoek49ghmk**********
   created_at: "2019-08-28T12:14:45.762915Z"
   name: ymq-trigger
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:my-mq
       service_account_id: bfbqqeo6jk**********
       batch_settings:
         size: "1"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91t**********
         function_tag: $latest
         service_account_id: bfbqqeo6j**********
   status: ACTIVE
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To create a trigger for the message queue:

   1. In the configuration file, describe the trigger parameters:

      * `name`: Timer name. The name format is as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `message_queue`: Message queue parameters:
         * `queue_id`: Queue ID.

            To find out the queue ID:

            1. In the [management console]({{ link-console-main }}), select the folder containing the queue.
            1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
            1. Select the desired queue.
            1. You can see the queue ID under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** in the **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}** field.

         * `service_account_id`: ID of the service account with rights to invoke a function.
         * `batch_size`: Message batch size. This is an optional parameter. The values may range from 1 to 10. The default value is 1.
         * `batch_cutoff`: Maximum wait time. This is an optional parameter. The values may range from 0 to 20 seconds. The default value is 10 seconds. The timer groups messages for a period not exceeding `batch-cutoff` and sends them to a function or container. The number of messages cannot exceed `batch-size`.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<timer name>"
        description = "<trigger description>"
        message_queue {
          queue_id           = "<queue ID>"
          service_account_id = "<service account ID>"
          batch_size         = "1"
          batch_cutoff       = "10"
        }
        function {
          id = "<function ID>"
        }
      }
      ```

      For more information about the resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

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

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

- API {#api}

   To create a trigger for {{ message-queue-full-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- {{ sf-name }}

   {% include [check-result](../../../_includes/functions/check-result.md) %}

- {{ message-queue-name }}

   Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
   1. Select the queue that you created the trigger for.
   1. Go to **{{ ui-key.yacloud.common.monitoring }}**. Check the **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}** chart.

{% endlist %}

## See also {#see-also}

* [Trigger for {{ message-queue-short-name }} that sends messages to the {{ serverless-containers-name }} container](../../../serverless-containers/operations/ymq-trigger-create.md).
