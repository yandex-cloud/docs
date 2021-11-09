# Creating a node group

To create a node group, [create a {{ k8s }} cluster](../kubernetes-cluster/kubernetes-cluster-create.md) first.

## Create a node group {#node-group-create}

{% list tabs %}

- Management console

  {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Create a node group:

  ```bash
  yc managed-kubernetes node-group create \
    --name my-node-group \
    --cluster-name test-k8s \
    --platform-id standard-v2 \
    --location subnet-name=yc-auto-subnet-0,zone=ru-central1-a \
    --public-ip \
    --cores 2 \
    --memory 4 \
    --core-fraction 50 \
    --disk-type network-ssd \
    --disk-size 96 \
    --fixed-size 2 \
    --version 1.13 \
    --daily-maintenance-window start=22:00,duration=10h
  ```

  Command execution result:

  ```bash
  done (1m17s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
      start_time:
        hours: 22
      duration: 36000s
  ```

  Where:
  * `--name`: Name of the node group.
  * `--cluster-name`: Name of the {{ k8s }} cluster where the node group is created.
  * `--platform-id`: The [platform](../../../compute/concepts/vm-platforms.md) to host the nodes.
  * `--public-ip`: The flag that is specified if the node group needs a public IP address.
  * `--memory`: Amount of memory allocated for the nodes.
  * `--cores`: Number of vCPUs for the nodes.
  * `--core-fraction`: [Guaranteed vCPU performance](../../../compute/concepts/performance-levels.md) for the nodes.
  * `--preemptible`: Flag specified if the VM instances should be [preemptible](../../../compute/concepts/preemptible-vm.md).
  * `--disk-type`: The type of the disk on the node.
  * `--disk-size`: Size of the disk on the node.
  * `--fixed-size`: Number of nodes in the node group.
  * `--location`: Availability zone, network, and subnet to host the nodes on. You can specify several options.
  * `--version`: The {{ k8s }} version on the nodes.
  * `--daily-maintenance-window`: The maintenance window settings.

  {% include [user-data](../../../_includes/managed-kubernetes/user-data.md) %}

- API

  To create a node group, use the [create](../../api-ref/NodeGroup/create.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

{% endlist %}