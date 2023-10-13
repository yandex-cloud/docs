# Node groups with GPUs

You can create [node groups](../index.md#node-group) with [graphics accelerators (GPUs)](../../../compute/concepts/gpus.md) in [{{ managed-k8s-name }} clusters](../index.md#kubernetes-cluster). A node is created from an [image](../../../compute/concepts/image.md) of a GPU-compatible [VM](../../../compute/concepts/vm.md) with NVIDIA drivers and [CUDA libraries](https://developer.nvidia.com/gpu-accelerated-libraries) installed for GPU acceleration.

## Prerequisites {#requirements}

* A cloud must have a non-zero GPU quota.

  {% include [compute-gpu-zero-quota](../../../_includes/compute/gpu-zero-quota.md) %}

* A node group must reside in the `{{ region-id }}-a` or `{{ region-id }}-b` [availability zone](../../../overview/concepts/geo-scope.md), or in both. VMs with GPUs are only available in these zones.

  When requesting a GPU quota, keep in mind which zones you are going to run your {{ k8s }} clusters in.
  

## Pricing {#pricing}

To run node groups with GPUs, you need a {{ managed-k8s-name }} cluster, a VM with a GPU, and traffic. Therefore, billing consists of the following parts:
* Using a [{{ managed-k8s-name }} master](../index.md#master) is charged according to the [{{ managed-k8s-name }} pricing policy](../../pricing.md).
* VM with a GPU, according to the [{{ compute-full-name }} pricing policy](../../../compute/pricing.md#prices-instance-resources).
* Outgoing traffic, according to the [{{ vpc-full-name }} pricing policy](../../../vpc/pricing.md).