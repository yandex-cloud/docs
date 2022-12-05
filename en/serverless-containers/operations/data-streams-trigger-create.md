# Creating a trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container

 Create a [trigger for {{ yds-name }}](../concepts/trigger/data-streams-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when data is sent to a [stream](../../data-streams/concepts/glossary.md#stream-concepts). 

## Before you begin {#before-you-begin}

To create a trigger, you need:

* A container that the trigger will invoke. If you don't have a container:

   * [Create a container](create.md).
   * [Create a container revision](manage-revision.md#create).

* (optional) A [Dead Letter Queue](../concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a container.
   * To read from the stream that activates the trigger when data is sent there.
   * (optional) To write to the Dead Letter Queue.

   You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

* The stream that activates the trigger when it receives data.  If you don't have a stream, [create one](../../data-streams/quickstart/create-stream.md). 

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Open **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ yds-name }}**.
      * In the **Launched resource** field, select **Container**.

   1. Under **{{ yds-name }} settings**, select a data stream and a service account with rights to read data from this data stream and write data to it.

   1. (optional) Under **Batch message settings**, specify:

      * Size of the message group in bytes. Valid values range from 1 B to 64 KB. The default is 1 B.
      * Maximum wait time. Valid values range from 1 to 60 seconds. The default is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a container. The total amount of data passed to a container may exceed the specified group size if the data is transmitted as a single message. Otherwise, the amount of data does not exceed the group size.

   1. Under **Container settings**, select a container and specify:

      {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (optional) **Under Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run the command:

   ```bash
   yc serverless trigger create yds \
     --name <trigger_name> \
     --database <database_location> \
     --stream <data_stream_name> \
     --batch-size 1b \
     --batch-cutoff 1s \
     --stream-service-account-id <service_account_ID> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--database`: Location of the {{ ydb-short-name }} database that the {{ yds-name }} stream is linked to.

      To find out where the database is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, the `database` parameter, such as `/{{ region-id }}/b1gia87mba**********/etn7hehf6g*******`.

   * `--stream`: Data stream name.
   * `--batch-size`: Message batch size. Optional. Valid values range from 1 B to 64 KB. The default is 1 B.
   * `--batch-cutoff`: Maximum waiting time. Optional. Valid values range from 1 to 60 seconds. The default is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a container. The total amount of data passed to a container may exceed `batch-size` if the data is transmitted as a single message. Otherwise, the amount of data does not exceed `batch-size`.
   * `--stream-service-account-id`: ID of the service account with rights to read from the data stream and write to it.

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktij**********
   folder_id: b1gmit33hg**********
   created_at: "2022-10-24T14:07:04.693126923Z"
   name: data-streams-trigger
   rule:
     data_stream:
       database: /{{ region-id }}/b1gia87mba**********/etn7heh**********
       stream: streams-name
       service_account_id: ajep8qm0k**********
       batch_settings:
         size: "1"
         cutoff: 1s
       invoke_container:
         container_id: bba5jb38o8**********
         service_account_id: aje03adgd2**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
           service-account-id: aje3lebfem**********
   status: ACTIVE
   ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ yds-name }} that invokes a {{ sf-name }} function](../../functions/operations/trigger/data-streams-trigger-create.md).
