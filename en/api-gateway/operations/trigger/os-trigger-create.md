# Creating a trigger for {{ objstorage-name }} that sends messages to WebSocket connections

Create a [trigger for {{ objstorage-name }}](../../concepts/trigger/os-trigger.md) to send messages to [WebSocket connections](../../concepts/extensions/websocket.md) when you create, move, or delete an [object](../../../storage/concepts/object.md) in a bucket.

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* [Bucket](../../../storage/concepts/bucket.md) whose object events will fire the trigger. If you do not have a bucket, [create one](../../../storage/operations/buckets/create.md) with restricted access.

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** field, select the bucket whose object events you want to create a trigger for.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the events that will fire the trigger.
        * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_prefix }}** field, enter a prefix for filtering.
        * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_suffix }}** field, enter a suffix for filtering.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        * Batch size. The values may range from 1 to 1,000. The default value is 1.
        * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

       The trigger groups events for a period not exceeding the specified wait time and sends them to WebSocket connections. The number of events cannot exceed the specified batch size.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger that sends messages to WebSocket connections, run this command:
    
  ```bash
    yc serverless trigger create object-storage \
      --name <trigger_name> \
      --bucket-id <bucket_ID> \
      --prefix '<object_key_prefix>' \
      --suffix '<object_key_suffix>' \
      --events 'create-object','delete-object','update-object' \
      --batch-size <group_size> \
      --batch-cutoff <maximum_timeout> \
      --gateway-id <API_gateway_ID> \
      --gateway-websocket-broadcast-path <path> \
      --gateway-websocket-broadcast-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--bucket-id`: Bucket ID.
    * `--prefix`: Bucket object key [prefix](../../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
    * `--suffix`: Bucket object key [suffix](../../concepts/trigger/os-trigger.md#filter). This is an optional parameter. It is used for filtering.
    * `--events`: [Events](../../concepts/trigger/os-trigger.md#event) activating the trigger.

    {% include [batch-settings-events](../../../_includes/api-gateway/batch-settings-events.md) %}

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2023-08-24T15:19:15.353909857Z"
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
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  To create a trigger for {{ objstorage-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ objstorage-name }} that invokes a {{ sf-name }} function](../../../functions/operations/trigger/os-trigger-create.md)
* [Trigger for {{ objstorage-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/os-trigger-create.md)
