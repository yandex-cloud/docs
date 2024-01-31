# Creating a trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container

 Create a [trigger for {{ yds-name }}](../concepts/trigger/data-streams-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when data is sent to a [stream](../../data-streams/concepts/glossary.md#stream-concepts). 

## Getting started {#before-you-begin}

To create a trigger, you need:

* A container that the trigger will invoke. If you do not have a container:

   * [Create a container](create.md).
   * [Create a container revision](manage-revision.md#create).

* (Optional) A [Dead Letter Queue](../concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a container.
   * To read from the stream that activates the trigger when data is sent there.
   * (Optional) To write to the Dead Letter Queue.

   You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).

* The stream that activates the trigger when it receives data. If you do not have a stream, [create one](../../data-streams/quickstart/create-stream.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}**, select a data stream and a service account with rights to read data from and write data to it.

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * Size of the message group in bytes. The values may range from 1 B to 64 KB. The default value is 1 B.
      * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a container. The total amount of data transmitted to a container may exceed the specified group size if the data is transmitted as a single message. Otherwise, the amount of data does not exceed the group size.

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

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

      To find out where the database is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, in the `database` parameter, e.g., `/{{ region-id }}/b1gia87mba**********/etn7hehf6g*******`.

   * `--stream`: Data stream name.
   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 B to 64 KB. The default value is 1 B.
   * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a container. The total amount of data transmitted to a container may exceed `batch-size` if the data is transmitted as a single message. Otherwise, the amount of data does not exceed `batch-size`.
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

- API {#api}

   To create a trigger for {{ yds-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ yds-name }} that invokes a {{ sf-name }} function](../../functions/operations/trigger/data-streams-trigger-create.md).
