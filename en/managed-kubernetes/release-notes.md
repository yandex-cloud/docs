# {{ managed-k8s-full-name }} release notes

Updates appear in the service's [release channels](./concepts/release-channels-and-updates.md) in a sequence. First, updates with new features and improvements are released in the `rapid` channel, after a while, in the `regular` channel, and only then they become available in the `stable` channel.

## Q4 2024 {#q4-2024}

### New features {#q4-2024-new-features}

* Added support for {{ k8s }} version [1.31](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.31.md). For more information, see [{#T}](./concepts/release-channels-and-updates.md).
* Updated [Cilium](https://cilium.io/) from version [1.12.9](https://github.com/cilium/cilium/releases/tag/v1.12.9) to [1.15.10](https://github.com/cilium/cilium/releases/tag/v1.15.10) for clusters with {{ k8s }} version 1.31 and higher.
* Updated [CoreDNS](https://coredns.io/) from version [1.9.4](https://github.com/coredns/coredns/releases/tag/v1.9.4) to [1.11.3](https://github.com/coredns/coredns/releases/tag/v1.11.3) for all supported {{ k8s }} versions.

### Fixes and improvements {#q4-2024-problems-solved}

* Added a _preflight check_ for compatibility of objects or configurations with the new {{ k8s }} version before cluster upgrade.

  If the check identifies incompatible objects or configurations, the upgrade will return an error with a list of incompatible resources and a description. 

  Currently, only [Cilium network policies](./concepts/network-policy.md#cilium) are checked.
* Fixed an issue that in some cases made it impossible to connect a new node to the cluster, the node ending up with a permanent `NOT_CONNECTED` status.

## Q3 2024 {#q3-2024}

### New features {#q3-2024-new-features}

Added support for migrating [masters](./concepts/index.md#master) between [subnets](../vpc/concepts/network.md#subnet) within a single [availability zone](../overview/concepts/geo-scope.md).

### Fixes and improvements {#q3-2024-problems-solved}

* Fixed the error that prevented saving cluster audit log files with records larger than 128 KB. Record clipping is now enabled.
* Revised the [cluster roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles)  for the [Cilium](./concepts/network-policy.md#cilium) network policy controller. Now they have only the minimum required permissions.
* Added `subnet-id` field validation when updating a [node group](./concepts/index.md#node-group) using CLI, {{ TF }}, and API. Now, if both the `network-interface` and `locations` parameters are specified in an update request, the `subnet-id` fields under `locations` must either be all empty or fully match the `subnet-id` list under `network-interface` (the `subnet-id` items may be listed in any order). If the `network-interface` array in your request has more than one element, the `subnet-id` fields under `locations` must be empty.

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

In the `rapid`, `regular`, and `stable` release channels, the following updates are available:
* Added support for [ultra high-speed network storages with three replicas (SSD)](../compute/concepts/disk.md#disks-types) for [storage classes](./operations/volumes/manage-storage-class.md) and [persistent volumes](./concepts/volume.md#persistent-volume).
* Node groups can now be used with [GPUs](../compute/concepts/gpus.md) without preinstalled drivers. Now you can use the [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html) application to select an appropriate driver version. For more information, see [{#T}](./tutorials/driverless-gpu.md).
* Removed the CPU resource restriction imposed on [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/) pods to prevent throttling.
* Added support for [placement groups of non-replicable disks](../compute/concepts/disk-placement-group.md) in the {{ k8s }} CSI driver. Placement group parameters are available for [storage classes](./operations/volumes/manage-storage-class.md).
* Fixed the error of ignoring a [log group](../logging/concepts/log-group.md) ID when updating the `master_logging` parameter in a cluster.
* Updated the [Calico](./concepts/network-policy.md#calico) network controller to version [3.25](https://docs.tigera.io/archive/v3.25/release-notes/) for {{ k8s }} versions beginning with 1.24.

### Release 2023-5 {#2023-5}

In the `rapid`, `regular`, and `stable` release channels, the following updates are available:
* Fixed the issue where the Guest Agent on nodes would access a resource outside a cluster.
* Updated the [patch version](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#changelog-since-v1273) for {{ k8s }} version 1.27.
* Added support for {{ k8s }} version 1.26.
