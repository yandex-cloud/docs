---
title: "Volumes in {{ managed-k8s-full-name }}"
description: "Volumes are stores that enable shared access to objects from different containers deployed in one or more pods. In the pod specification, users specify the volumes to contain the pod and the path for the containers to mount those volumes to."
---

# Volumes

You can store application data in the containers where the applications are running, but this may cause issues:
* When a container crashes, `kubelet` restarts it, but files are lost because the container starts clean.
* Other containers running in the same [pod](index.md#pod) cannot access data in the container.

We can solve these problems using {{ k8s }} _volumes_.

A _volume_ is a storage for shared use of objects in different containers deployed within one or more pods. In the pod specification, users specify the volumes to contain the pod and the path for the containers to mount those volumes to.

To handle volumes {{ k8s }} operates with the following [{{ k8s }} API](https://kubernetes.io/docs/reference/kubernetes-api/) objects: `Volume`, `PersistentVolume`, `PersistentVolumeClaim`, and `StorageClass`.

Volumes are classified by their life cycle:
* Temporary (`Volume`) volumes have the same lifetime as the pods that contain them. These volumes are created along with the pod and saved when the container is restarted. When the pod is stopped or deleted, its volumes are destroyed.
* Persistent volumes (`PersistentVolume`) have their own life cycle. The data in these volumes is preserved when the pod is deleted. You can unmount a volume, for example, to move data to another pod or [{{ managed-k8s-name }} node](index.md#node-group).

There are different kinds of temporary and persistent volumes, depending on the storage. Check out the [volume types](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes) that {{ k8s }} supports.

## Working with persistent volumes {#persistent-volume}


You can work with {{ k8s }} persistent volumes by using the `PersistentVolume` and `PersistentVolumeClaim` API objects.
* `PersistentVolumes` (PV) are [{{ managed-k8s-name }} cluster](index.md#kubernetes-cluster) resources that exist independently of pods. This means that the [disk](../../compute/concepts/disk.md) and data provided in the PV continue to exist when you change the {{ managed-k8s-name }} cluster and delete or recreate the pods.

  `PersistentVolume` resources can be created by the cluster {{ managed-k8s-name }} administrator or dynamically provisioned using `PersistentVolumeClaims`.
* `PersistentVolumeClaims` (PVC) are used to specify the `PersistentVolumes` in the pod specification, since you cannot specify `PersistentVolumes` directly.

  `PersistentVolumeClaim` objects request a specific size, access mode, and storage class for the `PersistentVolume` object. If the `PersistentVolume` that satisfies the request exists or can be provisioned, the `PersistentVolumeClaim` is linked to the required `PersistentVolume`. The {{ managed-k8s-name }} cluster mounts the `PersistentVolumeClaim` as a volume for the pod.

Users often need `PersistentVolumes` with different properties. {{ managed-k8s-name }} cluster administrators can provide various `PersistentVolumes` by using [storage classes](../operations/volumes/manage-storage-class.md).

{% note alert %}

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

## Modes for mounting persistent volumes {#volume-mode}

{{ managed-k8s-name }} supports two `volumeModes` for mounting `PersistentVolumes`: `Filesystem` (with a filesystem) and `Block` (without a filesystem).

If the `volumeMode` parameter is omitted, `Filesystem` is the default mode used.

### A volume with a filesystem {#filesystem}

If you specify `volumeMode: Filesystem` in a `PersistentVolumeClaim`, {{ managed-k8s-name }} creates a filesystem on a block device before mounting it to a pod for the first time.

To learn how to provision a volume pod in `volumeMode: Filesystem`, see [{#T}](../operations/volumes/dynamic-create-pv.md).

### A volume without a filesystem {#block}

You can set `volumeMode: Block` to mount a volume as block storage without creating a filesystem on it. The application running in the pod with this volume must know how to handle a storage device without a file system.

To learn how to provision a volume pod in `volumeMode: Block`, see [{#T}](../operations/volumes/mode-block.md).

## Provisioning volumes {#provisioning-volumes}

In {{ managed-k8s-name }}, you can use `PersistentVolumes` based on {{ compute-full-name }} disks. You can set the disk type and other parameters using applicable [storage classes](../operations/volumes/manage-storage-class.md).

The following [disk types](../../compute/concepts/disk.md##disks-types) are available in {{ managed-k8s-name }}:
* Network SSD (`network-ssd`): Fast network drive, which is an SSD based network block storage.
* Network HDD (`network-hdd`): Standard network drive, which is an HDD based network block storage.
* Non-replicated SSD (`network-ssd-nonreplicated`): Network drive with enhanced performance without redundancy.
* High-performance SSD (`network-ssd-io-m3`): Network drive with the same performance characteristics as `network-ssd-nonreplicated`, plus redundancy.

{% note alert %}

{{ compute-name }} disks are created in a specific [availability zone](../../overview/concepts/geo-scope.md). This affects where pods can be restarted.

{% endnote %}

### Dynamic volume provisioning {#dynamic-provisioning}

In most cases, you do not need to create `PersistentVolumes` or {{ compute-name }} disks manually. Instead, you can create your `PersistentVolumeClaims`, and {{ managed-k8s-name }} will automatically provision the relevant `PersistentVolume` object and create a disk.

To learn how to dynamically provision a volume, see [{#T}](../operations/volumes/dynamic-create-pv.md).

### Static volume provisioning {#static-provisioning}

In addition to creating new disks for provisioning `PersistentVolumes`, you can use existing {{ yandex-cloud }} disks.

To learn more about static volume provisioning using cloud disks, see [{#T}](../operations/volumes/static-create-pv.md).

## Expanding volumes {#volume-expansion}

You can expand a {{ k8s }} volume after creating it. You can only resize a volume when the pod with this volume is no longer running.

To expand a volume:
1. Make sure the `StorageClass` description contains `allowVolumeExpansion: true`.
1. Delete the pod with the volume to be resized.
1. Edit the `PersistentVolumeClaim` to request more space.
1. Wait for the volume to expand.
1. Create a pod to mount the volume to.

To learn how to expand a volume, see [{#T}](../operations/volumes/volume-expansion.md).

## Deleting volumes {#deleting-volumes}

Depending on the `PersistentVolume` and `PersistentVolumeClaim` settings, volumes and disks can be deleted automatically or manually.
* For dynamically provisioned volumes, after removing a `PersistentVolumeClaim` based on the `yc-network-hdd` or `yc-network-ssd` storage classes, the applicable `PersistentVolume` and Compute Cloud disk {{ compute-name }} **are deleted**.
* For statically provisioned volumes, the [PersistentVolumeSpec](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/#PersistentVolumeSpec) specification always uses the `persistentVolumeReclaimPolicy: Retain` parameter value and the {{ compute-name }} disk is **not deleted** when deleting the `PersistentVolumeClaim`. If the `Delete` parameter value is set manually, the disk will not be deleted.

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

Learn more about volumes in the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).
