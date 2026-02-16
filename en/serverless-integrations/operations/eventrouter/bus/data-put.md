---
title: How to send events directly to an {{ er-name }} bus
description: Follow this guide to send events directly to an {{ er-full-name }} bus using the put method.
---

# Sending events directly to a bus

{% note info %}

You can send events to a bus directly only if there is at least one [rule](../../../concepts/eventrouter/rule.md) attached to it.

{% endnote %}

To [send](../../../concepts/eventrouter/sending-events.md) events directly to a [bus](../../../concepts/eventrouter/bus.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) with the bus you need.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![object-align-center-vertical](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. In the top panel, click ![comment-plus](../../../../_assets/console-icons/comment-plus.svg) **{{ ui-key.yacloud.serverless-event-router.button_send-event }}**.
  1. In the window that opens, enter the event you need to send to the bus in [JSON](https://en.wikipedia.org/wiki/JSON) format, e.g., `{"name": "value"}`.
  1. Click **{{ ui-key.yacloud.serverless-event-router.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI command](../../../../cli/cli-ref/serverless/cli-ref/eventrouter/put-event.md) to send events directly to a bus:

      ```bash
      yc serverless eventrouter put-event --help
      ```
  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}
  1. Send the event to the bus you selected:

      ```bash
      yc serverless eventrouter put-event \
        --name <bus_name> \
        --event '<event>' \
        --file <file_path>
      ```

      Where:
      * `--name`: Name of the bus you are sending the event to.
      
          Instead of the bus name, you can provide its ID in the `--id` parameter.
      * `--event`: Event in [JSON](https://en.wikipedia.org/wiki/JSON) format, e.g., `{"name": "value"}`.

      * `--file`: Path to the file containing the event you are sending to the bus in JSON format.

      The `--event` and `--file` parameters are mutually exclusive: you can use only one of them.

- API {#api}

  Use the [EventService/Put](../../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) gRPC API call to send the event directly to a bus:

  1. If you do not have the gRPCurl utility installed, [install](https://github.com/fullstorydev/grpcurl) it.
  1. {% include [cli-install](../../../../_includes/cli-install.md) %}
  1. Get an [IAM token](../../../../iam/concepts/authorization/iam-token.md) used for [authentication](../../../api-ref/eventrouter/authentication.md) in the API.

      ```bash
      IAM_TOKEN=$(yc iam create-token)
      ```

      The command will save the IAM token to the `IAM_TOKEN` variable.
  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}
  1. Create a file with the request body, e.g., `body.json`:

      ```json
      {
        "bus_id": "<bus_ID>",
        "body": "<event>"
      }
      ```

      Where:
      * `bus_id`: ID of the bus you are sending the event to.
      * `body`: Event in [JSON](https://en.wikipedia.org/wiki/JSON) format, e.g., `{'name': 'value'}`.
  1. Run a gRPC call by specifying the path to the `body.json` file you created earlier:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ < body.json \
        events.eventrouter.serverless.yandexcloud.net:443 yandex.cloud.serverless.eventrouter.v1.EventService/Put
      ```

{% endlist %}