# Creating a trigger for {{ yds-name }} that invokes a {{ sf-name }} function

{% if audience == "external" %} Create a [trigger for {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md) that calls a [{{ sf-name }} function](../../concepts/function.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts). {% endif %}

## Before you begin {#before-you-begin}

To create a trigger, you need:

* A function that the trigger will invoke. If you don't have a function:

   * [Create a function](../function/function-create.md).
   * [Create a function version](../function/version-manage.md).

* (optional) A [Dead Letter Queue](../../concepts/dlq.md) where messages that could not be processed by a function will be redirected. If you don't have a queue, [create one](../../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a function.
   * To read from the stream that activates the trigger when data is sent there.
   * (optional) To write to the Dead Letter Queue.

   You can use the same service account or different ones. If you don't have a service account, [create one](../../../iam/operations/sa/create.md).

* The stream that activates the trigger when it receives data. {% if audience == "external" %} If you don't have a stream, [create one](../../../data-streams/quickstart/create-stream.md). {% endif %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ yds-name }}**.
      * In the **Launched resource** field, select **Function**.

   1. Under **{{ yds-name }} settings**, select a data stream and a service account with rights to read data from this data stream and write data to it.

   1. (optional) Under **Batch message settings**, specify:

      * Size of the message group in bytes. Valid values range from 1 B to 64 KB. The default is 1 B.
      * Maximum wait time. Valid values range from 1 to 60 seconds. The default is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. The total amount of data passed to a function may exceed the specified group size if the data is transmitted as a single message. Otherwise, the amount of data does not exceed the group size.

   1. Under **Function settings**, select a function and specify:

      {% include [function-settings](../../../_includes/functions/function-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

   1. (optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a function, run the command:

   ```bash
   yc serverless trigger create yds \
     --name <trigger name> \
     --database <database location> \
     --stream <data stream name> \
     --batch-size 1b \
     --batch-cutoff 1s \
     --stream-service-account-id <service account ID> \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--database`: Location of the {{ ydb-short-name }} database that the {{ yds-name }} stream is linked to.

      To find out where the database is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, the `database` parameter, such as `/{{ region-id }}/b1gia87mba**********/etn7hehf6g*******`.

   * `--stream`: {{ yds-name }} data stream name.
   * `--batch-size`: Message batch size. Optional. Valid values range from 1 B to 64 KB. The default is 1 B.
   * `--batch-cutoff`: Maximum waiting time. Optional. Valid values range from 1 to 60 seconds. The default is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The total amount of data passed to a function may exceed `batch-size` if the data is transmitted as a single message. Otherwise, the amount of data does not exceed `batch-size`.
   * `--stream-service-account-id`: ID of the service account with rights to read from the data stream and write to it.

   {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1smnfisr5**********
   folder_id: b1gc1t4cb6**********
   created_at: "2022-10-31T10:57:08.234586266Z"
   name: data-streams-trigger
   rule:
     data_stream:
       database: /ru-central1/b1gvlrnlei**********/etn3ege6nj**********
       stream: yds-stream
       service_account_id: aje07l4q4v**********
       batch_settings:
         size: "1"
         cutoff: 1s
       invoke_function:
         function_id: d4e155orh3**********
         function_tag: $latest
         service_account_id: aje07l4q4v**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue_id: yrn:yc:ymq:ru-central1:b1gc1t4cb6**********:queue_dead
           service_account_id: aje07l4q4v**********
   status: ACTIVE
   ```

- API

   You can create a trigger for {{ yds-name }} using the [create](../../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/data-streams-trigger-create.md).
