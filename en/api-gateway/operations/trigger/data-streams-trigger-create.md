---
title: Creating a trigger for {{ yds-full-name }} that sends messages to WebSocket connections
description: Follow this guide to create a trigger for {{ yds-name }} that sends messages to WebSocket connections and test the result of its operation.
---

# Creating a trigger for {{ yds-name }} that sends messages to WebSocket connections

Create a [trigger for {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md) to send messages to [WebSocket connections](../../concepts/extensions/websocket.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts).

{% note info %}

{% include [trigger-message-format-note](../../../_includes/functions/trigger-message-format-note.md) %}

{% endnote %}

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* A stream that will activate the trigger as soon as it receives data. If you do not have a stream, [create one](../../../data-streams/quickstart/create-stream.md).

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
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}**, select a data stream and a service account with permissions to read data from the stream and write data to it.

    1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        * Message batch size in bytes. The values may range from 1 B to 64 KB. The default value is 1 B.
        * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

        The trigger groups messages for a period not exceeding the specified wait time and sends them to WebSocket connections. The total amount of data transmitted to connections may exceed the specified batch size if the data is transmitted as a single message. In all other cases, the amount of data does not exceed the batch size.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger that sends messages to WebSocket connections, run this command:

    ```bash
    yc serverless trigger create yds \
      --name <trigger_name> \
      --database <database_location> \
      --stream <data_stream_name> \
      --batch-size 1b \
      --batch-cutoff 1s \
      --stream-service-account-id <service_account_ID> \
      --gateway-id <API_gateway_ID> \
      --gateway-websocket-broadcast-path <path> \
      --gateway-websocket-broadcast-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--database`: Location of the {{ ydb-short-name }} DB the {{ yds-name }} stream is linked to.

      To find out where the DB is located, run the `yc ydb database list` command. The DB location is specified in the `ENDPOINT` column, in the `database` parameter, e.g., `/{{ region-id }}/b1gia87mbah2********/etn7hehf6gh3********`.

    * `--stream`: Stream name.

    * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 B to 64 KB. The default value is 1 B.

    * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to WebSocket connections. The total amount of data transmitted to connections may exceed `batch-size` if the data is transmitted as a single message. In all other cases, the amount of data does not exceed `batch-size`.

    * `--stream-service-account-id`: ID of the service account with permissions to read from the stream and write to it.

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T14:07:04.693126923Z"
    name: data-streams-trigger
    rule:
      data_stream:
        database: /{{ region-id }}/b1gia87mbah2********/etn7hehh2********
        stream: streams-name
        service_account_id: ajep8qm0kh2********
        batch_settings:
          size: "1"
          cutoff: 1s
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  To create a trigger for {{ yds-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ yds-name }} that invokes a {{ sf-name }} function](../../../functions/operations/trigger/data-streams-trigger-create.md)
* [Trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/data-streams-trigger-create.md)
