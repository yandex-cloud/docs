---
title: Node groups with GPUs
description: In this article, you will learn about node groups with GPUs, their requirements, and pricing.
---

# Node groups with GPUs


In a [{{ managed-k8s-name }} cluster](../index.md#kubernetes-cluster), you can create [node groups](../index.md#node-group) with [graphics accelerators](../../../compute/concepts/gpus.md) (GPUs). A node is created from an [image](../../../compute/concepts/image.md) of a GPU-compatible [VM](../../../compute/concepts/vm.md) with NVIDIA drivers and [CUDA libraries](https://developer.nvidia.com/gpu-accelerated-libraries) installed for GPU acceleration.

## Prerequisites {#requirements}

* A cloud must have a non-zero GPU quota.

  {% include [compute-gpu-zero-quota](../../../_includes/compute/gpu-zero-quota.md) %}

* {% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

  When selecting these platforms, the node group must reside in one or both of the specified availability zones.

## Pricing {#pricing}

To run node groups with GPUs, you need a {{ managed-k8s-name }} cluster, a VM with a GPU, and traffic. Therefore, billing includes the following:
* [{{ managed-k8s-name }} master usage](../index.md#master) is charged according to the [{{ managed-k8s-name }} pricing policy](../../pricing.md).
* VM with a GPU, according to the [{{ compute-full-name }} pricing policy](../../../compute/pricing.md#prices-instance-resources).
* Outgoing traffic, according to the [{{ vpc-full-name }} pricing policy](../../../vpc/pricing.md).

## Use cases {#examples}

* [{#T}](../../tutorials/driverless-gpu.md)
