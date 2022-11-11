# Node groups with GPUs

You can create node groups with graphics accelerators (GPUs) in {{ k8s }} clusters. A node is created from an image of a GPU-compatible VM with NVIDIA drivers and [CUDA libraries](https://developer.nvidia.com/gpu-accelerated-libraries) installed for GPU acceleration.

## Requirements {#requirements}

* The {{ k8s }} version is 1.16 or higher.

  To use the GPU, make sure the {{ k8s }} version on the cluster and node group is 1.16 or higher.
* A non-zero GPU quota.

  By default, the cloud has a zero [quota]({{ link-console-quotas }}) for using VMs with GPUs. To change the quota, contact [technical support]({{ link-console-support }}).

* The cluster is in the {% if product == "yandex-cloud" %}`{{ region-id }}-a` and `{{ region-id }}-b` [availability zones](../../../overview/concepts/geo-scope.md){% endif %}{% if product == "cloud-il" %}`{{ region-id }}-a` [availability zone](../../../overview/concepts/geo-scope.md){% endif %}, where VMs with GPUs are available.

  When requesting a GPU quota, keep in mind which zones you're going to run your {{ k8s }} clusters in.


## Billing {#pricing}

To run node groups with GPUs, you need a {{ k8s }} cluster, a VM with a GPU, and traffic. Therefore, billing consists of the following parts:
* Using a {{ k8s }} master is charged according to the [{{ k8s }} pricing policy](../../pricing.md).
* VM with a GPU — according to the [{{ compute-short-name }} pricing policy](../../../compute/pricing.md#prices-instance-resources).
* Outgoing traffic — according to the [{{ vpc-name }} pricing policy](../../../vpc/pricing.md).