# Creating a trigger for {{ message-queue-name }} that sends messages to a container in {{ serverless-containers-name }}

Create a [trigger for a {{ message-queue-short-name }}](../concepts/trigger/ymq-trigger.md) and process messages using a [container](../concepts/container.md) in {{ serverless-containers-name }}.

{% include [ymq-trigger-note.md](../../_includes/functions/ymq-trigger-note.md) %}

## Getting started {#before-begin}

To create a trigger, you will need:

* Container the trigger will invoke. If you do not have a container:

    * [Create a container](create.md).
    * [Create a container revision](manage-revision.md#create).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with the following permissions:

    * To invoke a container.
    * To read from the queue the trigger receives messages from.

    You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).

* Message queue the trigger will receive messages from. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

    1. [Navigate]({{ link-console-main }}/link/serverless-containers) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.

        * {% include [triggers-labels-step](../../_includes/functions/triggers-labels-step.md) %}

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select a message queue and a service account with the permission to read messages from that queue.

    1. {% include [batch-settings-ymq](../../_includes/functions/batch-settings-ymq.md) %}

    1. Under **Targets**:

        1. In the **Target type** field, select `Container`.

        1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

        1. {% include [trigger-console-filter](../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../_includes/functions/trigger-console-template.md) %}

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
      --batch-size <message_batch_size> \
      --batch-cutoff <maximum_wait_time>
    ```

    Where:

    * `--name`: Trigger name.
    * `--queue`: Queue ID.

        {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

    * `--invoke-container-id`: Container ID.
    * `--queue-service-account-id`: ID of the service account with permissions to read messages from the queue.
    * `--invoke-container-service-account-id`: ID of the service account with permissions to invoke the container.
    * `--batch-size`: Message batch size. This is an optional setting. The values may range from 1 to 1,000. The default value is 1.
    * `--batch-cutoff`: Maximum wait time. This is an optional setting. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger groups messages within the `batch-cutoff` period and sends them to the container. The number of messages cannot exceed `batch-size`.

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

  1. Describe the trigger in the configuration file:

     ```hcl
     resource "yandex_serverless_triggers" "my_trigger" {
       name = "<trigger_name>"
       source {
         ymq {
           queue_arn          = "<queue_ARN>"
           service_account_id = "<service_account_ID>"
           visibility_timeout = "<message_visibility_timeout>"
           batch_settings {
             max_count = "<max_number_of_messages>"
             max_bytes = "<max_group_size_in_bytes>"
             cutoff    = "<maximum_wait_time>"
           }
         }
       }
       action {
         invoke_container {
           container_id       = "<container_ID>"
           path               = "<HTTP_path>"
           service_account_id = "<service_account_ID>"
         }
       }
     }
     ```

     Where:

     {% include [tf-triggers-common-params](../../_includes/tf-triggers-common-params.md) %}

     * `source`: Event source settings:

       * `ymq`: Message queue settings:

         * `queue_arn`: Queue ARN.

             {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

         * `service_account_id`: ID of the service account with permissions to read messages from the queue.
         * `visibility_timeout`: Message [visibility timeout](../../message-queue/concepts/visibility-timeout.md) that overrides the value specified in the queue. This is an optional parameter.

         {% include [tf-triggers-batch-settings](../../_includes/tf-triggers-batch-settings.md) %}

     * `action`: Target settings. You can specify this section multiple times so the trigger calls multiple resources, including those of different types. There are [limits](../concepts/limits.md#serverless-containers-limits) on the maximum number of resources.

         * `invoke_container`: Container settings:

             * `container_id`: Container ID.
             * `path`: HTTP path to call the container at. This is an optional parameter.
             * `service_account_id`: ID of the service account with permissions to invoke the container.

         * `filter`: Filtering events before sending them to the target. This is an optional section.

             * `jq`: [jq template](https://jqlang.github.io/jq/manual/) to filter events before they are sent to the target. It omitted, all events are sent to the target.

         * `transformer`: Transforming events before sending them to the target. This is an optional section.

             * `jq`: jq template to transform events before sending them to the target. It omitted, no transformations apply to the events.

         * `dead_letter`: Dead-letter queue settings. This is an optional section.

             * `dead_letter_queue`: Queue properties:

                 * `queue_arn`: Queue ARN.
                 * `service_account_id`: ID of the service account with permissions to write to the queue.
                 * `message_attributes`: Attributes to add to each message within the queue, in `key:value` format. This is an optional parameter.

     For more on the properties of the `yandex_serverless_triggers` resource, see [this provider guide]({{ tf-provider-resources-link }}/serverless_triggers).

     {% cut "Configuration for the yandex_function_trigger resource" %}

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name = "<trigger_name>"
       container {
         id                 = "<container_ID>"
         service_account_id = "<service_account_ID>"
       }
       message_queue {
         queue_id           = "<queue_ID>"
         service_account_id = "<service_account_ID>"
         batch_cutoff       = "<maximum_wait_time>"
         batch_size         = "<message_batch_size>"
       }
     }
     ```

     Where:

     * `name`: Trigger name. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}

     * `container`: Container settings:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

     * `message_queue`: Trigger settings:

         * `queue_id`: Queue ID.

             {% include [ymq-id](../../_includes/serverless-containers/ymq-id.md) %}

         * `service_account_id`: ID of the service account with permissions to read messages from the queue.

         * `batch_cutoff`: Maximum wait time. This is an optional setting. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger groups messages within the `batch-cutoff` period and sends them to the container. The number of messages cannot exceed `batch-size`.
         * `batch_size`: Message batch size. This is an optional setting. The values may range from 1 to 1,000. The default value is 1.

     For more on the properties of the `yandex_function_trigger` resource, see [this provider guide]({{ tf-provider-resources-link }}/function_trigger).

     {% endcut %}

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  To create a trigger for {{ message-queue-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- {{ serverless-containers-name }}

    {% include [check-result](../../_includes/serverless-containers/check-result.md) %}

- {{ message-queue-name }}

    Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:

   1. In the [management console]({{ link-console-main }}), go to the folder where you created the trigger.
   1. [Navigate]({{ link-console-main }}/link/message-queue) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ymq }}**.
   1. Select the queue for which you created the trigger.
   1. Go to **{{ ui-key.yacloud.common.monitoring }}**. Check the **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}** chart.

{% endlist %}


#### Useful links {#see-also}

* [{#T}](../../functions/operations/trigger/ymq-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/ymq-trigger-create.md)
