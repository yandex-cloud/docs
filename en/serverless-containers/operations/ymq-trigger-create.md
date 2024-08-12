# Creating a trigger for {{ message-queue-name }} that sends messages to a {{ serverless-containers-name }} container

Create a [trigger for a message queue in {{ message-queue-short-name }}](../concepts/trigger/ymq-trigger.md) and process the messages using the {{ serverless-containers-name }} [container](../concepts/container.md).

{% include [ymq-trigger-note.md](../../_includes/functions/ymq-trigger-note.md) %}

## Getting started {#before-begin}

To create a trigger, you need:

* A container that the trigger will invoke. If you do not have a container:

   * [Create a container](create.md).
   * [Create a container revision](manage-revision.md#create).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with the following permissions:

   * To invoke a container.
   * To read from the queue the trigger receives messages from.

   You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).

* A message queue that the trigger receives messages from. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select a message queue and a service account with permissions to read messages from this queue.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**​. The values may range from 0 to 20 seconds. The default value is 10 seconds.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**​. The values may range from 1 to 1,000. The default value is 1.

      {% include [batch-messages](../../_includes/serverless-containers/batch-messages.md) %}

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   ```bash
   yc serverless trigger create message-queue \
     --name <trigger_name> \
     --queue <queue_ID> \
     --queue-service-account-id <service_account_ID> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --batch-size 1 \
     --batch-cutoff 10s
   ```

   Where:

   * `--name`: Trigger name.
   * `--queue`: Queue ID.

      {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

   * `--invoke-container-id`: Container ID.
   * `--queue-service-account-name`: Service account with permissions to read messages from the queue.
   * `--invoke-container-service-account-id`: Service account with permissions to invoke the container.
   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 to 1,000. The default value is 1.
   * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a container. The number of messages cannot exceed `batch-size`.

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: ymq-trigger
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:my-mq
       service_account_id: bfbqqeo6jkh2********
       batch_settings:
         size: "1"
         cutoff: 10s
       invoke_container:
         container_id: bba5jb38o8h2********
         service_account_id: bfbqqeo6jkh2********
   status: ACTIVE
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a trigger for {{ message-queue-name }}:

   1. In the configuration file, describe the trigger parameters:

      
      ```
      resource "yandex_function_trigger" "my_trigger" {
        name = "<trigger_name>"
        container {
          id                 = "<container_ID>"
          service_account_id = "<service_account_ID>"
        }
        message_queue {
          queue_id           = "<queue_ID>"
          service_account_id = "<service_account_ID>"
          batch_cutoff       = "<timeout>"
          batch_size         = "<event_batch_size>"
        }
      }
      ```


      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `container`: Container parameters:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

      * `message_queue`: Trigger parameters:

         * `queue_id`: Queue ID.

            {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

         * `service_account_id`: Service account with permissions to read messages from the queue.

         * `batch_cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch_cutoff` and sends them to a container. The number of messages cannot exceed `batch_size`.
         * `batch_size`: Message batch size. This is an optional parameter. The values may range from 1 to 1,000. The default value is 1.

      For more information about the `yandex_function_trigger` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc serverless trigger list
      ```

- API {#api}

   To create a trigger for {{ message-queue-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- {{ serverless-containers-name }}

   {% include [check-result](../../_includes/serverless-containers/check-result.md) %}

- {{ message-queue-name }}

   Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:

   1. In the [management console]({{ link-console-main }}), open **{{ ui-key.yacloud.iam.folder.dashboard.label_ymq }}**.
   1. Select the queue that you created the trigger for.
   1. Go to **{{ ui-key.yacloud.common.monitoring }}**. Check the **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}** chart.

{% endlist %}


## See also {#see-also}

* [Trigger for {{ message-queue-name }} that sends messages to the {{ sf-name }} function](../../functions/operations/trigger/ymq-trigger-create.md).
