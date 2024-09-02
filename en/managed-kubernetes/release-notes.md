# {{ managed-k8s-full-name }} release notes

Updates appear in the service's [release channels](./concepts/release-channels-and-updates.md) in a sequence. First, updates with new features and improvements appear in the `rapid` channel and, after a while, in the `regular` channel, and only then they are added to the `stable` channel.

## H1 2024 {#h1-2024}

### New features {#h1-2024-new-features}

* Added support for {{ k8s }} [1.28](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.28.md), [1.29](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md), and [1.30](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md). For more information, see [{#T}](./concepts/release-channels-and-updates.md).
* Updated [CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md) limits to support disks larger than 200 TB.

### Fixes and improvements {#h1-2024-problems-solved}

* Fixed an error that could cause the [snapshot](https://kubernetes.io/docs/concepts/storage/volume-snapshots/) size to be missing when [PersistentVolume](./concepts/volume.md#persistent-volume) was large.
* Fixed an error where, during some [node group](./concepts/index.md#node-group) updates, routes would fail to update to [podCIDR](https://kubernetes.io/docs/reference/kubernetes-api/cluster-resources/node-v1/#NodeSpec), causing pods on the node to be unavailable.
* Fixed a number of vulnerabilities in [runC](https://github.com/opencontainers/runc).
* Fixed a problem with running a [cluster](./concepts/index.md#kubernetes-cluster) after updating certificates while it was stopped.
* Fixed an error that, in some cases, caused a new node to permanently remain in the `NOT_CONNECTED` status.

## 2023 {#2023}

### Release 2023-6 {#2023-6}

In the `rapid`, `regular`, and `stable` release channels, the following changes are available:
* Added support for [ultra high-speed network storages with three replicas (SSD)](../compute/concepts/disk.md#disks-types) for [storage classes](./operations/volumes/manage-storage-class.md) and [persistent volumes](./concepts/volume.md#persistent-volume).
* Node groups can now be used with [GPUs](../compute/concepts/gpus.md) without preinstalled drivers. Now you can use the [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html) application to select an appropriate driver version. For more information, see [{#T}](./tutorials/driverless-gpu.md).
* Removed the CPU resource restriction imposed on [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/) pods to prevent throttling.
* Added support for [placement groups of non-replicable disks](../compute/concepts/disk-placement-group.md) in the {{ k8s }} CSI driver. Placement group parameters are available for [storage classes](./operations/volumes/manage-storage-class.md).
* Fixed the error of ignoring a [log group](../logging/concepts/log-group.md) ID when updating the `master_logging` parameter in the cluster.
* Updated the [Calico](./concepts/network-policy.md#calico) network controller to version [3.25](https://docs.tigera.io/archive/v3.25/release-notes/) for {{ k8s }} versions beginning with 1.24.

### Release 2023-5 {#2023-5}

In the `rapid`, `regular`, and `stable` release channels, the following changes are available:
* Fixed the issue where the Guest Agent on nodes would access a resource outside a cluster.
* Updated the [patch version](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#changelog-since-v1273) for {{ k8s }} version 1.27.
* Added support for {{ k8s }} version 1.26.
