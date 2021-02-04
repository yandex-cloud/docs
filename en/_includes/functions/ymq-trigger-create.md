Create a trigger for the [message queue](../../message-queue/concepts/queue.md) of {{ message-queue-full-name }} and process messages using the [function](../../functions/concepts/function.md) {{ sf-name }}.

{% note warning %}

* The trigger must be in the same cloud as the queue that messages are read from.
* Only one trigger can be created for each message queue.

{% endnote %}

## Before you start {#before-begin}

To create a trigger, you need:

1. [Functions](../../functions/concepts/function.md) the trigger will send messages to for processing. If you don't have a function:
    * [Create a function](../../functions/operations/function/function-create.md).
    * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).
1. [A message queue](../../message-queue/concepts/queue.md) that the trigger will pick up messages from. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).
1. Service accounts with rights to read messages from a message queue and to call a function. You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Create a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a trigger.
    1. Open **{{ sf-name }}**.
    1. Go to the **Triggers** tab.
    1. Click **Create trigger**.
    1. Under **Basic parameters**:
        * Enter a name and description for the trigger.
        * In the **Type** field, select **Message Queue**.
    1. Under **Message Queue settings**, select a message queue and a service account with rights to read messages from it.
    1. Under **Batch message settings**, specify the message batch size and the maximum waiting time. The trigger will send the batch of messages to the function when the number of messages in the queue reaches the specified batch size or the maximum waiting time expires.
    1. Under **Function settings**:
        * Select the function for the trigger to call.
        * Specify the [function version tag](../../functions/concepts/function.md#tag).
        * Specify the service account to be used to call the function.
    1. Click **Create trigger**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To create a trigger, run the command:

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

    where:
    * `--name`: Trigger name.
    * `--queue`: Queue ID.
    To find out the queue ID:
        1. In the [management console]({{ link-console-main }}), go to the folder where the queue is located.
        1. Open {{ message-queue-full-name }}.
        1. Select the desired queue.
        1. You can see the queue ID under **General information** in the **ARN** field.
    * `--invoke-function-id`: Function ID.
    * `--queue-service-account-name`: Service account with rights to read messages from the queue.
    * `--invoke-function-service-account-id`: Service account with rights to call the function.
    * `--batch-size`: Message batch size. Values can be from 1 to 10. The default is 1.
    * `--batch-cutoff`: Maximum waiting time. Values can be from 0 to 20 seconds. The default is 10 seconds. The trigger will send the batch of messages to the function when the number of messages in the queue reaches the `batch-size` or the `batch-cutoff` expires.

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

    You can create a trigger for {{ message-queue-full-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md) API method.

{% endlist %}

## Check the results {#check-result}

{% list tabs %}

- Functions

    {% include [check-result](check-result.md) %}

- Message Queue

    Check that the number of enqueued messages is decreasing. To do this, view the queue statistics:
    1. Open **Message Queue**.
    1. Select the queue that you created the trigger for.
    1. Go to **Monitoring**. View the **Messages in queue** chart.

{% endlist %}

