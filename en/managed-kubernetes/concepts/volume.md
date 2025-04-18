---
title: Volume in {{ managed-k8s-full-name }}
description: A volume is a storage for shared use of objects in different containers deployed within one or more pods. In the pod specification, users specify the volumes to contain the pod and the path for the containers to mount those volumes to.
---

# Volume

You can store container application data in the containers themselves but this may cause some issues:
* When a container crashes, `kubelet` restarts it, but the files are lost because the container starts clean.
* The data in the container cannot be accessed by other containers running in the same [pod](index.md#pod).

We can solve these problems using {{ k8s }} _volumes_.

A _volume_ is a storage for shared use of objects in different containers deployed within one or more pods. In the pod specification, users specify the volumes to contain the pod and the path for the containers to mount those volumes to.

To process volumes, {{ k8s }} uses the following [{{ k8s }} API](https://kubernetes.io/docs/reference/kubernetes-api/) objects: `Volume`, `PersistentVolume`, `PersistentVolumeClaim`, and `StorageClass`.

Volumes are classified according to their lifecycle:
* Temporary (`Volume`) volumes have the same lifetime as the pods that contain them. These volumes are created along with the pod and saved when the container is restarted. When the pod is stopped or deleted, its volumes are destroyed.
* Persistent volumes (`PersistentVolume`) have a lifecycle of their own. The data in these volumes is preserved when the pod is deleted. You can unmount a volume, for example, to move data to another pod or [{{ managed-k8s-name }}](index.md#node-group) node.

There are different kinds of temporary and persistent volumes, depending on the storage. Check out the [volume types](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes) that {{ k8s }} supports.

## Working with persistent volumes {#persistent-volume}


You operate {{ k8s }} persistent volumes with the help of the `PersistentVolume` and `PersistentVolumeClaim` API objects.
* `PersistentVolumes` (PV) are [{{ managed-k8s-name }}](index.md#kubernetes-cluster) cluster resources that exist independently of pods. This means that the [disk](../../compute/concepts/disk.md) and data provided in the PV continue to exist when you change the {{ managed-k8s-name }} cluster and delete or recreate the pods.

  The resources of `PersistentVolume` can be dynamically provisioned with the help of `PersistentVolumeClaims` or created beforehand by the {{ managed-k8s-name }} cluster administrator.
* The `PersistentVolumeClaim` (PVC) objects are used to specify `PersistentVolumes` in the pod specification because `PersistentVolumes` cannot be specified directly.

  The `PersistentVolumeClaim` objects request a specific size, access mode, and storage class for the `PersistentVolume` object. If a `PersistentVolume` object that satisfies the request either exists or can be provisioned, `PersistentVolumeClaim` is linked to the relevant `PersistentVolume`. The {{ managed-k8s-name }} cluster mounts the `PersistentVolumeClaim` object as a volume for the pod.

Users often need `PersistentVolumes` with various properties. The {{ managed-k8s-name }} cluster administrators can supply various `PersistentVolumes` thanks to [storage classes](../operations/volumes/manage-storage-class.md).

{% note alert %}

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

## Persistent volume mounting modes {#volume-mode}

{{ managed-k8s-name }} supports two persistent volume (`PersistentVolume`) mounting modes (`volumeMode`): with a filesystem (`Filesystem`) and without a filesystem (`Block`).

If `volumeMode` is not set, the default value is `Filesystem`.

### Volume with a filesystem {#filesystem}

You can specify `volumeMode: Filesystem` in `PersistentVolumeClaim`, in which case {{ managed-k8s-name }} will create a file system on the block storage before mounting it to a pod for the first time.

To learn how to provision a volume pod in `volumeMode: Filesystem`, see [{#T}](../operations/volumes/dynamic-create-pv.md).

### Volume without a filesystem {#block}

You can set `volumeMode: Block` to mount a volume as block storage without creating a file system. The application running in the pod with this volume must know how to handle a storage device without a file system.

To learn how to provision a volume pod in `volumeMode: Block`, see [{#T}](../operations/volumes/mode-block.md).

## Provisioning volumes {#provisioning-volumes}

In {{ managed-k8s-name }}, you can use `PersistentVolumes` based on {{ compute-full-name }} disks. You can set the disk type and other parameters using applicable [storage classes](../operations/volumes/manage-storage-class.md).

The following [disk types](../../compute/concepts/disk.md##disks-types) are available in {{ managed-k8s-name }}:
* Network SSD (`network-ssd`): Fast network drive; SSD network block storage.
* Network HDD (`network-hdd`): Standard network drive; HDD network block storage.
* Non-replicated SSD (`network-ssd-nonreplicated`): Enhanced performance network drive without redundancy.
* Ultra high-speed network storage with three replicas (SSD) (`network-ssd-io-m3`): High-performance SSD offering the same speed as `network-ssd-nonreplicated`, plus redundancy.

{% note alert %}

{{ compute-name }} disks are created in a specific [availability zone](../../overview/concepts/geo-scope.md). This affects where pods can be restarted.

{% endnote %}

### Dynamic volume provisioning {#dynamic-provisioning}

In most cases, you do not need to create `PersistentVolumes` and {{ compute-name }} disks manually. Instead, you can create your `PersistentVolumeClaim` objects, and {{ managed-k8s-name }} will automatically provision the relevant `PersistentVolume` object and create a disk.

To learn how to dynamically provision a volume, see [{#T}](../operations/volumes/dynamic-create-pv.md).

### Static volume provisioning {#static-provisioning}

In addition to creating new disks to provision `PersistentVolumes`, you can also use existing {{ yandex-cloud }} disks.

To learn more about static volume provisioning using cloud disks, see [{#T}](../operations/volumes/static-create-pv.md).

## Expanding volumes {#volume-expansion}

You can expand a {{ k8s }} volume after creating it. You can only resize a volume when the pod with this volume is no longer running.

To expand a volume:
1. Make sure the `StorageClass` description contains `allowVolumeExpansion: true`.
1. Delete the pod with the volume to be resized.
1. Edit the `PersistentVolumeClaim` object to request more space.
1. Wait for the volume to expand.
1. Create a pod to mount the volume to.

To learn how to expand a volume, see [{#T}](../operations/volumes/volume-expansion.md).

## Deleting volumes {#deleting-volumes}

Depending on the `PersistentVolume` and `PersistentVolumeClaim` settings, volumes and disks can be deleted automatically or manually.
* For dynamically provisioned volumes, after removing the `PersistentVolumeClaim` object based on `yc-network-hdd` or `yc-network-ssd`, the relevant `PersistentVolume` object and {{ compute-name }} disk **will be deleted**.
* For statically provisioned volumes, the [PersistentVolumeSpec](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/#PersistentVolumeSpec) specification always uses `persistentVolumeReclaimPolicy: Retain`, and the {{ compute-name }} disk **is not deleted** when deleting `PersistentVolumeClaim`. If the `Delete` parameter value is set manually, the disk will not be deleted.

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

Learn more about volumes in the relevant [{{ k8s }} guides](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).

## Use cases {#examples}

* [{#T}](../tutorials/kubernetes-backup.md)
