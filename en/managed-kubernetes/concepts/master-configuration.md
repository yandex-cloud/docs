---
title: Recommended master configurations {{ k8s }}
description: This article provides recommended master configurations for {{ managed-k8s-name }}.
---

# Recommended master configurations

You can select [master](./index.md#master) configuration when [creating](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../operations/kubernetes-cluster/kubernetes-cluster-update.md#manage-resources) your cluster. For stable operation, make sure the master configuration matches the workload of your {{ k8s }} cluster.

You can use this table to find the minimum master configuration based on your specific cluster specifications. Configurations may change over time. You can view the list of available configurations [here](../operations/kubernetes-cluster/kubernetes-cluster-configuration-list.md).

The selected configuration allocates minimum resources to the master. If you enable [master node auto-scaling](./autoscale.md#master-autoscaler) in your cluster, your selected configuration will serve as the lower scaling limit.

#|
|| **Cluster specifications** {align="center"} | > | > | **Estimated master node requirements** {align="center"} | > | **Recommended master configuration** {align="center"} | > | > ||
|| **CNI** | **Nodes** | **Maximum number of pods** | **vCPU** | **RAM** | **Standard** | **CPU Optimized** | **Memory Optimized** ||
|| Calico | 128 | 8&nbsp;192 | 3 vCPU | 12 GB | 4 vCPUs, 16 GB RAM (s-c4-m16) | 8 vCPUs, 16 GB RAM (c-c8-m16) | 4 vCPUs, 32 GB RAM (m-c4-m32) ||
|| Calico | 128 | 14&nbsp;080 | 6 vCPU | 21 GB | 8 vCPUs, 32 GB RAM (s-c8-m32) | 16 vCPUs, 32 GB RAM (c-c16-m32) | 8 vCPUs, 64 GB RAM (m-c8-m64) ||
|| Calico | 256 | 16&nbsp;384 | 6 vCPU | 24 GB | 8 vCPUs, 32 GB RAM (s-c8-m32) | 16 vCPUs, 32 GB RAM (c-c16-m32) | 8 vCPUs, 64 GB RAM (m-c8-m64) ||
|| Calico | 256 | 28&nbsp;160 | 11 vCPU | 42 GB | 16 vCPUs, 64 GB RAM (s-c16-m64) | 32 vCPUs, 64 GB RAM (c-c32-m64) | 16 vCPUs, 128 GB RAM (m-c16-m128) ||
|| Calico | 512 | 32&nbsp;768 | 12 vCPU | 48 GB | 16 vCPUs, 64 GB RAM (s-c16-m64) | 32 vCPUs, 64 GB RAM (c-c32-m64) | 16 vCPUs, 128 GB RAM (m-c16-m128) ||
|| Cilium | 128 | 8&nbsp;192 | 4 vCPU | 16 GB | 4 vCPUs, 16 GB RAM (s-c4-m16) | 8 vCPUs, 16 GB RAM (c-c8-m16) | 4 vCPUs, 32 GB RAM (m-c4-m32) ||
|| Cilium | 128 | 14&nbsp;080 | 7 vCPU | 26 GB | 8 vCPUs, 32 GB RAM (s-c8-m32) | 16 vCPUs, 32 GB RAM (c-c16-m32) | 8 vCPUs, 64 GB RAM (m-c8-m64) ||
|| Cilium | 256 | 16&nbsp;384 | 8 vCPU | 30 GB | 8 vCPUs, 32 GB RAM (s-c8-m32) | 16 vCPUs, 32 GB RAM (c-c16-m32) | 8 vCPUs, 64 GB RAM (m-c8-m64) ||
|| Cilium | 256 | 28&nbsp;160 | 13 vCPU | 51 GB | 16 vCPUs, 64 GB RAM (s-c16-m64) | 32 vCPUs, 64 GB RAM (c-c32-m64) | 16 vCPUs, 128 GB RAM (m-c16-m128) ||
|| Cilium | 512 | 32&nbsp;768 | 15 vCPU | 59 GB | 16 vCPUs, 64 GB RAM (s-c16-m64) | 32 vCPUs, 64 GB RAM (c-c32-m64) | 16 vCPUs, 128 GB RAM (m-c16-m128) ||
|#
