### Kubernetes backup is configured {#backup}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | k8s.backup ||
|#

#### Description

{% note warning "**Manual check**" %}

This rule requires manual verification of Kubernetes backup configuration.

{% endnote %}

To ensure continuous operation and data protection, we recommend using backups in Managed Service for Kubernetes. With backups, you can quickly recover the service without experiencing any data or time loss in the wake of a malfunction or accident. The Yandex Cloud infrastructure provides secure storage and replication for data in [Kubernetes](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#kubernetes-cluster) clusters. However, you can back up data from Kubernetes cluster [node groups](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#node-group) at any time and store them in Yandex [Object Storage](https://yandex.cloud/en/docs/storage/) or other types of storage.

#### Guides and solutions

* You can create backups of Kubernetes cluster node group data using [Velero](https://velero.io/). It supports Yandex Cloud [disks](https://yandex.cloud/en/docs/compute/concepts/disk) through the Kubernetes CSI driver and helps create disk and volume [snapshots](https://yandex.cloud/en/docs/compute/concepts/snapshot).
* If installed manually, Velero allows you to use [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [local](https://kubernetes.io/docs/concepts/storage/volumes/#local), or any other volume type without built-in support for snapshots. To use one of these volume types, install Velero with the restic [plugin](https://velero.io/docs/v1.8/restic/). Velero installed from [Cloud Marketplace](https://yandex.cloud/en/marketplace/products/yc/velero-yc-csi) does not include the restic plugin.
* Guide on Kubernetes cluster backup in Object Storage: <https://yandex.cloud/en/docs/managed-kubernetes/tutorials/kubernetes-backup#backup>
