---
title: How to send events to a {{ er-full-name }} bus using a connector
description: Follow this guide to send events to an {{ er-name }} bus using a connector.
---

# Sending events to a bus using a connector

## Timer {#timer}

To [send](../../../concepts/eventrouter/sending-events.md) events to a [bus](../../../concepts/eventrouter/bus.md) using a connector with a [Timer](../../../concepts/eventrouter/connector.md#timer) source, specify in the connector settings the data to send to the bus when the timer triggers.

## Connector for the {{ er-name }} API {#er-api}

{% note info %}

You can send events to a bus using a connector for the {{ er-name }} API only if there is at least one [rule](../../../concepts/eventrouter/rule.md) attached to that bus.

{% endnote %}

To send events to a bus using a [connector](../../../concepts/eventrouter/connector.md#from-api) with an {{ er-name }} API source:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI command](../../../../cli/cli-ref/serverless/cli-ref/eventrouter/send-event.md) to send events to a bus using a connector for the {{ er-name }} API:

      ```bash
      yc serverless eventrouter send-event --help
      ```
  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Send an event to a bus using the connector you selected:

      ```bash
      yc serverless eventrouter send-event \
        --name <connector_name> \
        --event '<event>' \
        --file <file_path>
      ```

      Where:
      * `--name`: Name of the connector you are using to send the event to the bus.
      
          Instead of name, you can provide the connector's ID in the `--id` parameter.
      * `--event`: Event in [JSON](https://en.wikipedia.org/wiki/JSON) format, e.g., `{"name": "value"}`.

      * `--file`: Path to the file containing the event or batch of events in JSON format.

          You can use the `--file` parameter to send to the bus either one event or several events at the same time by specifying them in the command as a JSON array, e.g., `[{"name1": "value1"},{"name2": "value2"}]`.

      The `--event` and `--file` parameters are mutually exclusive: you can use only one of them.

- API {#api}

  Use the [EventService/Send](../../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) gRPC API call to send an event to a bus using a connector for the {{ er-name }} API:

  1. If you do not have the gRPCurl utility installed, [install](https://github.com/fullstorydev/grpcurl) it.
  1. {% include [cli-install](../../../../_includes/cli-install.md) %}
  1. Get an [IAM token](../../../../iam/concepts/authorization/iam-token.md) used for [authentication](../../../api-ref/eventrouter/authentication.md) in the API.

      ```bash
      IAM_TOKEN=$(yc iam create-token)
      ```

      The command will save the IAM token to the `IAM_TOKEN` variable.
  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Create a file with the request body, e.g., `body.json`:

      ```json
      {
        "connector_id": "<connector_ID>",
        "message": <event_or_array_of_events>
      }
      ```

      Where:
      * `connector_id`: ID of the connector you are using to send the event to the bus.
      * `message`: Event in [JSON](https://en.wikipedia.org/wiki/JSON) format, e.g., `"{\"name\": \"value\"}"`.

          You can send to the bus either one event or several or several events at the same time by specifying them in the `message` field as a JSON array, e.g., `["{\"name1\": \"value1\"}","{\"name2\": \"value2\"}"]`.
  1. Run a gRPC call by specifying the path to the `body.json` file you created earlier:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ < body.json \
        events.eventrouter.serverless.yandexcloud.net:443 yandex.cloud.serverless.eventrouter.v1.EventService/Send
      ```

{% endlist %}

## Connector for {{ yds-full-name }} {#yds}

Events get to the bus from a [data stream](../../../../data-streams/concepts/glossary.md#stream-concepts) through a connector with a [{{ yds-full-name }}](../../../../data-streams/index.yaml) source. 

## Connector for {{ message-queue-full-name }} {#ymq}

Events get to the bus from a [message queue](../../../../message-queue/concepts/queue.md) through a connector with a [{{ message-queue-full-name }}](../../../../message-queue/index.yaml) source. 