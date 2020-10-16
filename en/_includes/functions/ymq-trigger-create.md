{% include [triggers-preview](triggers-preview-stage.md) %}

Create a trigger for the [message queue](../../message-queue/concepts/queue.md) of {{ message-queue-full-name }} and process messages using the [function](../../functions/concepts/function.md) {{ sf-name }}.

{% note warning %}

- The trigger must be in the same cloud as the queue that messages are read from.
- Only one trigger can be created for each message queue.

{% endnote %}

## Before you start {#before-begin}

To create a trigger, you need:

1. Service accounts with rights to read messages from a message queue and to call a function. You can use the same service account for both operations. If you don't have a service account, [create one](../../iam/operations/sa/create.md).
1. [A message queue](../../message-queue/concepts/queue.md) that the trigger will pick up messages from. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).
1. [Functions](../../functions/concepts/function.md) the trigger will send messages to for processing. If you don't have a function:
    - [Create a function](../../functions/operations/function/function-create.md).
    - [Create a version of the function and upload the function code to it](../../functions/operations/function/version-manage.md#func-version-create).

## Create a trigger {#trigger-create}

Create a trigger for the message queue.

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Create a trigger:

    - `--name`: Trigger name.

    - `--queue`: Unique queue ID.

        To find out the unique queue ID:
        1. Open **Message Queue** in the [management console]({{ link-console-main }}).
        1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of the queue you would like to create a trigger for.
        1. In the **Overview** page, under **General information**, copy the unique queue ID from the **ARN** field.

    - `--invoke-function-id`: Unique function ID.

    - `--queue-service-account-name`: Service account with rights to read messages from the queue.

    - `--invoke-function-service-account-id`: Service account with rights to call the function.

    - `--batch-size`: Message batch size. Optional parameter. Values can be from 1 to 10. The default is 1.

    ```
    $ yc serverless trigger create message-queue \
        --name test-trigger \
        --queue yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq \
        --queue-service-account-id bfbqqeo6jkpls2tse5o6 \
        --invoke-function-id b09e5lu91ta21vdrrgma \
        --invoke-function-service-account-id bfbqqeo6jkpls2tse5o6 \
        --batch-size 10
    id: dd0cspdch6dslu9n3i5g
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:14:45.762915Z"
    name: test-trigger
    rule:
      message_queue:
        arn: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6        
    ```

{% endlist %}

## Check the results {#check-result}

Make sure that the trigger works correctly: in {{ message-queue-name }}, you see that messages are picked up from the queue, while in {{ sf-name }} you see that the function was started.

{% list tabs %}

- Functions

    Check the function logs to see if the function was run:

    1. The function logs should contain information about the function call. In this example, the function outputs information about the messages processed.

        ```
        $ yc serverless function logs b09e5lu91ta21vdrrgma
        
        2019-08-28 12:26:50     START RequestID: a5e4f3a3-9533-4eca-820c-82887258da46 Version: b09m126ee29375fq7qva
        2019-08-28 12:26:51     MESSAGE_BATCH
        2019-08-28 12:26:51     [
        2019-08-28 12:26:51       {
        2019-08-28 12:26:51         "event_metadata": {
        2019-08-28 12:26:51           "event_id": "1cc52025-f485e7bd-32441eed-3bce2ebc",
        2019-08-28 12:26:51           "event_type": "yandex.cloud.events.messagequeue.QueueMessage",
        2019-08-28 12:26:51           "created_at": {
        2019-08-28 12:26:51             "seconds": 1566995011,
        2019-08-28 12:26:51             "nanos": 111000000
        2019-08-28 12:26:51           },
        2019-08-28 12:26:51           "cloud_id": "aoegtvhtp8ob9rqq8sto",
        2019-08-28 12:26:51           "folder_id": "aoek49ghmknnpj1ll45e"
        2019-08-28 12:26:51         },
        2019-08-28 12:26:51         "details": {
        2019-08-28 12:26:51           "queue_arn": "yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq",
        2019-08-28 12:26:51           "message_id": "1cc52025-f485e7bd-32441eed-3bce2ebc",
        2019-08-28 12:26:51           "content_hash": "ed076287532e86365e841e92bfc50d8c",
        2019-08-28 12:26:51           "body": "SGVsbG8gV29ybGQh",
        2019-08-28 12:26:51           "system_attributes": {
        2019-08-28 12:26:51             "ApproximateFirstReceiveTimestamp": "1566995209950",
        2019-08-28 12:26:51             "ApproximateReceiveCount": "1",
        2019-08-28 12:26:51             "SentTimestamp": "1566995011111"
        2019-08-28 12:26:51           }
        2019-08-28 12:26:51         }
        2019-08-28 12:26:51       }
        2019-08-28 12:26:51     ]
        2019-08-28 12:26:51     END RequestID: a5e4f3a3-9533-4eca-820c-82887258da46
        2019-08-28 12:26:51     REPORT RequestID: a5e4f3a3-9533-4eca-820c-82887258da46 Duration: 444.728 ms Billed Duration: 500 ms Memory Size: 128 MB Max Memory Used: 13 MB
        ```

- Message Queue

    Check the queue statistics to see if the number of enqueued messages is decreasing:
    1. Open the **Message Queue** section.
    1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of the queue that the trigger was created for.
    1. Go to **Monitoring**. Pay attention to the **Messages in queue** chart.

{% endlist %}

