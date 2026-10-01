# Creating a trigger for {{ message-queue-name }} that sends messages to {{ sf-name }}

Create a [trigger](../../concepts/trigger/ymq-trigger.md) for a [message queue](../../../message-queue/concepts/queue.md) in {{ message-queue-short-name }} and process the messages using [{{ sf-name }}](../../concepts/function.md).

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

## Getting started {#before-begin}

To create a trigger, you will need: 

* Function the trigger will invoke. If you do not have a function:

    * [Create a function](../function/function-create.md).
    * [Create a function version](../function/version-manage.md).

* [Service accounts](../../../iam/concepts/users/service-accounts.md) with the following permissions:

    * To invoke functions, e.g., [{{ roles-functions-invoker }}](../../security/index.md#functions-functionInvoker).
    * To read from the queue the trigger receives messages from, e.g., [ymq.reader](../../../message-queue/security/index.md#ymq-reader).

    You can use the same service account or different ones. If you do not have a service account, [create one](../../../iam/operations/sa/create.md).

* Message queue the trigger will receive messages from. If you do not have a queue, [create one](../../../message-queue/operations/message-queue-new-queue.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

    1. [Navigate]({{ link-console-main }}/link/functions) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.

        * {% include [triggers-labels-step](../../../_includes/functions/triggers-labels-step.md) %}

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select a message queue and a service account with the permission to read messages from that queue.

    1. {% include [batch-settings-ymq](../../../_includes/functions/batch-settings-ymq.md) %}

    1. Under **Targets**:

        1. In the **Target type** field, select `Function`.

        1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

            {% include [function-settings](../../../_includes/functions/function-settings.md) %}

        1. {% include [trigger-console-filter](../../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../../_includes/functions/trigger-console-template.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger that invokes a function, run this command:

    ```bash
    yc serverless trigger create message-queue \
      --name <trigger_name> \
      --queue <queue_ID> \
      --queue-service-account-id <service_account_ID> \
      --invoke-function-id <function_ID> \
      --invoke-function-service-account-id <service_account_ID> \
      --batch-size <message_batch_size> \
      --batch-cutoff <maximum_wait_time>
    ```

    Where:

    * `--name`: Trigger name.
    * `--queue`: Queue ID.

        To find out the queue ID:

        1. In the [management console]({{ link-console-main }}), navigate to the folder containing the queue.
        1. [Navigate]({{ link-console-main }}/link/message-queue) to **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
        1. Select the queue.
        1. You can see the queue ID under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** in the **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}** field.

    * `--invoke-function-id`: Function ID.
    * `--queue-service-account-name`: ID of the service account with permissions to read messages from the queue.
    * `--invoke-function-service-account-id`: ID of the service account with permissions to invoke the function.
    * `--batch-size`: Message batch size. This is an optional setting. The values may range from 1 to 1,000. The default value is 1.
    * `--batch-cutoff`: Maximum wait time. This is an optional setting. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger groups messages within the `batch-cutoff` period and sends them to the function. The number of messages cannot exceed `batch-size`.

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

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a trigger for {{ message-queue-name }}:

  1. Describe the trigger in the configuration file:

     ```hcl
     resource "yandex_serverless_triggers" "my_trigger" {
       name        = "<trigger_name>"
       description = "<trigger_description>"
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
         invoke_function {
           function_id        = "<function_ID>"
           service_account_id = "<service_account_ID>"
         }
       }
     }
     ```

     Where:

     {% include [tf-triggers-common-params](../../../_includes/tf-triggers-common-params.md) %}

     * `source`: Event source settings:

       * `ymq`: Message queue settings:

         * `queue_arn`: Message queue ARN.

             To find out the queue ARN:

             1. In the [management console]({{ link-console-main }}), navigate to the folder containing the queue.
             1. [Navigate]({{ link-console-main }}/link/message-queue) to **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
             1. Select the queue.
             1. You can see the queue ARN under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** in the **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}** field.

         * `service_account_id`: ID of the service account with permissions to read messages from the queue.
         * `visibility_timeout`: Message [visibility timeout](../../../message-queue/concepts/visibility-timeout.md) that overrides the value specified in the queue. This is an optional parameter.

         {% include [tf-triggers-batch-settings](../../../_includes/tf-triggers-batch-settings.md) %}

     * `action`: Target settings. You can specify this section multiple times so that the trigger calls multiple resources, including those of different types. There are [limits](../../concepts/limits.md#functions-limits) on the maximum number of resources.

         * `invoke_function`: Function settings:

             * `function_id`: Function ID.
             * `function_tag`: Function version tag. This is an optional parameter. If it is not specified, the latest version of the function is called.
             * `service_account_id`: ID of the service account with permissions to invoke the function.

         * `filter`: Filtering events before sending them to the target. This is an optional section.

             * `jq`: [jq template](https://jqlang.github.io/jq/manual/) to filter events sent to the target. It not specified, all events reach the target.

         * `transformer`: Transforming events before sending them to the target. This is an optional section.

             * `jq`: jq template to transform events before sending them to the target. It omitted, no transformations apply to the events.

         * `dead_letter`: Dead-letter queue settings. This is an optional section.

             * `dead_letter_queue`: Queue settings:

                 * `queue_arn`: Queue ARN.
                 * `service_account_id`: ID of the service account with permissions to write to the queue.
                 * `message_attributes`: Attributes to add to each message in the queue, in `key:value` format. This is an optional parameter.

     For more on the properties of the `yandex_serverless_triggers` resource, see [this provider guide]({{ tf-provider-resources-link }}/serverless_triggers).

     {% cut "Configuration for the yandex_function_trigger resource" %}

     ```
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<trigger_name>"
       description = "<trigger_description>"
       function {
         id                 = "<function_ID>"
         service_account_id = "<service_account_ID>"
       }
       message_queue {
         queue_id           = "<queue_ID>"
         service_account_id = "<service_account_ID>"
         batch_size         = "<message_batch_size>"
         batch_cutoff       = "<maximum_wait_time>"
     }
     ```

     Where:

     * `name`: Trigger name. The name format is as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `description`: Trigger description.

     * `function`: Function settings:

       * `id`: Function ID.
       * `service_account_id`: ID of the service account with permissions to invoke the function.

     * `message_queue`: Trigger settings:

       * `queue_id`: Message queue ID.

           To find out the queue ID:

           1. In the [management console]({{ link-console-main }}), navigate to the folder containing the queue.
           1. [Navigate]({{ link-console-main }}/link/message-queue) to **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
           1. Select the queue.
           1. You can see the queue ID under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** in the **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}** field.

       * `service_account_id`: ID of the service account with permissions to read messages from the queue.
       * `batch_size`: Message batch size. This is an optional setting. The values may range from 1 to 1,000. The default value is 1.
       * `batch_cutoff`: Maximum wait time. This is an optional setting. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger groups messages within the `batch-cutoff` period and sends them to the function. The number of messages cannot exceed `batch-size`.

     For more on the properties of the `yandex_function_trigger` resource, see [this provider guide]({{ tf-provider-resources-link }}/function_trigger).

     {% endcut %}

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  To create a trigger for {{ message-queue-full-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- {{ sf-name }}

    {% include [check-result](../../../_includes/functions/check-result.md) %}

- {{ message-queue-name }}

    Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:

    1. [Navigate]({{ link-console-main }}/link/message-queue) to **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
    1. Select the queue for which you created the trigger.
    1. Go to **{{ ui-key.yacloud.common.monitoring }}**. Check the **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}** chart.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../../serverless-containers/operations/ymq-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/ymq-trigger-create.md)
