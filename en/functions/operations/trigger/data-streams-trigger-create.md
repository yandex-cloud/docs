---
title: Creating a trigger for {{ yds-full-name }} that invokes a {{ sf-full-name }} function
description: Follow this guide to create a trigger for {{ yds-name }} that invokes a function in {{ sf-name }}.
---

# Creating a trigger for {{ yds-name }} that invokes a {{ sf-name }} function

Create a [trigger for {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md) to invoke a {{ sf-name }} [function](../../concepts/function.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts).

## Getting started {#before-you-begin}

To create a trigger, you will need:

* A function to be invoked by the trigger. If you do not have a function:

    * [Create a function](../function/function-create.md).
    * [Create a function version](../function/version-manage.md).

* (Optional) A [dead-letter queue](../../concepts/dlq.md) where messages that could not be processed by a function will be redirected. If you do not have a queue, [create one](../../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../../iam/concepts/users/service-accounts.md) with the following permissions:

    * To invoke a function.
    * To read from the stream that activates the trigger when data is sent there.
    * Optionally, to write to a dead-letter queue.

    You can use the same service account or different ones. If you do not have a service account, [create one](../../../iam/operations/sa/create.md).

* A stream that will activate the trigger as soon as it receives data.  If you do not have a stream, [create one](../../../data-streams/quickstart/create-stream.md). 

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}**.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}**, select a data stream and a service account with permissions to read data from the stream and write data to it.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. The values may range from 1 to 60 seconds. The default value is 1 second.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_stream-size }}**. The values may range from 1 B to 64 KB. The default value is 1 B.

        The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. The total amount of data transmitted to a function may exceed the specified batch size if the data is transmitted as a single message. In all other cases, the amount of data does not exceed the batch size.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger that invokes a function, run this command:

    ```bash
    yc serverless trigger create yds \
      --name <trigger_name> \
      --database <database_location> \
      --stream <stream_name> \
      --batch-size <message_batch_size> \
      --batch-cutoff <maximum_timeout> \
      --stream-service-account-id <service_account_ID> \
      --invoke-function-id <function_ID> \
      --invoke-function-service-account-id <service_account_ID> \
      --retry-attempts <number_of_retry_attempts> \
      --retry-interval <interval_between_retry_attempts> \
      --dlq-queue-id <dead-letter_queue_ID> \
      --dlq-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--database`: Location of the {{ ydb-short-name }} DB the {{ yds-name }} stream is linked to.

      To find out where the DB is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, in the `database` parameter, e.g., `/{{ region-id }}/b1gia87mba**********/etn7hehf6g*******`.

    * `--stream`: Name of the {{ yds-name }} stream.
    * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 B to 64 KB. The default value is 1 B.
    * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The total amount of data transmitted to a function may exceed `batch-size` if the data is transmitted as a single message. In all other cases, the amount of data does not exceed `batch-size`.
    * `--stream-service-account-id`: ID of the service account with permissions to read from the stream and write to it.
    
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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a trigger for {{ yds-name }}:

  1. In the configuration file, describe the trigger parameters:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name = "<trigger_name>"
       function {
         id                 = "<function_ID>"
         service_account_id = "<service_account_ID>"
         retry_attempts     = "<number_of_retry_attempts>"
         retry_interval     = "<time_between_retry_attempts>"
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

     {% include [tf-function-params](../../../_includes/functions/tf-function-params.md) %}
     
     * `data_streams`: Trigger parameters:

         * `stream_name`: Name of the {{ yds-name }} stream.
         * `database`: Location of the {{ ydb-short-name }} DB the {{ yds-name }} stream is linked to.

             To find out where the DB is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, in the `database` parameter, e.g., `/ru-central1/b1gia87mba**********/etn7hehf6g*******`.

         * `service_account_id`: Service account with permissions to read from and write to the {{ yds-name }} stream.

         * `batch_cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The total amount of data transmitted to a function may exceed `batch-size` if the data is transmitted as a single message. In all other cases, the amount of data does not exceed `batch-size`.
         * `batch_size`: Message batch size. This is an optional parameter. The values may range from 1 B to 64 KB. The default value is 1 B.

     {% include [tf-dlq-params](../../../_includes/serverless-containers/tf-dlq-params.md) %}

     For more information about the `yandex_function_trigger` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  To create a trigger for {{ yds-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [{#T}](../../../serverless-containers/operations/data-streams-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/data-streams-trigger-create.md)
