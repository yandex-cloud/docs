# Information about existing node groups

To find out the `ID` or `NAME` of a [node group](../../concepts/index.md#node-group), get a [list of node groups](#list) in the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) or [detailed information about the node group](#get).

## Getting a list of node groups in a {{ k8s }} cluster {#list}

Get a list of [node groups](../../concepts/index.md#node-group) in a {{ k8s }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ k8s }} cluster.
  1. Navigate to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.

- CLI {#cli}

  Run this command:

  ```bash
  yc managed-kubernetes node-group list
  ```

  Result:

  ```text
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  |          ID          |      CLUSTER ID      |      NAME      |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  | catvhf4iv6dt******** | catcafja9ktu******** | test-nodegroup | cl1ec3le3qv3******** | 2019-04-09 10:56:22 | RUNNING |    2 |
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  ```

- API {#api}

  To get a list of node groups in a folder, use the [list](../../managed-kubernetes/api-ref/NodeGroup/list.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/) resource or the [NodeGroupService/List](../../managed-kubernetes/api-ref/grpc/NodeGroup/list.md) gRPC API call.

{% endlist %}

## Getting detailed information about a node group {#get}

To access a node group, use the `ID` or `NAME` parameter from the [previous](node-group-list.md#list) step.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ k8s }} cluster.
  1. Navigate to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click the name of the node group.

  To view information about a specific node, navigate to the **{{ ui-key.yacloud.k8s.node-group.overview.label_tab-nodes }}** tab and click the node name. {#get-node}

- CLI {#cli}

  Get detailed information about the node group:

  ```bash
  yc managed-kubernetes node-group get test-nodegroup
  ```

  Result:

  ```text
  id: catvhf4iv6dt********
  cluster_id: catcafja9ktu********
  created_at: "2019-04-09T10:56:22Z"
  ...
      subnet_id: b0c0jfcpqgng********
  instance_group_id: cl1ec3le3qv3********
  node_version: 1.13.3
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To get information about a {{ managed-k8s-name }} node group:

  1. {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Create a {{ TF }} configuration file with a description of the `yandex_kubernetes_node_group` data source in the `data` section and the requested parameters in the `output` sections (one per section). For example:

      ```hcl
      data "yandex_kubernetes_node_group" "my_node_group" {
        node_group_id = "<node_group_ID>"
      }

      output "node_group_status" {
        value = data.yandex_kubernetes_node_group.my_node_group.status
      }
      ```

      Where:

      * `node_group_status`: Name of the variable whose value will appear in the result.
      * `data.yandex_kubernetes_node_group.my_node_group.status`: Requested parameter. In our case, it is the node group status.

      For the list of node group parameters you can request this way, see [this {{ TF }} provider guide]({{ tf-provider-datasources-link }}/kubernetes_node_group).

      {% note tip %}

      To request all available information about a node group, add the following `output` section to the file:

      ```hcl
      output "node_group" {
        value = data.yandex_kubernetes_node_group.my_node_group
      }
      ```

      {% endnote %}

  1. Make sure the configuration files are correct:

      1. In the command line, navigate to the folder containing the current {{ TF }} configuration files.

      1. Run this command:

          ```bash
          terraform validate
          ```

          {{ TF }} will display any configuration errors detected in your files.

  1. Run this command:

      ```bash
      terraform apply
      ```

      {{ TF }} will display output variables in the terminal.

  1. To check the results, run the following command specifying the required variable, e.g.:

      ```bash
      terraform output node_group_status
      ```

      Result:

      ```text
      "running"
      ```

- API {#api}

  To get detailed information about a node group, use the [get](../../managed-kubernetes/api-ref/NodeGroup/get.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/) resource or the [NodeGroupService/Get](../../managed-kubernetes/api-ref/grpc/NodeGroup/get.md) gRPC API call.

{% endlist %}
