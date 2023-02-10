# Volumes

You can store app data in the containers where the apps are running, but this may cause some problems:
* When a container crashes, `kubelet` restarts it, but files are lost because the container starts clean.
* Other containers running in the same pod can't access data in the container.

We can solve these problems using {{ k8s }} _volumes_.

_Volumes_ are stores shared by objects from different containers deployed in one or more pods. In the pod specification, users set the volumes to be included in the pod and the path that containers should mount them to.

To handle volumes {{ k8s }} operates with the following [{{ k8s }} API](https://kubernetes.io/docs/reference/kubernetes-api/): `Volume`, `PersistentVolume`, `PersistentVolumeClaim`, and `StorageClass`.

Volumes are classified by their life cycle:
* Temporary (`Volume`) volumes have the same lifetime as the pods that contain them. These volumes are created along with the pod and saved when the container is restarted. When the pod is stopped or deleted, its volumes are destroyed.
* Persistent volumes (`PersistentVolume`) have their own life cycle. The data in these volumes is preserved when the pod is deleted. The volume can be unmounted to move the data to another pod or node, for example.

There are different kinds of temporary and persistent volumes, depending on the storage. Read about the [volume types](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes) that {{ k8s }} supports.

## Working with persistent volumes {#persistent-volume}

You can work with {{ k8s }} persistent volumes by using the `PersistentVolume` and `PersistentVolumeClaim` API objects.
* `PersistentVolumes` (PV) are {{ k8s }} cluster resources that exist independently of pods. This means that the disk and data provided in the PV continue to exist when you change the cluster and delete or re-create the pods.

  `PersistentVolume` resources can be created by the {{ k8s }} cluster administrator or dynamically provisioned using `PersistentVolumeClaims`.

* `PersistentVolumeClaim` (PVC) are used to specify the `PersistentVolumes` in the pod specification, since you can't specify `PersistentVolumes` directly.

  `PersistentVolumeClaim` objects request a specific size, access mode, and storage class for the `PersistentVolume` object. If the `PersistentVolume` that satisfies the request exists or can be provisioned, the `PersistentVolumeClaim` is linked to the necessary `PersistentVolume`. The {{ k8s }} cluster mounts the `PersistentVolumeClaim` as a volume for the pod.

Users often need `PersistentVolumes` with different properties. {{ k8s }} cluster administrators can provide various `PersistentVolumes` by using [storage classes](../operations/volumes/manage-storage-class.md).

{% note alert %}

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

## Modes for mounting persistent volumes {#volume-mode}

{{ k8s }} supports two `volumeModes` for mounting `PersistentVolumes`: `Filesystem` (with a filesystem) and `Block` (without a filesystem).

If the `volumeMode` parameter is omitted, `Filesystem` is the default mode used.

### A volume with a filesystem {#filesystem}

If you specify `volumeMode: Filesystem` in a `PersistentVolumeClaim`, {{ k8s }} creates a filesystem on a block device before mounting it to a pod for the first time.

To learn how to provision a volume pod in `volumeMode: Filesystem`, see [{#T}](../operations/volumes/dynamic-create-pv.md).

### A volume without a filesystem {#block}

You can set `volumeMode: Block` to mount a volume as block storage without creating a filesystem on it. The application running in the pod with this volume must know how to handle a storage device without a file system.

To learn how to provision a volume pod in `volumeMode: Block`, see [{#T}](../operations/volumes/mode-block.md).

## Provisioning volumes {#provisioning-volumes}

In {{ managed-k8s-name }}, you can use `PersistentVolumes` built on [disks](../../compute/concepts/disk.md) in {{ compute-full-name }}. You can set the disk type and other parameters using applicable [storage classes](../operations/volumes/manage-storage-class.md).

{% note alert %}

{{ compute-name }} disks are created in a specific [availability zone](../../overview/concepts/geo-scope.md). This affects where pods can be restarted.

{% endnote %}

### Dynamic volume provisioning {#dynamic-provisioning}

In most cases, you don't need to create `PersistentVolumes` or {{ compute-name }} disks manually. Instead, you can create your `PersistentVolumeClaims`, and {{ k8s }} will automatically provision the relevant `PersistentVolume` object and create a disk.

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
* For dynamically provisioned volumes: after removing a `PersistentVolumeClaim` built on the {% if product == "yandex-cloud" %}`yc-network-hdd` or {% endif %}`yc-network-ssd` storage {% if product == "yandex-cloud" %}classes{% endif %}{% if product == "cloud-il" %}class{% endif %}, the applicable `PersistentVolume` and {{ compute-name }} disk **are deleted**.
* For statically provisioned volumes: you can specify whether to delete the {{ compute-name }} disk when deleting the `PersistentVolumeClaim`. To do this, use the `persistentVolumeReclaimPolicy` in [PersistentVolumeSpec](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/#PersistentVolumeSpec). By default, the `Retain` value is used for statically provisioned pods and the {{ compute-name }} disk is **not deleted**.

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

Learn more about volumes in the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).