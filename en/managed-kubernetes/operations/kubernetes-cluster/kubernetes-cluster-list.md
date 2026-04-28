# Information about existing {{ managed-k8s-name }} clusters

To find out the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) `ID` or `NAME`, get a list of {{ k8s }} clusters in the folder or detailed information about the {{ k8s }} cluster.

## Getting a list of {{ k8s }} clusters in a folder {#list}

Get a list of {{ k8s }} clusters in the default folder.

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of {{ k8s }} clusters, in the [management console]({{ link-console-main }}), select a folder and [go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc managed-kubernetes cluster list
  ```

  Result:

  ```text
  +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
  |          ID          |       NAME       |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    | INTERNAL ENDPOINT |
  +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
  | cata9ertn6tc******** | test-k8s-cluster | 2019-04-12 10:00:27 | HEALTHY | RUNNING | https://84.201.150.176/ | https://10.0.0.3/ |
  +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    ```

- API {#api}

  Use either the [list](../../managed-kubernetes/api-ref/Cluster/list.md) REST API method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/) resource or the [ClusterService/List](../../managed-kubernetes/api-ref/grpc/Cluster/list.md) gRPC API call.

{% endlist %}

## Getting detailed information about a {{ k8s }} cluster {#get}

To access a {{ k8s }} cluster, use the `ID` or `NAME` parameters from the [previous](kubernetes-cluster-list.md#list) section.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ k8s }} cluster.

- CLI {#cli}

  Get detailed information about a {{ k8s }} cluster:

  ```bash
  yc managed-kubernetes cluster get test-k8s-cluster
  ```

  Result:

  ```text
  id: cata9ertn6tc********
  folder_id: b1g88tflru0e********
  created_at: "2019-04-12T10:00:27Z"
  ...
  ip_allocation_policy:
    cluster_ipv4_cidr_block: 10.13.0.0/16
    service_ipv4_cidr_block: 10.14.0.0/16
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To get information about a {{ managed-k8s-name }} cluster:

  1. {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Create a {{ TF }} configuration file with a description of the `yandex_kubernetes_cluster` data source in the `data` section and the requested parameters in the `output` sections (one per section). For example:

      ```hcl
      data "yandex_kubernetes_cluster" "my_cluster" {
        cluster_id = "<cluster_ID>"
      }

      output "external_v4_endpoint" {
        value = data.yandex_kubernetes_cluster.my_cluster.master.0.external_v4_endpoint
      }
      ```

      Where:

      * `external_v4_endpoint`: Name of the variable whose value will appear in the result.
      * `data.yandex_kubernetes_cluster.my_cluster.master.0.external_v4_endpoint`: Requested parameter. In our case, it is the cluster’s public IP address.

      For the list of cluster parameters you can request this way, see [this {{ TF }} provider guide]({{ tf-provider-datasources-link }}/kubernetes_cluster).

      {% note tip %}

      To request all available information about a cluster, add the following `output` section to the file:

      ```hcl
      output "kubernetes_cluster" {
        value = data.yandex_kubernetes_cluster.my_cluster
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

  1. To check the result, run the following command by specifying the required variable, e.g.:

      ```bash
      terraform output external_v4_endpoint
      ```

      Result:

      ```text
      "https://158.1**.***.***"
      ```

- API {#api}

  To get detailed information about a {{ k8s }} cluster, use the [get](../../managed-kubernetes/api-ref/Cluster/get.md) REST API method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/) resource or the [ClusterService/Get](../../managed-kubernetes/api-ref/grpc/Cluster/get.md) gRPC API call.

{% endlist %}
