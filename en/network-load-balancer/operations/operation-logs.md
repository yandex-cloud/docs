# Viewing {{ network-load-balancer-name }} resource operations

The system logs all actions with {{ network-load-balancer-name }} resources as a list of operations. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all the resources, select ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** in the left-hand panel. In the list that opens, you will also see operations with the resources that were deleted.

  You can get a list of operations for a specific resource. The steps below describe how you can do this for a network load balancer. The same steps apply to target groups as well.

  1. In the [management console]({{ link-console-main }}), open the folder with your network load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Select the network load balancer in question.
  1. Navigate to the ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel.

      You will see a list of operations with the selected network load balancer.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ network-load-balancer-name }} resource, run this command:

  ```bash
  yc load-balancer <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Get a list of operations for a network load balancer:

  ```bash
  yc load-balancer network-load-balancer list-operations enpaud0h342p********
  ```

  You can get the network load balancer ID with the [list of network load balancers in the folder](load-balancer-list.md#list).

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |        DESCRIPTION         |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
  | enp87akr8sdr******** | 2024-02-01 09:33:45 | ajego134p5h1******** | 2024-02-01 09:33:45 | DONE   | Create NetworkLoadBalancer |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
  ```

  By default, operation information is displayed as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` parameter:

  ```bash
  yc load-balancer network-load-balancer list-operations enp87akr8sdr******** --format yaml
  ```

  Result:

  ```text
  - id: enp87akr8sdr********
  description: Create NetworkLoadBalancer
  created_at: "2024-02-01T09:33:45.035Z"
  created_by: ajego134p5h1********
  modified_at: "2024-02-01T09:33:45.642754913Z"
  done: true
  metadata:
    '@type': type.googleapis.com/yandex.cloud.loadbalancer.v1.CreateNetworkLoadBalancerMetadata
    network_load_balancer_id: enpaud0h342p********
  response:
    '@type': type.googleapis.com/google.protobuf.Empty
    value: {}
  ```

- API {#api}

  To get a list of operations, use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, for a network load balancer, use the [listOperations](../api-ref/NetworkLoadBalancer/listOperations.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/ListOperations](../api-ref/grpc/NetworkLoadBalancer/listOperations.md) gRPC API call, providing the network load balancer ID in the `networkLoadBalancerId` parameter of your request.

  You can get the network load balancer ID with the [list of network load balancers in the folder](load-balancer-list.md#list).

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
      id: enp87akr8sdr********
      description: Create NetworkLoadBalancer
      created_at: "2024-02-01T09:33:45.035Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T09:33:45.642Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.loadbalancer.v1.CreateNetworkLoadBalancerMetadata
        network_load_balancer_id: enpaud0h342p********
      response:
        '@type': type.googleapis.com/yandex.cloud.loadbalancer.v1.NetworkLoadBalancer
        id: enpaud0h342p********
        folder_id: b1gmit33ngp3********
        created_at: "2024-02-01T09:33:45Z"
        name: nlb-e6f3e-083
        region_id: {{ region-id }}
        status: ACTIVE
        type: EXTERNAL
      ```

    - API {#api}

      Use the [get](../api-ref/Operation/get.md) REST API method for the [Operation](../api-ref/Operation/index.md) resource or the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call.

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
