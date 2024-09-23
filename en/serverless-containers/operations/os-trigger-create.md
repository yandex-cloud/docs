# Creating a trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container

Create a [trigger for {{ objstorage-name }}](../concepts/trigger/os-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when you create, move, or delete an [object](../../storage/concepts/object.md) in a bucket.

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Bucket](../../storage/concepts/bucket.md) whose object events will fire the trigger. If you do not have a bucket, [create one](../../storage/operations/buckets/create.md) with restricted access.

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
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** field, select the bucket whose object events you want to create a trigger for.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the events that will fire the trigger.
        * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_prefix }}** field, enter a prefix for filtering.
        * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_suffix }}** field, enter a suffix for filtering.
    
    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        {% include [batch-settings](../../_includes/functions/batch-settings.md) %}

        {% include [batch-events](../../_includes/serverless-containers/batch-events.md) %}

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
    yc serverless trigger create object-storage \
      --name <trigger_name> \
      --bucket-id <bucket_ID> \
      --prefix '<object_key_prefix>' \
      --suffix '<object_key_suffix>' \
      --events 'create-object','delete-object','update-object' \
      --batch-size <event_group_size> \
      --batch-cutoff <maximum_timeout> \
      --invoke-container-id <container_ID> \
      --invoke-container-service-account-id <service_account_ID> \
      --retry-attempts <number_of_repeat_attempts> \
      --retry-interval <time_between_repeat_attempts> \
      --dlq-queue-id <dead_letter_queue_ID> \
      --dlq-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--bucket-id`: Bucket ID.
    * `--prefix`: Bucket object key [prefix](../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
    * `--suffix`: Bucket object key [suffix](../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
    * `--events`: [Events](../concepts/trigger/os-trigger.md#event) activating the trigger.

    {% include [batch-settings-events](../../_includes/serverless-containers/batch-settings-events.md) %}

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: os-trigger
    rule:
      object_storage:
        event_type:
        - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
        bucket_id: s3-for-trigger
        prefix: dev
        suffix: 12.jpg
        batch_settings:
          size: "3"
          cutoff: 20s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje3932acdh2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmkh2********:dlq
            service-account-id: aje3932acdh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a trigger for {{ objstorage-name }}:

  1. In the configuration file, describe the trigger parameters:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name = "<trigger_name>"
       container {
         id                 = "<container_ID>"
         service_account_id = "<service_account_ID>"
         retry_attempts     = "<number_of_repeat_attempts>"
         retry_interval     = "<time_between_repeat_attempts>"
       }
       object_storage {
         bucket_id    = "<bucket_ID>"
         prefix       = "<object_key_prefix>"
         suffix       = "<object_key_suffix>"
         create       = true
         update       = true
         delete       = true
         batch_cutoff = "<maximum_timeout>"
         batch_size   = "<event_group_size>"
       }
       dlq {
         queue_id           = "<dead_letter_queue_ID>"
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

      * `object_storage`: Trigger parameters:

          * `bucket_id`: Bucket ID.
          * `prefix`: Bucket object key [prefix](../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
          * `suffix`: Bucket object key [suffix](../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
          * [Events](../concepts/trigger/os-trigger.md#event) activating the trigger:

              * `create`: Trigger will invoke the container if a new object is created in the storage. It can either be `true` or `false`.
              * `update`: Trigger will invoke the container if an object is updated in the storage. It can either be `true` or `false`.
              * `delete`: Trigger will invoke the container if an object is deleted from the storage. It can either be `true` or `false`.

          {% include [tf-batch-params-events.md](../../_includes/serverless-containers/tf-batch-params-events.md) %}

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

     For more information about the `yandex_function_trigger` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  To create a trigger for {{ objstorage-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [{#T}](../../functions/operations/trigger/os-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/os-trigger-create.md)
