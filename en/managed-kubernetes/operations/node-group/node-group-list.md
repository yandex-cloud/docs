# Information about existing node groups

To find out the `ID` or `NAME` of a [node group](../../concepts/index.md#node-group), get a [list of node groups](#list) in the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) or [detailed information about the node group](#get).

## Getting a list of node groups in a cluster {{ k8s }} {#list}

Get a list of [node groups](../../concepts/index.md#node-group) in a {{ k8s }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the name of the {{ k8s }} cluster.
   1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.

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

   To get the list of node groups in the default folder, use the [list](../../managed-kubernetes/api-ref/NodeGroup/list.md) method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/) resource.

{% endlist %}

## Getting detailed information about a node group {#get}

To access a node group, use the `ID` or `NAME` parameters from the [previous](node-group-list.md#list) section.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the name of the {{ k8s }} cluster.
   1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
   1. Click the name of the node group.

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

- API {#api}

   You can get detailed information about a node group using the [get](../../managed-kubernetes/api-ref/NodeGroup/get.md) method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/) resource.

{% endlist %}