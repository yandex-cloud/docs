---
title: How to perform {{ managed-k8s-name }} node maintenance with zero resource loss
description: Follow this guide to remove load from a {{ managed-k8s-name }} node and perform its maintenance without losing any resources, e.g., GPUs.
---

# Cluster node maintenance with zero resource loss

During maintenance and update, you may need to restart or recreate {{ managed-k8s-name }} cluster nodes. In which case node resources become publicly available again and can be taken by other users.

Reservation is especially relevant for limited availability resources, such as GPUs. If the GPU configuration turns out occupied during the GPU node restart, the start will terminate with an error.

There are two ways for you to preserve your resources during maintenance:

* [Using a reserved instance pool](#with-reserved-pool): Suitable for any node restart or recreation scenarios.
* [Using a maintenance task](#with-maintenance-task): Suitable if there is a node maintenance task in {{ compute-name }}.

## Using a reserved instance pool {#with-reserved-pool}

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

Node resources can be reserved using a [reserved instance pool](../../../compute/concepts/reserved-pools.md). In this case, during node restart or recreation, its resources will remain in the pool and not go public: the node will start on exactly the same resources.

1. [Create a reserved instance pool](../../../compute/operations/reserved-pools/create-reserved-pool.md) of size `0` with a configuration of existing nodes, e.g., with required GPU parameters.

1. [Expand the pool](../../../compute/operations/reserved-pools/update-reserved-pool.md) to as many nodes as you need by activating the `--allow-pending-slots` [resource wait option](../../../compute/concepts/reserved-pools.md#pending-slots). This parameter allows you to add slots, even if there are not enough free resources in the availability zone temporarily.

   Slots that did not get enough resources during the expansion will enter the `pending` status.

1. [Attach the nodes](../../../compute/operations/reserved-pools/manage-pool-vms.md#attach-existing-vm) of the existing {{ managed-k8s-name }} cluster to the new pool.

The {{ managed-k8s-name }} cluster nodes will occupy free slots in the pool. Next, the nodes will be started or recreated on the pool’s reserved resources.

## Using a maintenance task {#with-maintenance-task}

{% note warning %}

This zero resource loss maintenance method only suits scenarios where {{ compute-name }} has set a [maintenance task](../../../compute/operations/vm-control/gpus-maintenance.md#list-scheduled-maintenance).

If you want to restart or recreate a node with zero resource loss by yourself, [use a reserved instance pool](#with-reserved-pool).

{% endnote %}

{{ compute-name }} performs periodical [maintenance](../../../compute/concepts/gpus-maintenance.md) of the hardware your VMs need to operate. Sometimes maintenance implies restarting the GPU VMs.

To complete the maintenance task, GPU VM resources are reserved automatically and not made public again on restart: for maintenance it is enough to remove load from the node and perform a restart via {{ compute-name }}.

1. To figure out which node requires maintenance, [look up maintenance tasks](../../../compute/operations/vm-control/gpus-maintenance.md#list-scheduled-maintenance).

1. Make sure `kubectl` is connected to the right cluster and get a list of nodes:

    ```bash
    kubectl config current-context
    kubectl get nodes
    ```

    The node name in the command output matches the VM name in {{ compute-name }}.

1. Evict the pods from the node using `kubectl drain`:

    ```bash
    kubectl drain <node_name> \
      --ignore-daemonsets \
      --delete-emptydir-data
    ```

    Where `<node_name>` is the {{ k8s }} node name.

    After the command is executed, the node will enter the `SchedulingDisabled` status: new pods will no longer be created on it, and current active pods will be evicted to other cluster nodes.

    For more on pod eviction, see [{#T}](../../concepts/node-group/node-drain.md).

1. [Run the maintenance task immediately](../../../compute/operations/vm-control/gpus-maintenance.md#execute-now). The VM will restart but {{ compute-name }} will keep the GPU resources assigned to it.

1. Use the [management console](../kubernetes-console/nodes.md#uncordon) or this command to allow pods to be put on the node:

    ```bash
    kubectl uncordon <node_name>
    ```

    The node will once again become available for new pod scheduling.

#### Useful links {#see-also}

* [{#T}](../../concepts/node-group/node-drain.md)
* [{#T}](../../../compute/concepts/gpus-maintenance.md)
* [{#T}](../../../compute/operations/vm-control/gpus-maintenance.md)
* [{#T}](./node-group-create-in-instance-pool.md)
