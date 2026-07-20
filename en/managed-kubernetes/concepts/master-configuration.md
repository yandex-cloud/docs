---
title: Recommended master configurations {{ k8s }}
description: This article provides recommended master configurations for {{ managed-k8s-name }}.
---

# Recommended master configurations

You can select [master](./index.md#master) configuration when [creating](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../operations/kubernetes-cluster/kubernetes-cluster-update.md#manage-resources) your cluster. For stable operation, make sure the master configuration matches the workload of your cluster.

You can use this table to find the master configuration based on your specific cluster specifications. These values are for reference only: select the row where specs align closest with your cluster.

The optimal master configuration depends on your workload profile, cluster resources, operator performance, and other factors. These parameters determine whether a more robust configuration may be required.

{% note tip %}

The table below lists Standard master configurations with a 4:1 RAM to vCPU ratio. If this configuration does not match your workload profile, select an appropriate CPU Optimized or Memory Optimized configuration from the [list of available configurations](../operations/kubernetes-cluster/kubernetes-cluster-configuration-list.md).

{% endnote %}

The selected configuration allocates minimum resources to the master. As the load increases, the master's RAM and vCPU count may scale automatically. If you enable [master node autoscaling](./autoscale.md#master-autoscaler) in your cluster, your selected configuration will serve as the lower scaling limit.

{% include [master-autoscaler-note](../../_includes/managed-kubernetes/master-autoscaler-note.md) %}

#|
|| **Cluster specifications** {align="center"} | > | **Recommended master configuration** {align="center"} | > ||
|| **Nodes** | **Pods** | **vCPU** | **RAM** ||
||  < 128 | < 8&nbsp;192 | 2 vCPU | 8 GB ||
||  128 | 8&nbsp;192 | 4 vCPU | 16 GB ||
||  128 | 14&nbsp;080 | 8 vCPU | 32 GB ||
||  256 | 16&nbsp;384 | 8 vCPU | 32 GB ||
||  256 | 28&nbsp;160 | 16 vCPU | 64 GB ||
||  512 | 32&nbsp;768 | 16 vCPU | 64 GB ||
|#

