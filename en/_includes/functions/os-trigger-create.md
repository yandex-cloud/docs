Create a {{ objstorage-name }} [trigger](../../functions/concepts/trigger/os-trigger.md)that invokes a {{ sf-name }} [function](../../functions/concepts/function.md) or {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) when you create, move, or delete an [object](../../storage/concepts/object.md) in a bucket.

To create a trigger, you need:

* A function or a container the trigger will launch.

   * If you don't have a function:

      * [Create a function](../../functions/operations/function/function-create.md).
      * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

   * If you don't have a container:

      * [Create a container](../../serverless-containers/operations/create.md).
      * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* [Bucket](../../storage/concepts/bucket.md) whose object events will fire the trigger. If you don't have a bucket, [create one](../../storage/operations/buckets/create.md).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function or a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service account](../../iam/concepts/users/service-accounts.md) with rights to invoke a function or a container and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Object Storage**.
      * Choose what the trigger will launch — a function or a container.

   1. Under **Object Storage settings**:

      * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
      * In the **Event types** field, select the [events](../../functions/concepts/trigger/os-trigger.md#event) that will fire the trigger.
      * (optional) In the **Object key prefix** field, enter a [prefix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
      * (optional) In the **Object key suffix** field, enter a [suffix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.

   1. If the trigger launches:

      * A function, select one under **Function settings** and specify:

         * [Tag of the function version](../../functions/concepts/function.md#tag);
         * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

      * A container, select one under **Container settings** and specify:

         * A [container revision](../../serverless-containers/concepts/container.md#revision);
         * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function or the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that launches a function, run the command:

   ```
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

   * `--name`: Timer name.
   * `--bucket-id`: Bucket ID.
   * `--prefix`: Bucket object key [prefix](../../functions/concepts/trigger/os-trigger.md#filter). Optional. Used for filtering.
   * `--suffix`: Bucket object key [suffix](../../functions/concepts/trigger/os-trigger.md#filter). Optional. Used for filtering.
   * `--events`: [Events](../../functions/concepts/trigger/os-trigger.md#event) after which the trigger activates.
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
   * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional. Values can be from 1 to 5. The default is 1.
   * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. Optional.
   * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional.

   Result:

   ```
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

   You can create a trigger for {{ objstorage-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `object_storage`: Storage parameters:
         * `bucket_id`: Bucket ID.
         * Select one or more [event](../../functions/concepts/trigger/os-trigger.md#event) types to be handled by the trigger:
            * `create`: The trigger will invoke the function when a new object is created in the storage. The value can be `true` or `false`.
            * `update`: The trigger will invoke the function when a new object is updated in the storage. The value can be `true` or `false`.
            * `delete`: The trigger will invoke the function when a new object is deleted from the storage. The value can be `true` or `false`.
         * `prefix`: [Prefix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
         * `suffix`: [Suffix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
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

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
