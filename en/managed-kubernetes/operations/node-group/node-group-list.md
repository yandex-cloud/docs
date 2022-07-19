# Getting information about existing node groups

To find out the `ID` or `NAME` of a [node group](../../concepts/index.md#node-group), get a [list of node groups](#list) in the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) or [detailed information about the node group](#get).

## Getting a list of node groups in a cluster {{ k8s }} {#list}

Get a list of [node groups](../../concepts/index.md#node-group) in a {{ k8s }} cluster:

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of your {{ k8s }} cluster.
  1. Go to the **Node group** tab.

- CLI

  Run the command:

  ```bash
  yc managed-kubernetes node-group list
  ```

  Result:

  ```text
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  |          ID          |      CLUSTER ID      |      NAME      |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  | catvhf4iv6dt8hguut9i | catcafja9ktuc7ven4le | test-nodegroup | cl1ec3le3qv3g2k441sd | 2019-04-09 10:56:22 | RUNNING |    2 |
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  ```

- API

  To get the list of node groups in the default folder, use the [list](../../api-ref/NodeGroup/list.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

{% endlist %}

## Getting detailed information about a node group {#get}

To access a node group, use the `ID` or `NAME` parameters from the [previous](node-group-list.md#list) section.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of your {{ k8s }} cluster.
  1. Go to the **Node group** tab.
  1. Click on the name of the node group.

- CLI

  Get detailed information about the node group:

  ```bash
  yc managed-kubernetes node-group get test-nodegroup
  ```

  Result:

  ```text
  id: catvhf4iv6dt8hguut9i
  cluster_id: catcafja9ktuc7ven5ny
  created_at: "2019-04-09T10:56:22Z"
  ...
      subnet_id: b0c0jfcpqgngfu05rhcj
  instance_group_id: cl1ec3le3qv3g2k233sd
  node_version: 1.13.3
  ```

- API

  You can get detailed information about a node group using the [get](../../api-ref/NodeGroup/get.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

{% endlist %}