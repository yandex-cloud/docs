# {{ managed-k8s-full-name }} release notes

Updates appear in the service's [release channels](./concepts/release-channels-and-updates.md) in a sequence. First, updates with new features and improvements appear in the `rapid` channel and, after a while, in the `regular` channel, and only then they are added to the `stable` channel.

## Release 2023-6 {#2023-6}

In the `rapid`, `regular`, and `stable` release channels, the following changes are available:
* Added support for [high performance SSDs](../compute/concepts/disk.md#disks-types) for [storage classes](./operations/volumes/manage-storage-class.md) and [persistent volumes](./concepts/volume.md#persistent-volume).
* Node groups can now be used with [GPUs](../compute/concepts/gpus.md) without preinstalled drivers. Now you can use the [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html) application to select an appropriate driver version. For more information, see [{#T}](./tutorials/driverless-gpu.md).
* Removed the CPU resource restriction imposed on [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/) pods to prevent throttling.
* Added support for [placement groups of non-replicable disks](../compute/concepts/disk-placement-group.md) in the {{ k8s }} CSI driver. Placement group parameters are available for [storage classes](./operations/volumes/manage-storage-class.md).
* Fixed the error of ignoring a [log group](../logging/concepts/log-group.md) ID when updating the `master_logging` parameter in the cluster.
* Updated the [Calico](./concepts/network-policy.md#calico) network controller to version [3.25](https://docs.tigera.io/archive/v3.25/release-notes/) for {{ k8s }} versions beginning with 1.24.

## Release 2023-5 {#2023-5}

In the `rapid`, `regular`, and `stable` release channels, the following changes are available:
* Fixed the issue where the Guest Agent on nodes would access a resource outside a cluster.
* Updated the [patch version](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#changelog-since-v1273) for {{ k8s }} version 1.27.
* Added support for {{ k8s }} version 1.26.
