Create a trigger for a {{ message-queue-full-name }} [message queue](../../message-queue/concepts/queue.md) and process the messages using the {{ sf-name }} [function](../../functions/concepts/function.md).

For more information about creating a trigger for {{ message-queue-short-name }} that calls a container, see the [{{ serverless-containers-full-name }} documentation](../../serverless-containers/operations/ymq-trigger-create.md).

{% note warning %}

* You can only create a trigger for a standard message queue.
* The trigger must be in the same cloud as the queue that messages are read from.
* Only one trigger can be created for each message queue.

{% endnote %}

## Before you begin {#before-begin}

To create a trigger, you need:

* A function that the trigger will launch. If you don't have a function:

   * [Create a function](../../functions/operations/function/function-create.md).
   * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a function.
   * To read from the queue the trigger receives messages from.
   * (optional) To write to the [Dead Letter Queue](../../functions/concepts/dlq.md).

   You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

* A message queue that the trigger receives messages from. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

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
      * In the **Type** field, select **Message Queue**.
      * In the **Launched resource** field, select **Function**.

   1. Under **Message Queue settings**, select a message queue and a service account with rights to read messages from it.

   1. (optional) Under **Batch message settings**, specify:

      * Batch size. Values can be from 1 to 10. The default is 1.
      * Maximum wait time. Values can be from 0 to 20 seconds. The default is 10 seconds.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. However, the number of messages does not exceed the specified group size.

   1. Under **Function settings**, select a function and specify:

      * [Tag of the function version](../../functions/concepts/function.md#tag);
      * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that launches a function, run the command:

   ```
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
      1. Select **{{ message-queue-name }}**.
      1. Select the desired queue.
      1. You can see the queue ID under **General information** in the **ARN** field.

   * `--invoke-function-id`: Function ID.
   * `--queue-service-account-name`: Service account with rights to read messages from the queue.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--batch-size`: Message batch size. Optional. Values can be from 1 to 10. The default is 1.
   * `--batch-cutoff`: Maximum waiting time. Optional. Values can be from 0 to 20 seconds. The default is 10 seconds. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. At the same time, the number of messages does not exceed `batch-size`.

   Result:
   ```
   id: dd0cspdch6dslu9n3i5g
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:14:45.762915Z"
   name: ymq-trigger
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknnpj1ll45e:my-mq
       service_account_id: bfbqqeo6jkpls2tse5o6
       batch_settings:
         size: "1"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91ta21vdrrgma
         function_tag: $latest
         service_account_id: bfbqqeo6jkpls2tse5o6
   status: ACTIVE
   ```

- API

   You can create a trigger for {{ message-queue-full-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger for the message queue:

   1. In the configuration file, describe the trigger parameters:

      * `name`: Timer name. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `message_queue`: Message queue parameters:
         * `queue_id`: Queue ID.

            To find out the queue ID:

            1. In the [management console]({{ link-console-main }}), select the folder containing the queue.
            1. Select **{{ message-queue-name }}**.
            1. Select the desired queue.
            1. You can see the queue ID under **General information** in the **ARN** field.

         * `service_account_id`: ID of the service account with rights to invoke a function.
         * `batch_size`: Message batch size. Optional. Values can be from 1 to 10. The default is 1.
         * `batch_cutoff`: Maximum waiting time. Optional. Values can be from 0 to 20 seconds. The default is 10 seconds. The timer groups messages for a period not exceeding `batch-cutoff` and sends them to a function or container. At the same time, the number of messages does not exceed `batch-size`.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.

      Example configuration file structure:

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

      For more information about the resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

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

{% list tabs %}

- {{ sf-name }}

   {% include [check-result](check-result.md) %}

- {{ message-queue-name }}

   Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:

   1. In the [management console]({{ link-console-main }}), select **{{ message-queue-name }}**.
   1. Select the queue that you created the trigger for.
   1. Go to **Monitoring**. View the **Messages in queue** chart.

{% endlist %}
