# Creating a trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container

Create a [trigger for {{ objstorage-name }}](../concepts/trigger/os-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when you create, move, or delete an [object](../../storage/concepts/object.md) in a bucket.

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Bucket](../../storage/concepts/bucket.md) whose object events will fire the trigger. If you do not have a bucket, [create one](../../storage/operations/buckets/create.md) with restricted access.

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** field, select the bucket whose object events you want to create a trigger for.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the events that will fire the trigger.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_prefix }}** field, enter a prefix for filtering.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_suffix }}** field, enter a suffix for filtering.

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead letter queue and the service account with write privileges for this queue.

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
     --batch-size <batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
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
   id: a1s5msktij**********
   folder_id: b1gmit33hg**********
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
         container_id: bba5jb38o8**********
         service_account_id: aje3932acd**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
           service-account-id: aje3932acd**********
   status: ACTIVE
   ```


- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a trigger for {{ objstorage-name }}:

   1. In the configuration file, describe the trigger parameters:

      
      ```
      resource "yandex_function_trigger" "my_trigger" {
        name = "<trigger_name>"
        container {
          id                 = "<container_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = "<number_of_retry_invocation_attempts>"
          retry_interval     = "<interval_between_retry_attempts>"
        }
        object_storage {
           bucket_id    = "<bucket_ID>"
           create       = true
           delete       = true
           batch_cutoff = "<timeout>"
           batch_size   = "<event_batch_size>"
        }
        dlq {
          queue_id           = "<DLQ_ID>"
          service_account_id = "<service_account_ID>"
        }
      }
      ```


      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `container`: Settings for the container that will be activated by the trigger:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

         {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      * `object_storage`: Trigger parameters:
         * `bucket_id`: Bucket ID.
         * Select one or more [event](../concepts/trigger/os-trigger.md#event) types to be handled by the trigger:
            * `create`: Trigger will invoke the container when a new object is created in the storage. It may take either the `true` or `false` value.
            * `update`: Trigger will invoke the container when a new object is updated in the storage. It may take either the `true` or `false` value.
            * `delete`: Trigger will invoke the container when a new object is deleted from the storage. It may take either the `true` or `false` value.

         {% include [tf-batch-params.md](../../_includes/serverless-containers/tf-batch-params.md) %}

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      For more information about the `yandex_function_trigger` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc serverless trigger list
      ```

- API {#api}

   To create a trigger for {{ objstorage-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function](../../functions/operations/trigger/os-trigger-create.md).
