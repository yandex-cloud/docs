---
title: Managing storage classes
description: Follow this guide to manage storage classes.
---

# Managing storage classes


The _storage class_ (`StorageClass`) allows administrators to divide storages they provide into classes with defined parameters. Classes differ by the [disk type](../../../compute/concepts/disk.md#disks_types) and pricing policy.

{% note alert %}

The storage usage cost depends on its [disk](../../../compute/concepts/disk.md) type. Check out the [{{ compute-full-name }} disk prices](../../../compute/concepts/disk.md#disks_types) before creating a storage.

{% endnote %}

{{ managed-k8s-name }} has the following storage classes available that differ by the [disk type](../../../compute/concepts/disk.md#disks_types):
* `yc-network-hdd` (default): Network HDD storage (`network-hdd`).
* `yc-network-ssd`: Network SSD storage (`network-ssd`).
* `yc-network-ssd-nonreplicated`: Enhanced performance non-replicated SSD storage (`network-ssd-nonreplicated`).
* `yc-network-ssd-io-m3`: Enhanced performance network SSD storage (`network-ssd-io-m3`).

{% include [nrd-no-backup-note](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

Each storage is created with the following parameters:
* [Volume Binding Mode](https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode): `WaitForFirstConsumer`.
* [Reclaim Policy](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy): `Delete`.

For these classes, you can only use `PersistentVolumeClaim` and `PersistentVolume` in `ReadWriteOnce` [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).

You can [create your own storage class](#sc-create) as well as [update the default storage class](#sc-default).

{% include [Install kubectl to get started](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

{% note info %}

The `yc-network-nvme` class is deprecated; use `yc-network-ssd` instead.

{% endnote %}


## Create a storage class {#sc-create}

1. Save the storage class creation specification to a YAML file named `my-sc-hdd.yaml`:

   Learn more about the [storage class creation specification format](#sc-spec).

   ```yaml
   kind: StorageClass
   apiVersion: storage.k8s.io/v1
   metadata:
     name: my-sc-hdd
   provisioner: disk-csi-driver.mks.ycloud.io
   volumeBindingMode: WaitForFirstConsumer
   parameters:
     type: network-hdd
     csi.storage.k8s.io/fstype: ext4
   allowVolumeExpansion: false
   reclaimPolicy: Retain
   ```

1. Run this command:

   ```bash
   kubectl create -f my-sc-hdd.yaml
   ```

   Result:

   ```text
   storageclass.storage.k8s.io/my-sc-hdd created
   ```

1. Check that the storage class was created:

   ```bash
   kubectl get storageclass
   ```

   Result:

   ```text
   NAME                      PROVISIONER                    AGE
   my-sc-hdd                 disk-csi-driver.mks.ycloud.io  76s
   yc-network-hdd (default)  disk-csi-driver.mks.ycloud.io  16m
   yc-network-ssd            disk-csi-driver.mks.ycloud.io  16m
   ```

### Format of a storage class creation specification {#sc-spec}

Each `StorageClass` object contains the `parameters`, `allowVolumeExpansion`, and `reclaimPolicy` properties used for dynamic allocation of `PersistentVolume`.

The structure of the YAML file is as follows:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: <storage_class_name> # Used to access a storage class.
provisioner: <provider_name>
volumeBindingMode: WaitForFirstConsumer
parameters: # Storage class parameters.
  type: <disk_type>
  csi.storage.k8s.io/fstype: <file_system_type>
allowVolumeExpansion: <allow_volume_expansion>
reclaimPolicy: <reclaim_policy>
```

The acceptable parameter values include:
* `parameters`:
  * `type`: `network-hdd`, `network-ssd`, `network-ssd-nonreplicated`, or `network-ssd-io-m3`.
  * `csi.storage.k8s.io/fstype`: `ext2`, `ext3`, or `ext4`.
* `reclaimPolicy`: `Retain` or `Delete`.
* `allowVolumeExpansion`: `true` or `false`.


## Update the default storage class {#sc-default}

1. Check which storage class is set as default: next to its name, you will see `default` in a parenthesis.

   ```bash
   kubectl get storageclass
   ```

   Result:

   ```text
   NAME                      PROVISIONER                    AGE
   my-sc-hdd                 disk-csi-driver.mks.ycloud.io  76s
   yc-network-hdd (default)  disk-csi-driver.mks.ycloud.io  16m
   yc-network-ssd            disk-csi-driver.mks.ycloud.io  16m
   ```

1. Change the `storageclass.kubernetes.io/is-default-class` parameter of the default storage class to `false` to remove its default class status:

   ```bash
   kubectl patch storageclass yc-network-hdd \
     -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
   ```

1. Check that `yc-network-hdd` is no longer the default storage class:

   ```bash
   kubectl get storageclass
   ```

   Result:

   ```text
   NAME            PROVISIONER                    AGE
   my-sc-hdd       disk-csi-driver.mks.ycloud.io  2m36s
   yc-network-hdd  disk-csi-driver.mks.ycloud.io  17m
   yc-network-ssd  disk-csi-driver.mks.ycloud.io  17m
   ```

1. Specify a new default storage class, e.g., `my-sc-hdd`:

   ```bash
   kubectl patch storageclass my-sc-hdd \
     -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```

1. Check that `my-sc-hdd` is the default storage class now:

   ```bash
   kubectl get storageclass
   ```

   Result:

   ```text
   NAME                 PROVISIONER                    AGE
   my-sc-hdd (default)  disk-csi-driver.mks.ycloud.io  4m21s
   yc-network-hdd       disk-csi-driver.mks.ycloud.io  19m
   yc-network-ssd       disk-csi-driver.mks.ycloud.io  19m
   ```

### See also {#see-also}

* [{#T}](../../concepts/volume.md)
* [{#T}](./encrypted-disks.md)
* [{#T}](./dynamic-create-pv.md)
* [{#T}](./static-create-pv.md)