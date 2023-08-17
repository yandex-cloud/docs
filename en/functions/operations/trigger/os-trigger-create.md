# Creating a trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function

Create a [{{ objstorage-name }} trigger](../../concepts/trigger/os-trigger.md) that calls a [{{ sf-name }} function](../../concepts/function.md) when you create, move, or delete an [object](../../../storage/concepts/object.md) in a bucket.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* [Bucket](../../../storage/concepts/bucket.md) whose object events will fire the trigger. If you do not have a bucket, [create one](../../../storage/operations/buckets/create.md) with restricted access.

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ objstorage-name }}**.
      * In the **Launched resource** field, select **Function**.

   1. Under **{{ objstorage-name }} settings**:

      * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
      * In the **Event types** field, select the [events](../../concepts/trigger/os-trigger.md#event) that will fire the trigger.
      * (optional) In the **Object key prefix** field, enter a [prefix](../../concepts/trigger/os-trigger.md#filter) for filtering.
      * (optional) In the **Object key suffix** field, enter a [suffix](../../concepts/trigger/os-trigger.md#filter) for filtering.

   1. Under **Function settings**, select a function and specify:

      {% include [function-settings](../../../_includes/functions/function-settings.md) %}

   1. (Optional) Under **Repeat request settings**:

      {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

   1. (Optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a function, run this command:

   ```bash
   yc serverless trigger create object-storage \
     --name <trigger name> \
     --bucket-id <bucket ID> \
     --prefix '<object key prefix>' \
     --suffix '<object key suffix>' \
     --events 'create-object','delete-object','update-object' \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--bucket-id`: Bucket ID.
   * `--prefix`: Bucket object key [prefix](../../concepts/trigger/os-trigger.md#filter). This is an optional parameter that is used for filtering.
   * `--suffix`: Bucket object key [suffix](../../concepts/trigger/os-trigger.md#filter). This is an optional parameter that is used for filtering.
   * `--events`: [Events](../../concepts/trigger/os-trigger.md#event) after which the trigger activates.

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

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger for {{ objstorage-name }}:

   1. In the configuration file, describe the trigger parameters.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<trigger name>"
        description = "<trigger description>"
        object_storage {
           bucket_id = "<bucket ID>"
           create    = true
           update    = true
        }
        function {
          id                 = "<function ID>"
          service_account_id = "<service account ID>"
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
            * `create`: The trigger will invoke the function when a new object is created in the storage. The value can be `true` or `false`.
            * `update`: The trigger will invoke the function when a new object is updated in the storage. The value can be `true` or `false`.
            * `delete`: The trigger will invoke the function when a new object is deleted from the storage. The value can be `true` or `false`.
         * `prefix`: [Prefix](../../concepts/trigger/os-trigger.md#filter) for filtering.
         * `suffix`: [Suffix](../../concepts/trigger/os-trigger.md#filter) for filtering.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.
         * `service_account_id`: ID of the service account with rights to invoke a function.

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

- API

   To create a trigger for {{ objstorage-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/os-trigger-create.md).
