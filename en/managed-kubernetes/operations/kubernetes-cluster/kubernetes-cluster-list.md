# Information about existing {{ managed-k8s-name }} clusters

To find out the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) `ID` or `NAME`, get a list of {{ k8s }} clusters in the folder or detailed information about the {{ k8s }} cluster.

## Getting a list of {{ k8s }} clusters in a folder {#list}

Get a list of {{ k8s }} clusters in the default folder.

{% list tabs group=instructions %}

- Management console {#console}

   To get a list of {{ k8s }} clusters, go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.

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

   To get the list of {{ k8s }} clusters in the default folder, use the [list](../../managed-kubernetes/api-ref/Cluster/list.md) method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/) resource.

{% endlist %}

## Getting detailed information about a {{ k8s }} cluster {#get}

To access a {{ k8s }} cluster, use the `ID` or `NAME` parameters from the [previous](kubernetes-cluster-list.md#list) section.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the name of the {{ k8s }} cluster.

- CLI {#cli}

   Get detailed information about the {{ k8s }} cluster:

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

- API {#api}

   You can get detailed information about a {{ k8s }} cluster using the [get](../../managed-kubernetes/api-ref/Cluster/get.md) method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/)resource.

{% endlist %}