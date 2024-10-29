# Creating a trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container

 Create a [trigger for {{ yds-name }}](../concepts/trigger/data-streams-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when data is sent to a [stream](../../data-streams/concepts/glossary.md#stream-concepts). 

## Getting started {#before-you-begin}

To create a trigger, you need:

* A container that the trigger will invoke. If you do not have a container:

    * [Create a container](create.md).
    * [Create a container revision](manage-revision.md#create).

* Optionally, a [dead-letter queue](../concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with the following permissions:

    * To invoke a container.
    * To read from the stream that activates the trigger when data is sent there.
    * (Optional) To write to the dead-letter queue.

    You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).

* The stream that will activate the trigger when it receives data.   If you do not have a stream, [create one](../../data-streams/quickstart/create-stream.md). 

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder you want to create a trigger in.

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}**, select a data stream and a service account with permissions to read data from the stream and write data to it.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. The values may range from 1 to 60 seconds. The default value is 1 second.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_stream-size }}**. The values may range from 1 B to 64 KB. The default value is 1 B.

        The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a container. The total amount of data transmitted to a container may exceed the specified batch size if the data is transmitted as a single message. Otherwise, the amount of data does not exceed the batch size.

    1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a trigger that invokes a container, run this command:

    ```bash
    yc serverless trigger create yds \
      --name <trigger_name> \
      --database <database_location> \
      --stream <stream_name> \
      --batch-size <message_group_size> \
      --batch-cutoff <maximum_timeout> \
      --stream-service-account-id <service_account_ID> \
      --invoke-container-id <container_ID> \
      --invoke-container-service-account-id <service_account_ID> \
      --retry-attempts <number_of_retries> \
      --retry-interval <interval_between_retries> \
      --dlq-queue-id <dead-letter_queue_ID> \
      --dlq-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--database`: Location of the {{ ydb-short-name }} DB the {{ yds-name }} stream is linked to.

      To find out where the DB is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, in the `database` parameter, e.g., `/{{ region-id }}/b1gia87mbah2********/etn7hehf6gh3********`.

    * `--stream`: Stream name.
    * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 B to 64 KB. The default value is 1 B.
    * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The total amount of the data transmitted to a container may exceed `batch-size` if the data is transmitted as a single message. Otherwise, the amount of data does not exceed `batch-size`.
    * `--stream-service-account-id`: ID of the service account with permissions to read from the stream and write to it.
    
    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T14:07:04.693126923Z"
    name: data-streams-trigger
    rule:
      data_stream:
        database: /{{ region-id }}/b1gia87mbah2********/etn7hehh2********
        stream: streams-name
        service_account_id: ajep8qm0kh2********
        batch_settings:
          size: "1"
          cutoff: 1s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje03adgd2h2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:dlq
            service-account-id: aje3lebfemh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a trigger for {{ yds-name }}:

  1. In the configuration file, describe the trigger parameters:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name = "<trigger_name>"
       container {
         id                 = "<container_ID>"
         service_account_id = "<service_account_ID>"
         retry_attempts     = "<number_of_retries>"
         retry_interval     = "<interval_between_retries>"
       }
       data_streams {
         stream_name        = "<stream_name>"
         database           = "<database_location>"
         service_account_id = "<service_account_ID>"
         batch_cutoff       = "<maximum_timeout>"
         batch_size         = "<message_group_size>"
       }
       dlq {
         queue_id           = "<dead-letter_queue_ID>"
         service_account_id = "<service_account_ID>"
       }
     }
     ```

     Where:

     * `name`: Trigger name. The name format is as follows:

          {% include [name-format](../../_includes/name-format.md) %}

     * `container`: Container parameters:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

         {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}
     
     * `data_streams`: Trigger parameters:

         * `stream_name`: Stream name.
         * `database`: Location of the {{ ydb-short-name }} DB the {{ yds-name }} stream is linked to.

             To find out where the DB is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, in the `database` parameter, e.g., `/ru-central1/b1gia87mba**********/etn7hehf6g*******`.

         * `service_account_id`: ID of the service account with permissions to read from the stream and write to it.

         * `batch_cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch_cutoff` and sends them to a container. The number of messages cannot exceed `batch_size`.
         * `batch_size`: Message batch size. This is an optional parameter. The values may range from 1 B to 64 KB. The default value is 1 B.

     {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

     For more information about the `yandex_function_trigger` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  To create a trigger for {{ yds-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [{#T}](../../functions/operations/trigger/data-streams-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/data-streams-trigger-create.md)
