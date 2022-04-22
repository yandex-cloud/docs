Create a trigger for the {{ message-queue-full-name }} [message queue](../../message-queue/concepts/queue.md) and process messages using a {{ sf-name }} [function](../../functions/concepts/function.md) or {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md).

{% note warning %}

* You can only create a trigger for a standard message queue.
* The trigger must be in the same cloud as the queue that messages are read from.
* Only one trigger can be created for each message queue.

{% endnote %}

## Before you start {#before-begin}

To create a trigger, you need:

* A function or a container the trigger will launch.

   * If you don't have a function:

      * [Create a function](../../functions/operations/function/function-create.md).
      * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

   * If you don't have a container:

      * [Create a container](../../serverless-containers/operations/create.md).
      * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* A message queue that the trigger receives messages from. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a function or a container.
   * To read from the queue the trigger receives messages from.
   * (optional) To write to the [Dead Letter Queue](../../functions/concepts/dlq.md).

   You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Open **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Message Queue**.
      * Choose what the trigger will launch — a function or a container.

   1. Under **Message Queue settings**, select a message queue and a service account with rights to read messages from it.

   1. (optional) Under **Batch message settings**, specify:

      * Batch size. Values can be from 1 to 10. The default is 1.
      * Maximum wait time. Values can be from 0 to 20 seconds. The default is 10 seconds.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function or container. However, the number of messages does not exceed the specified group size.

   1. If the trigger launches:

      * A function, select one under **Function settings** and specify:

         * [Tag of the function version](../../functions/concepts/function.md#tag);
         * [A service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

      * A container, select one under **Container settings** and specify:

         * [A container revision](../../serverless-containers/concepts/container.md#revision);
         * [A service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

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
      1. Open **{{ message-queue-name }}**.
      1. Select the desired queue.
      1. You can see the queue ID under **General information** in the **ARN** field.

   * `--invoke-function-id`: Function ID.
   * `--queue-service-account-name`: Service account with rights to read messages from the queue.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--batch-size`: Message batch size. Optional. Values can be from 1 to 10. The default is 1.
   * `--batch-cutoff`: Maximum waiting time. Optional. Values can be from 0 to 20 seconds. The default is 10 seconds. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function or container. At the same time, the number of messages does not exceed `batch-size`.

   Result:
   ```
   id: dd0cspdch6dslu9n3i5g
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:14:45.762915Z"
   name: ymq-trigger
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
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

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- Functions

   {% include [check-result](check-result.md) %}

- Message Queue

   Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:

   1. In the [management console]({{ link-console-main }}), open **{{ message-queue-name }}**.
   1. Select the queue that you created the trigger for.
   1. Go to **Monitoring**. View the **Messages in queue** chart.

{% endlist %}
