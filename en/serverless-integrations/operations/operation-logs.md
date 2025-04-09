# Viewing operations with {{ si-name }} resources

All actions with {{ si-name }} resources are logged as a list of operations. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  You can get a list of operations for a specific resource. Follow the steps below to do this for an {{ er-name }} bus. The same steps apply to the service's other resources.

  1. In the [management console]({{ link-console-main }}), open the folder the bus resides in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select a bus.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected bus.

     You will see a list of operations with the bus.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ si-name }} resource, run this command:

  ```bash
  yc serverless <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Getting a list of operations for an {{ er-name }} bus:

  ```bash
  yc serverless eventrouter bus list-operations epdplu8jn7sr********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | f66oon77ahgu******** | 2025-02-24 20:48:53 | ajevfb0tjfts******** | 2025-02-24 20:48:53 | DONE   | Updating a bus |
  | f66a237f2f6v******** | 2025-02-24 20:48:30 | ajevfb0tjfts******** | 2025-02-24 20:48:30 | DONE   | Updating a bus |
  | f66cbrh8c1u4******** | 2025-02-20 12:22:56 | ajevfb0tjfts******** | 2025-02-20 12:22:57 | DONE   | Creating a bus  |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  By default, information about operations is output as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc serverless eventrouter bus list-operations <bus_name_or_ID> --format yaml
  ```

  Result:

  ```yaml
  - id: f66oon77ahgu********
    description: Updating a bus
    created_at: "2025-02-24T20:48:53.942469190Z"
    created_by: ajevfb0tjfts********
    modified_at: "2025-02-24T20:48:53.956957528Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.serverless.eventrouter.v1.UpdateBusMetadata
      bus_id: f662ctjn8vv4********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ...
  ```

- API {#api}

  Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, for an {{ er-name }} bus, use the [listOperations](../../serverless-integrations/eventrouter/api-ref/Bus/listOperations.md) REST API method for the [Bus](../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [BusService/ListOperations](../../serverless-integrations/eventrouter/api-ref/grpc/Bus/listOperations.md) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations).
1. Copy the operation ID.
1. Get detailed information about the operation:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc operation get <operation_ID>
      ```

      Result:

      ```text
      id: f66oon77ahgu********
      description: Updating a bus
      created_at: "2025-02-24T20:48:53.942Z"
      created_by: ajevfb0tjfts********
      modified_at: "2025-02-24T20:48:53.956Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.serverless.eventrouter.v1.UpdateBusMetadata
        bus_id: f662ctjn8vv4********
      response:
        '@type': type.googleapis.com/yandex.cloud.serverless.eventrouter.v1.Bus
        id: f662ctjn8vv4********
        folder_id: b1geoelk7fld********
        cloud_id: b1gia87mbaom********
        created_at: "2025-02-20T12:22:57.005054Z"
        name: test
        description: tesst
        status: ACTIVE
      ```

    - API {#api}

      To get detailed information about an operation, use the `get` REST API method for the `Operation` resource or the `OperationService/Get` gRPC API call.

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
