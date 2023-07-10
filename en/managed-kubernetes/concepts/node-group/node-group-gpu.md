# Node groups with GPUs

You can create node groups with graphics accelerators (GPUs) in {{ k8s }} clusters. A node is created from an image of a GPU-compatible VM with NVIDIA drivers and [CUDA libraries](https://developer.nvidia.com/gpu-accelerated-libraries) installed for GPU acceleration.

## Requirements {#requirements}

* The cloud must have a non-zero GPU quota.

  {% include [compute-gpu-zero-quota](../../../_includes/compute/gpu-zero-quota.md) %}

* The node group must be located in the [availability zone](../../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, `{{ region-id }}-b`, or both. These are the only zones where VMs with GPUs are available.

  When requesting a GPU quota, keep in mind which zones you're going to run your {{ k8s }} clusters in.
  

## Pricing {#pricing}

To run node groups with GPUs, you need a {{ k8s }} cluster, a VM with a GPU, and traffic. Therefore, billing consists of the following parts:
* Using a {{ k8s }} master is charged according to the [{{ managed-k8s-name }} pricing policy](../../pricing.md).
* VM with a GPU — according to the [{{ compute-full-name }} pricing policy](../../../compute/pricing.md#prices-instance-resources).
* Outgoing traffic — according to the [{{ vpc-full-name }} pricing policy](../../../vpc/pricing.md).