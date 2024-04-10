# Viewing operations with the service's resources

All actions with {{ network-load-balancer-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Get a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   To see all operations with the service's resources, in the left-hand panel, select ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**. In the list that opens, you will also see operations with deleted resources.

   You can get a list of operations for a specific resource. The steps below describe how you can do this for a network load balancer. The same steps apply to a target group.

   1. In the [management console]({{ link-console-main }}), open the folder where the network load balancer is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Select the appropriate network load balancer.
   1. Go to the ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel.

      You will see a list of network load balancer operations.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations for a {{ network-load-balancer-name }} resource, run this command:

   ```bash
   yc load-balancer <resource_type> list-operations <resource_ID_or_name>
   ```

   **Example**

   Get a list of operations for a network load balancer:

   ```bash
   yc load-balancer network-load-balancer list-operations enpaud0h342p********
   ```

   You can get the network load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

   Result:

   ```text
   +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
   |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |        DESCRIPTION         |
   +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
   | enp87akr8sdr******** | 2024-02-01 09:33:45 | ajego134p5h1******** | 2024-02-01 09:33:45 | DONE   | Create NetworkLoadBalancer |
   +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
   ```

   By default, information about operations is provided as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

   ```bash
   yc load-balancer network-load-balancer list-operations enp87akr8sdr******** --format yaml
   ```

   Result:

   ```yaml
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

   To get a list of operations, use the `listOperations` REST API method for the appropriate resource or the `<service>/ListOperations` gRPC API call.

   For example, in the case of a network load balancer, use the [listOperations](../api-ref/NetworkLoadBalancer/listOperations.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/ListOperations](../api-ref/grpc/network_load_balancer_service.md#ListOperations) gRPC API call. Provide the network load balancer ID in the `networkLoadBalancerId` parameter of the request.

   You can get the network load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}

## Get detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
1. Copy the ID of the operation.
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

      ```yaml
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

      Use the [get](../api-ref/Operation/get.md) REST API method for the [Operation](../api-ref/Operation/index.md) resource or the [OperationService/Get](../api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
