# Volumes

You can store app data in the containers where the apps are running, but this may cause some problems:

- When a container crashes, `kubelet` restarts it, but files are lost because the container starts clean.
- Other containers running in the same pod can't access data in the container.

We can solve these problems using {{ k8s }} volumes.

To handle volumes, {{ k8s }} operates with the following [{{ k8s }} API](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/) objects: `Volume`, `PersistentVolume`, `PersistentVolumeClaim`, and `StorageClass`.

## Volumes {#volume}

_Volumes_ are stores shared by objects from different containers deployed in one or more pods. In the pod specification, users set the volumes to be included in the pod and the path that containers should mount them to.

Volumes are classified by their life cycle:

- Temporary (`Volume`) volumes have the same lifetime as the pods that contain them. These volumes are created along with the pod and saved when the container is restarted. When the pod is stopped or deleted, its volumes are destroyed.
- Persistent volumes (`PersistentVolume`) have their own life cycle. The data in these volumes is preserved when the pod is deleted. The volume can be unmounted to move the data to another pod or node, for example.

There are different kinds of temporary and persistent volumes, depending on the storage. Read about the [volume types](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes) that {{ k8s }} supports.

## Working with persistent volumes {#persistentvolume}

You can work with {{ k8s }} persistent volumes by using the `PersistentVolume` and `PersistentVolumeClaim` API objects.

- `PersistentVolumes` (PV) are {{ k8s }} cluster resources that exist independently of pods. This means that the disk and data provided in the PV continue to exist when you change the cluster and delete or re-create the pods.

    `PersistentVolume` resources can be created by the {{ k8s }} cluster administrator or dynamically provisioned using `PersistentVolumeClaims`.

- `PersistentVolumeClaims` (PVC) are used to specify the `PersistentVolumes` in the pod specification, since you can't specify `PersistentVolumes` directly.

    `PersistentVolumeClaims` request a specific size, access mode, and storage class for the `PersistentVolume`. If the `PersistentVolume` that satisfies the request exists or can be provisioned, the `PersistentVolumeClaim` is linked to the necessary `PersistentVolume`. The {{ k8s }} cluster mounts the `PersistentVolumeClaim` as a volume for the pod.

Users often need `PersistentVolumes` with different properties. {{ k8s }} cluster administrators can provide various `PersistentVolumes` by using [storage classes](../operations/volumes/manage-storage-class.md).

## Provisioning volumes

In {{ managed-k8s-short-name }}, you can use `PersistentVolumes` built on [disks](../../compute/concepts/disk.md) in {{ compute-name }}. You can set the disk type and other parameters using applicable [storage classes](../operations/volumes/manage-storage-class.md).

{% note alert %}

{{ compute-name }} disks are created in a specific [availability zone](../../overview/concepts/geo-scope.md). This affects where pods can be restarted.

{% endnote %}

When you delete a {{ k8s }} cluster, `PersistentVolumeClaims` and {{ compute-name }} disks for dynamically and statically created `PersistentVolumes` **aren't deleted** automatically.

### Dynamic volume provisioning {#dynamic-provisioning}

In most cases, you don't need to create `PersistentVolumes` or {{ compute-name }} disks manually. Instead, you can create your `PersistentVolumeClaims`, and {{ k8s }} will automatically provision the relevant `PersistentVolume` object and create a disk.

To learn how to dynamically provision a volume, see [{#T}](../operations/volumes/dynamic-create-pv.md).

### Static volume provisioning
 {#static-provisioning}

In addition to creating new disks for provisioning `PersistentVolumes`, you can use existing Yandex.Cloud disks.

To learn more about static volume provisioning using cloud disks, see [{#T}](../operations/volumes/static-create-pv.md).

## Deleting volumes

Depending on the `PersistentVolume` and `PersistentVolumeClaim` settings, volumes and disks can be deleted automatically or manually.

- For dynamically provisioned volumes: after removing a `PersistentVolumeClaim` built on the `yc-network-hdd` or `yc-network-nvme` storage classes, the applicable `PersistentVolume` and Compute Cloud disk **are deleted**.

- For statically provisioned volumes: you can specify whether to delete the {{ compute-name }} disk when deleting the `PersistentVolumeClaim`. Тo do this, use the `persistentVolumeReclaimPolicy` parameter in the [PersistentVolumeSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#persistentvolumespec-v1-core). By default, the `Retain` value is used for statically provisioned pods and the {{ compute-name }} disk is **not deleted**.

Learn more about volumes in the {{ k8s }} [documentation](https://kubernetes.io/docs/concepts/storage/volumes/).

