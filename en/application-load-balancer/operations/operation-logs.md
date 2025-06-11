# Viewing operations with {{ alb-name }} resources

The system logs all actions with {{ alb-name }} resources in an operation list. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  You can get a list of operations for a specific resource. The steps below describe how you can do this for an [L7 load balancer](../concepts/application-load-balancer.md). The same steps apply to other resources as well.

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.alb.label_load-balancers }}**.
  1. Select the load balancer you need.
  1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected load balancer.

     You will see a list of operations with the selected load balancer.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of operations for the {{ alb-name }} resource, run this command:

  ```bash
  yc alb <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Getting a list of operations for a load balancer:

  ```bash
  yc alb load-balancer list-operations ds7857cmjtuv********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | ds71vdf0jqut******** | 2024-05-14 14:36:06 | aje9k8luj4qf******** | 2024-05-14 14:36:06 | DONE   | update loadbalancer            |
  |                      |                     |                      |                     |        | 'ds7857cmjtuv********'         |
  | ds7nspb18tkg******** | 2024-05-14 12:29:53 | aje9k8luj4qf******** | 2024-05-14 12:34:46 | DONE   | create loadbalancer            |
  |                      |                     |                      |                     |        | 'ds7857cmjtuv********'         |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  ```

  By default, operation information is displayed as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` parameter:

  ```bash
  yc alb load-balancer list-operations ds7857cmjtuv******** --format yaml
  ```

  Result:

  ```text
  - id: ds71vdf0jqut********
    description: update loadbalancer 'ds7857cmjtuv********'
    created_at: "2024-05-14T14:36:06.637766633Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T14:36:06.666429213Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.UpdateLoadBalancerMetadata
      load_balancer_id: ds7857cmjtuv********
    response:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.LoadBalancer
      id: ds7857cmjtuv********
      name: my-alb
      folder_id: b1g681qpemb4********
      status: ACTIVE
      ...
      created_at: "2024-05-14T12:29:53.571411960Z"
      log_options: {}
  - id: ds7nspb18tkg********
    description: create loadbalancer 'ds7857cmjtuv********'
    created_at: "2024-05-14T12:29:53.571411960Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T12:34:46.963930680Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.CreateLoadBalancerMetadata
      load_balancer_id: ds7857cmjtuv********
    response:
      '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.LoadBalancer
      id: ds7857cmjtuv********
      name: my-alb
      folder_id: b1g681qpemb4********
      status: ACTIVE
      ...
      created_at: "2024-05-14T12:29:53.571411960Z"
      log_options: {}
  ```

- API {#api}

  Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, for a load balancer, use either the [listOperations](../api-ref/LoadBalancer/listOperations.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/ListOperations](../api-ref/grpc/LoadBalancer/listOperations.md) gRPC API call.

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

     ```yaml
     id: ds7nspb18tkg********
     description: create loadbalancer 'ds7857cmjtuv********'
     created_at: "2024-05-14T12:29:53.571411960Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-05-14T12:34:46.963930680Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.CreateLoadBalancerMetadata
       load_balancer_id: ds7857cmjtuv********
     response:
       '@type': type.googleapis.com/yandex.cloud.apploadbalancer.v1.LoadBalancer
       id: ds7857cmjtuv********
       name: my-alb
       folder_id: b1g681qpemb4********
       status: ACTIVE
       region_id: {{ region-id }}
       network_id: enp3srbi9u49********
       allocation_policy:
         locations:
           - zone_id: {{ region-id }}-a
             subnet_id: e9bpric55er9********
           - zone_id: {{ region-id }}-b
             subnet_id: e2l15qssjar5********
           - zone_id: {{ region-id }}-d
             subnet_id: fl85ebb396ub********
       created_at: "2024-05-14T12:29:53.571411960Z"
       log_options: {}
     ```

   - API {#api}

     Use the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
