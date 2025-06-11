# Viewing operations with {{ vpc-name }} resources

All actions with {{ vpc-name }} resources are logged as a list of operations. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all the resources, select ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** in the left-hand panel. In the list that opens, you will also see operations with the resources that were deleted.

  You can get a list of operations for a specific resource. The steps below describe how you can do this for a cloud network. The same steps apply to other resources as well.

  1. In the [management console]({{ link-console-main }}), go to the folder where the cloud network is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Select the network you need.
  1. Go to the ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel.

     You will see a list of cloud network operations.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ vpc-name }} resource, run this command:

  ```bash
  yc vpc <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Get a list of operations for a cloud network:

  ```bash
  yc vpc network list-operations enpgl5o8te3k********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | enp75021agjg******** | 2024-02-01 10:16:51 | ajego134p5h1******** | 2024-02-01 10:16:53 | DONE   | Create network |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  By default, operation information is displayed as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` parameter:

  ```bash
  yc vpc network list-operations enpgl5o8te3k******** --format yaml
  ```

  Result:

  ```text
  - id: enp75021agjg********
    description: Create network
    created_at: "2024-02-01T10:16:51.955935138Z"
    created_by: ajego134p5h1********
    modified_at: "2024-02-01T10:16:53.389542083Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.vpc.v1.CreateNetworkMetadata
      network_id: enpgl5o8te3k********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  To get a list of operations, use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, to obtain a list of operations for a cloud network, use either the [listOperations](../api-ref/Network/listOperations.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/ListOperations](../api-ref/grpc/Network/listOperations.md) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

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
      id: enp75021agjg********
      description: Create network
      created_at: "2024-02-01T10:16:51.955Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T10:16:53.389Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.vpc.v1.CreateNetworkMetadata
        network_id: enpgl5o8te3k********
      response:
        '@type': type.googleapis.com/yandex.cloud.vpc.v1.Network
        id: enpgl5o8te3kke6q3psa
        folder_id: b1gmit33ngp3********
        created_at: "2024-02-01T10:16:51Z"
        name: test-network
        default_security_group_id: enp0catll8gm********
        ```

    - API {#api}

      Use the [get](../api-ref/Operation/get.md) REST API method for the [Operation](../api-ref/Operation/index.md) resource or the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call.

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
