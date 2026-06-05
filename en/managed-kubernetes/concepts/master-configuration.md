---
title: Recommended master configurations for {{ k8s }}
description: This article lists the recommended master configurations for {{ managed-k8s-name }}.
---

# Recommended master configurations

You can select the [master](./index.md#master) configuration when [creating](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../operations/kubernetes-cluster/kubernetes-cluster-update.md#manage-resources) a cluster. For stable operation, the master configuration must match the cluster workload.

Use the table to select the minimum master configuration based on your cluster parameters. Configurations may change; see the [list of available configurations](../operations/kubernetes-cluster/kubernetes-cluster-configuration-list.md).

The selected configuration sets the minimum resource values for the master. If [master autoscaling](./autoscale.md#master-autoscaler) is enabled in the cluster, the selected configuration is used as the lower scaling boundary.

#|
|| **Cluster parameters** {.cell-align-top-center} | > | > | **Estimated master requirements** {.cell-align-top-center} | > | **Recommended master configuration** {.cell-align-top-center} | > | > ||
|| **CNI** | **Nodes** | **Maximum pods** | **vCPU** | **RAM** | **Standard** | **CPU Optimized** | **Memory Optimized** ||
|| Calico | 128 | 8&nbsp;192 | 3 vCPU | 12 GB | 4 vCPU, 16 GB RAM (s-c4-m16) | 8 vCPU, 16 GB RAM (c-c8-m16) | 4 vCPU, 32 GB RAM (m-c4-m32) ||
|| Calico | 128 | 14&nbsp;080 | 6 vCPU | 21 GB | 8 vCPU, 32 GB RAM (s-c8-m32) | 16 vCPU, 32 GB RAM (c-c16-m32) | 8 vCPU, 64 GB RAM (m-c8-m64) ||
|| Calico | 256 | 16&nbsp;384 | 6 vCPU | 24 GB | 8 vCPU, 32 GB RAM (s-c8-m32) | 16 vCPU, 32 GB RAM (c-c16-m32) | 8 vCPU, 64 GB RAM (m-c8-m64) ||
|| Calico | 256 | 28&nbsp;160 | 11 vCPU | 42 GB | 16 vCPU, 64 GB RAM (s-c16-m64) | 32 vCPU, 64 GB RAM (c-c32-m64) | 16 vCPU, 128 GB RAM (m-c16-m128) ||
|| Calico | 512 | 32&nbsp;768 | 12 vCPU | 48 GB | 16 vCPU, 64 GB RAM (s-c16-m64) | 32 vCPU, 64 GB RAM (c-c32-m64) | 16 vCPU, 128 GB RAM (m-c16-m128) ||
|| Cilium | 128 | 8&nbsp;192 | 4 vCPU | 16 GB | 4 vCPU, 16 GB RAM (s-c4-m16) | 8 vCPU, 16 GB RAM (c-c8-m16) | 4 vCPU, 32 GB RAM (m-c4-m32) ||
|| Cilium | 128 | 14&nbsp;080 | 7 vCPU | 26 GB | 8 vCPU, 32 GB RAM (s-c8-m32) | 16 vCPU, 32 GB RAM (c-c16-m32) | 8 vCPU, 64 GB RAM (m-c8-m64) ||
|| Cilium | 256 | 16&nbsp;384 | 8 vCPU | 30 GB | 8 vCPU, 32 GB RAM (s-c8-m32) | 16 vCPU, 32 GB RAM (c-c16-m32) | 8 vCPU, 64 GB RAM (m-c8-m64) ||
|| Cilium | 256 | 28&nbsp;160 | 13 vCPU | 51 GB | 16 vCPU, 64 GB RAM (s-c16-m64) | 32 vCPU, 64 GB RAM (c-c32-m64) | 16 vCPU, 128 GB RAM (m-c16-m128) ||
|| Cilium | 512 | 32&nbsp;768 | 15 vCPU | 59 GB | 16 vCPU, 64 GB RAM (s-c16-m64) | 32 vCPU, 64 GB RAM (c-c32-m64) | 16 vCPU, 128 GB RAM (m-c16-m128) ||
|#
