# Creating a trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function

Create a [trigger for {{ objstorage-name }}](../../concepts/trigger/os-trigger.md) that calls a [{{ sf-name }} function](../../concepts/function.md) when you create, move, or delete an [object](../../../storage/concepts/object.md) in a bucket.

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* [Bucket](../../../storage/concepts/bucket.md) whose object events will fire the trigger. If you don't have a bucket, [create one](../../../storage/operations/buckets/create.md).

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
      * In the **Type** field, select **{{ objstorage-name }}**.
      * In the **Launched resource** field, select **Function**.

   1. Under **{{ objstorage-name }} settings**:

      * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
      * In the **Event types** field, select the [events](../../concepts/trigger/os-trigger.md#event) that will fire the trigger.
      * (optional) In the **Object key prefix** field, enter a [prefix](../../concepts/trigger/os-trigger.md#filter) for filtering.
      * (optional) In the **Object key suffix** field, enter a [suffix](../../concepts/trigger/os-trigger.md#filter) for filtering.

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
   * `--prefix`: Bucket object key [prefix](../../concepts/trigger/os-trigger.md#filter). Optional. Used for filtering.
   * `--suffix`: Bucket object key [suffix](../../concepts/trigger/os-trigger.md#filter). Optional. Used for filtering.
   * `--events`: [Events](../../concepts/trigger/os-trigger.md#event) after which the trigger activates.

   {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s92agr8mpgeo3kjt48
   folder_id: b1g88tflru0ek1omtsu0
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
         function_id: d4eofc7n0m03lmudsk7y
         function_tag: $latest
         service_account_id: aje3932acd0c5ur7drte
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknnpj1ll45e:dlq
           service-account-id: aje3932acd0c5ur7dagp
   status: ACTIVE
   ```

- API

   You can create a trigger for {{ objstorage-name }} using the [create](../../triggers/api-ref/Trigger/create.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger for {{ objstorage-name }}:

   1. In the configuration file, describe the trigger parameters.

      Example configuration file structure:

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

      * `name`: Trigger name. Name format:

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

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/os-trigger-create.md).
