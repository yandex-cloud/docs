# Creating a trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function

Create a [{{ objstorage-name }} trigger](../../concepts/trigger/os-trigger.md) that calls a [{{ sf-name }} function](../../concepts/function.md) when you create, move, or delete an [object](../../../storage/concepts/object.md) in a bucket.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* [Bucket](../../../storage/concepts/bucket.md) whose object events will fire the trigger. If you do not have a bucket, [create one](../../../storage/operations/buckets/create.md) with restricted access.

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
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}**.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** field, select the bucket whose object events you want to create a trigger for.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the [events](../../concepts/trigger/os-trigger.md#event) that will fire the trigger.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_prefix }}** field, enter a [prefix](../../concepts/trigger/os-trigger.md#filter) for filtering.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_suffix }}** field, enter a [suffix](../../concepts/trigger/os-trigger.md#filter) for filtering.

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
   yc serverless trigger create object-storage \
     --name <trigger_name> \
     --bucket-id <bucket_ID> \
     --prefix '<object_key_prefix>' \
     --suffix '<object_key_suffix>' \
     --events 'create-object','delete-object','update-object' \
     --batch-size <batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --invoke-function-id <function_ID> \
     --invoke-function-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```


   Where:

   * `--name`: Trigger name.
   * `--bucket-id`: Bucket ID.
   * `--prefix`: Bucket object key [prefix](../../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
   * `--suffix`: Bucket object key [suffix](../../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
   * `--events`: [Events](../../concepts/trigger/os-trigger.md#event) activating the trigger.

   {% include [batch-settings-events](../../../_includes/functions/batch-settings-events.md) %}

   {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s92agr8mpg********
   folder_id: b1g88tflru0e********
   created_at: "2019-12-18T09:47:50.079103Z"
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
       invoke_function:
         function_id: d4eofc7n0m03********
         function_tag: $latest
         service_account_id: aje3932acd0c********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknn********:dlq
           service-account-id: aje3932acd0c********
   status: ACTIVE
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To create a trigger for {{ objstorage-name }}:

   1. In the configuration file, describe the trigger parameters.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<trigger_name>"
        description = "<trigger_description>"
        object_storage {
           bucket_id = "<bucket_ID>"
           create    = true
           update    = true
        }
        function {
          id                 = "<function_ID>"
          service_account_id = "<service_account_ID>"
        }
      }
      ```

      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `object_storage`: Storage parameters:
         * `bucket_id`: Bucket ID.
         * Select one or more [event](../../concepts/trigger/os-trigger.md#event) types to be handled by the trigger:
            * `create`: The trigger will invoke the function when a new object is created in the storage. It may take either the `true` or `false` value.
            * `update`: The trigger will invoke the function when a new object is updated in the storage. It may take either the `true` or `false` value.
            * `delete`: The trigger will invoke the function when a new object is deleted from the storage. It may take either the `true` or `false` value.
         * `prefix`: [Prefix](../../concepts/trigger/os-trigger.md#filter) for filtering.
         * `suffix`: [Suffix](../../concepts/trigger/os-trigger.md#filter) for filtering.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.
         * `service_account_id`: ID of the service account with rights to invoke a function.

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger_ID>
         ```

- API {#api}

   To create a trigger for {{ objstorage-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/os-trigger-create.md).
