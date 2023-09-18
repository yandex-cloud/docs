# Creating a trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container

Create a [trigger for {{ objstorage-name }}](../concepts/trigger/os-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when you create, move, or delete an [object](../../storage/concepts/object.md) in a bucket.

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Bucket](../../storage/concepts/bucket.md) whose object events will fire the trigger. If you do not have a bucket, [create one](../../storage/operations/buckets/create.md) with restricted access.

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Open **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ objstorage-name }}**.
      * In the **Launched resource** field, select **Container**.

   1. Under **{{ objstorage-name }} settings**:

      * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
      * In the **Event types** field, select the events that will fire the trigger.
      * (Optional) In the **Object key prefix** field, enter a prefix for filtering.
      * (Optional) In the **Object key suffix** field, enter a suffix for filtering.

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (Optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

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
   * `--prefix`: Bucket object key [prefix](../concepts/trigger/os-trigger.md#filter). Optional parameter. Used for filtering.
   * `--suffix`: Bucket object key [suffix](../concepts/trigger/os-trigger.md#filter). Optional parameter. Used for filtering.
   * `--events`: [Events](../concepts/trigger/os-trigger.md#event) activating the trigger.

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
  

- API

   To create a trigger for {{ objstorage-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function](../../functions/operations/trigger/os-trigger-create.md).
