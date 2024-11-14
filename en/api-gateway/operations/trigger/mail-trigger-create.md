# Creating an email trigger that sends messages to WebSocket connections

Create an [email trigger](../../concepts/trigger/mail-trigger.md) to send messages to {{ api-gw-full-name }} [WebSocket connections](../../concepts/extensions/websocket.md) when an email arrives. The service automatically generates an email address when creating the trigger.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* Optionally, a [bucket](../../../storage/concepts/bucket.md) to save email attachments to. If you do not have a bucket, [create one](../../../storage/operations/buckets/create.md) with restricted access.

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Optionally, enter a trigger name and description.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_mail }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.
    
    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_mail-attachments }}**:
      
        {% include [mail-trigger-attachements](../../../_includes/functions/mail-trigger-attachements.md) %}

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        * Batch size. The values may range from 1 to 1,000. The default value is 1.
        * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

       The trigger groups messages for a period not exceeding the specified wait time and sends them to WebSocket connections. The number of messages cannot exceed the specified batch size.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger that sends messages to WebSocket connections, run this command:
    ```bash
    yc serverless trigger create mail \
      --name <trigger_name> \
      --batch-size <batch_size> \
      --batch-cutoff <maximum_timeout> \
      --attachements-bucket <bucket_name> \
      --attachements-service-account-id <service_account_ID> \
      --gateway-id <API_gateway_ID> \
      --gateway-websocket-broadcast-path <path> \
      --gateway-websocket-broadcast-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.

    {% include [batch-settings-messages](../../../_includes/api-gateway/batch-settings-messages.md) %}

    * `--attachements-bucket`: Name of the bucket to save email attachments to. This is an optional parameter.
    
    * `--attachements-service-account-id`: ID of the service account authorized to upload objects to the Object Storage bucket. This is an optional parameter.

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflruh2********
    created_at: "2023-08-04T08:45:31.131391Z"
    name: mail-trigger
    rule:
      mail:
        email: a1s8h8avglh2********-cho1****@serverless.yandexcloud.net
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

  To create an email trigger, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

{{ api-gw-full-name }} will automatically generate an email address that will cause the trigger to fire when messages are sent to it. To see it, [retrieve detailed trigger information](trigger-list.md#trigger-get).

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Email trigger that invokes a {{ sf-name }} function](../../../functions/operations/trigger/mail-trigger-create.md)
* [Email trigger that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/mail-trigger-create.md)
