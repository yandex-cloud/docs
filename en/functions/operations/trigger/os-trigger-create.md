# Creating a trigger for {{ objstorage-name }}

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Create a [trigger for {{ objstorage-name }}](../../concepts/trigger/os-trigger.md) to call your function when a certain event occurs with an object in a bucket.

{% include [before-begin](../../../_includes/functions/os-timer-before-begin.md) %}

## Create a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

    {% include [os-create-ui](../../../_includes/functions/os-create-ui.md) %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger for {{ objstorage-name }}, run the command:

    ```
    $ yc serverless trigger create object-storage \
        --name s3-trigger \
        --bucket-id s3-for-trigger \
        --prefix 'dev' \
        --suffix '12.jpg' \
        --events 'create-object','delete-object','update-object' \
        --invoke-function-id d4eofc7n0m03lmudsk7y \
        --invoke-function-service-account-id aje3932acd0c5ur7drte
    id: a1s92agr8mpgeo3kjt48
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-12-18T09:47:50.079103Z"
    name: s3-trigger
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
    ```

    Where:
    * `--name`: Timer name.
    * `--bucket-id`: Bucket name.
    * `--prefix`: Bucket object key [prefix](../trigger/os-trigger-create.md#filter). Used for filtering.
    * `--suffix`: Bucket object key [suffix](../trigger/os-trigger-create.md#filter). Used for filtering.
    * `--events`: Type of event after which the trigger activates.
    * `--invoke-function-id`: Function ID.
    * `--invoke-function-service-account-id`: Service account with rights to call the function.

{% endlist %}

