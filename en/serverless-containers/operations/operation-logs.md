# Viewing operations with {{ serverless-containers-name }} resources

All actions with {{ serverless-containers-name }} resources are logged as a list of operations. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  You can get a list of operations for a specific resource. The steps below describe how you can do this for a container. The same steps apply to other resources as well.

  1. In the [management console]({{ link-console-main }}), open the folder with the container.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/boxes-3.svg) **{{ ui-key.yacloud.serverless-containers.label_containers }}**.
  1. Select the container you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected container.

      You will see the list of operations with the selected container.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of operations for the {{ serverless-containers-name }} resource, run this command:

  ```bash
  yc serverless <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Getting a list of operations for a container:

  ```bash
  yc serverless container list-operations epdplu8jn7sr********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION    |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  | bba1fu790ass******** | 2024-06-21 10:56:42 | aje9k8luj4qf******** | 2024-06-21 10:56:42 | DONE   | Update container |
  | bbaogemlt3jf******** | 2024-06-21 10:51:57 | aje9k8luj4qf******** | 2024-06-21 10:51:57 | DONE   | Create container |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  ```

  By default, operation information is displayed as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` parameter:

  ```bash
  yc serverless container list-operations <resource_name_or_ID> --format yaml
  ```

  Result:

  ```text
  - id: bba1fu790ass********
    description: Update container
    created_at: "2024-06-21T10:56:42.746Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-06-21T10:56:42.763Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.serverless.containers.v1.UpdateContainerMetadata
      container_id: bbaqss6v9qv9********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ...
  ```

- API {#api}

  Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, for a container, use either the [listOperations](../containers/api-ref/Container/listOperations.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/ListOperations](../containers/api-ref/grpc/Container/listOperations.md) gRPC API call.

{% endlist %}

## Getting operation details {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
1. Copy the operation ID.
1. Get operation details:

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
      id: bbaogemlt3jf********
      description: Create container
      created_at: "2024-06-21T10:51:57.338Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-06-21T10:51:57.881Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.serverless.containers.v1.CreateContainerMetadata
        container_id: bbaqss6v9qv9********
      response:
        '@type': type.googleapis.com/yandex.cloud.serverless.containers.v1.Container
        id: bbaqss6v9qv9********
        folder_id: b1g681qpemb4********
        created_at: "2024-06-21T10:51:57.350Z"
        name: simple-container
        url: https://bbaqss6v9qv9********.containers.yandexcloud.net/
        status: ACTIVE
      ```

   - API {#api}

      Use the [OperationService/Get](../containers/api-ref/grpc/Operation/get.md) gRPC API call.

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
