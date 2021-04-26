Create a [trigger for {{ objstorage-name }}](../../functions/concepts/trigger/os-trigger.md) that will run your function when you create, move, or delete an [object](../../storage/concepts/object.md) in the bucket.

To create a trigger, you need:

1. [Functions](../../functions/concepts/function.md) that the trigger will call. If you don't have a function:
    * [Create a function](../../functions/operations/function/function-create.md).
    * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).
1. [A bucket](../../storage/concepts/bucket.md) whose object events will fire the trigger. If you don't have a bucket, [create one](../../storage/operations/buckets/create.md).
1. (optional) The [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that the function couldn't process are moved. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).
1. Service account with rights to invoke the function and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a trigger.
    1. Open **{{ sf-name }}**.
    1. Go to the **Triggers** tab.
    1. Click **Create trigger**.
    1. Under **Basic parameters**:
        * Enter a name and description for the trigger.
        * In the **Type** field, select **Object Storage**.
    1. Under **Object Storage settings**:
        * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
        * In the **Event types** field, select the [events](../../functions/concepts/trigger/os-trigger.md#event) that will trigger the trigger.
        * (optional) In the **Object key prefix** field, enter a [prefix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
        * (optional) In the **Object key suffix** field, enter a [suffix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
    1. Under **Function settings**:
        * Select the function for the trigger to invoke.
        * Specify the [function version tag](../../functions/concepts/function.md#tag).
        * Specify the service account to be used to invoke the function.
    1. (optional) Under **Repeat request settings**:
        * In the **Interval** field, specify the time after which the function will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
        * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.
    1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and service account with rights to write messages to it.
    1. Click **Create trigger**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To create a trigger, run the command:

    ```
    yc serverless trigger create object-storage \
        --name <trigger name> \
        --bucket-id <bucket name> \
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

    where:
    * `--name`: Timer name.
    * `--bucket-id`: Bucket ID.
    * `--prefix`: [Prefix](../../functions/concepts/trigger/os-trigger.md#filter) of the bucket object key. Optional parameter. Used for filtering.
    * `--suffix`: [Suffix](../../functions/concepts/trigger/os-trigger.md#filter) of the bucket object key. Optional parameter. Used for filtering.
    * `--events`: [Events](../../functions/concepts/trigger/os-trigger.md#event) that will trigger the trigger.
    * `--invoke-function-id`: Function ID.
    * `--invoke-function-service-account-id`: Service account with rights to call the function.
    * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional parameter. Values can be from 10 to 60 seconds. The default is 10 seconds.
    * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter. Values can be from 1 to 5. The default is 1.
    * `--dlq-queue-id`: ID of the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter.
    * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter.

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
            queue-id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:dlq
            service-account-id: aje3932acd0c5ur7dagp
    status: ACTIVE
    ```

- API

    You can create a trigger for {{ objstorage-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md) API method.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

