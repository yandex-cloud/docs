# Creating a trigger for {{ yds-name }} that invokes a {{ sf-name }} function

 Create a [trigger for {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md) that calls a [{{ sf-name }} function](../../concepts/function.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts). 

## Getting started {#before-you-begin}

To create a trigger, you need:

* A function that the trigger will invoke. If you do not have a function:

   * [Create a function](../function/function-create.md).
   * [Create a function version](../function/version-manage.md).

* (Optional) A [Dead Letter Queue](../../concepts/dlq.md) where messages that could not be processed by a function will be redirected. If you do not have a queue, [create one](../../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a function.
   * To read from the stream that activates the trigger when data is sent there.
   * (Optional) To write to the Dead Letter Queue.

   You can use the same service account or different ones. If you do not have a service account, [create one](../../../iam/operations/sa/create.md).

* The stream that activates the trigger when it receives data. If you do not have a stream, [create one](../../../data-streams/quickstart/create-stream.md).

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}**.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}**, select a data stream and a service account with rights to read data from and write data to it.

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * Message batch size in bytes. The values may range from 1 B to 64 KB. The default value is 1 B.
      * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. The total amount of data transmitted to a function may exceed the specified batch size if the data is transmitted as a single message. Otherwise, the amount of data does not exceed the batch size.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

      {% include [function-settings](../../../_includes/functions/function-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a function, run this command:

   ```bash
   yc serverless trigger create yds \
     --name <trigger_name> \
     --database <database_location> \
     --stream <data_stream_name> \
     --batch-size 1b \
     --batch-cutoff 1s \
     --stream-service-account-id <service_account_ID> \
     --invoke-function-id <function_ID> \
     --invoke-function-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <dead_letter_queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--database`: Location of the {{ ydb-short-name }} database that the {{ yds-name }} stream is linked to.

      To find out where the database is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, in the `database` parameter, e.g., `/{{ region-id }}/b1gia87mba**********/etn7hehf6g*******`.

   * `--stream`: {{ yds-name }} data stream name.
   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 B to 64 KB. The default value is 1 B.
   * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The total amount of data transmitted to a function may exceed `batch-size` if the data is transmitted as a single message. Otherwise, the amount of data does not exceed `batch-size`.
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
       database: /{{ region-id }}/b1gvlrnlei**********/etn3ege6nj**********
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
           queue_id: yrn:yc:ymq:{{ region-id }}:b1gc1t4cb6**********:queue_dead
           service_account_id: aje07l4q4v**********
   status: ACTIVE
   ```

- API {#api}

   To create a trigger for {{ yds-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/data-streams-trigger-create.md).
