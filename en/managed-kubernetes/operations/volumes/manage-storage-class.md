# Managing storage classes

_Storage class_ (`StorageClass`) allows administrators to divide the stores they provision into classes with defined parameters. Classes vary [by disk type](../../../compute/concepts/disk.md#disks_types) and pricing policy.

{% note alert %}

The cost of using a store depends on its disk type. Please review {{ compute-full-name }} disk prices prior to creating a store.

{% endnote %}

{% if product == "yandex-cloud" %}

{{ managed-k8s-name }} has the following storage classes available:
* `yc-network-hdd` (default): Network HDD storage (`network-hdd`).
* `yc-network-ssd`: Network SSD storage (`network-ssd`).
* `yc-network-ssd-nonreplicated`: Improved-performance non-replicated SSD storage (`network-ssd-nonreplicated`).

{% include [nrd-no-backup-note](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

All storage is created with the following parameters:
* [Volume Binding Mode](https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode): `WaitForFirstConsumer`.
* [Reclaim Policy](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy): `Delete`.

These classes only let you use `PersistentVolumeClaim` and `PersistentVolume` in `ReadWriteOnce` [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).

Classes differ based on the [type of disk created](../../../compute/concepts/disk.md#disks_types):
* `yc-network-hdd` uses a standard network drive (`network-hdd`).
* `yc-network-ssd` uses a fast network drive (`network-ssd`).

You can [create your own storage class](#sc-create) as well as [change the default storage class](#sc-default).

{% note info %}

`yc-network-nvme` is deprecated. Use `yc-network-ssd` instead.

{% endnote %}

{% endif %}

{% if product == "cloud-il" %}

In {{ managed-k8s-name }}, there is a storage class named `yc-network-ssd` with the following properties:
* [Volume Binding Mode](https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode): `WaitForFirstConsumer`.
* [Reclaim Policy](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy): `Delete`.

This class only lets you use `PersistentVolumeClaim` and `PersistentVolume` in `ReadWriteOnce` [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).

`yc-network-ssd` uses a [fast network drive](../../../compute/concepts/disk.md#disks_types) (`network-ssd`).

You can [create your own storage class](#sc-create).

{% endif %}

## Create a storage class {#sc-create}

1. Save the storage class creation specification in the {% if product == "yandex-cloud" %}`my-sc-hdd.yaml`{% endif %}{% if product == "cloud-il" %}`my-sc-ssd.yaml`{% endif %} YAML file:

   Learn more about the [storage class creation specification format](#sc-spec).

   {% if product == "yandex-cloud" %}

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

   {% endif %}

   {% if product == "cloud-il" %}

   ```yaml
   kind: StorageClass
   apiVersion: storage.k8s.io/v1
   metadata:
     name: my-sc-ssd
   provisioner: disk-csi-driver.mks.ycloud.io
   volumeBindingMode: WaitForFirstConsumer
   parameters:
     type: network-ssd
     csi.storage.k8s.io/fstype: ext4
   allowVolumeExpansion: false
   reclaimPolicy: Retain
   ```

   {% endif %}

1. Run the command:

   {% if product == "yandex-cloud" %}

   ```bash
   kubectl create -f my-sc-hdd.yaml
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```bash
   kubectl create -f my-sc-ssd.yaml
   ```

   {% endif %}

   Result:

   {% if product == "yandex-cloud" %}

   ```text
   storageclass.storage.k8s.io/my-sc-hdd created
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```text
   storageclass.storage.k8s.io/my-sc-ssd created
   ```

   {% endif %}

1. Check that the storage class was created:

   ```bash
   kubectl get storageclass
   ```

   Result:

   {% if product == "yandex-cloud" %}

   ```text
   NAME                      PROVISIONER                    AGE
   my-sc-hdd                 disk-csi-driver.mks.ycloud.io  76s
   yc-network-hdd (default)  disk-csi-driver.mks.ycloud.io  16m
   yc-network-ssd            disk-csi-driver.mks.ycloud.io  16m
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```text
   NAME                      PROVISIONER                    AGE
   my-sc-ssd                 disk-csi-driver.mks.ycloud.io  76s
   yc-network-ssd            disk-csi-driver.mks.ycloud.io  16m
   ```

   {% endif %}

### Specification format for creating a storage class {#sc-spec}

Each `StorageClass` object contains `parameters`, `allowVolumeExpansion`, and `reclaimPolicy`, which are used for dynamic `PersistentVolume` object allocation.

YAML file structure:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: <storage class name> # Used for accessing the storage class.
provisioner: <provisioner name>
volumeBindingMode: WaitForFirstConsumer
parameters: # Storage class parameters.
  type: <disk type>
  csi.storage.k8s.io/fstype: <file system type>
allowVolumeExpansion: <activate volume expansion mechanism>
reclaimPolicy: <reclaim policy>
```

Acceptable parameter values:
* `parameters`:
  * `type`: `network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`.
  * `csi.storage.k8s.io/fstype`: `ext2`, `ext3` or `ext4`.
* `reclaimPolicy`: `Retain` or `Delete`.
* `allowVolumeExpansion`: `true` or `false`.

{% if product == "yandex-cloud" %}

## Change the default storage class {#sc-default}

1. Look up which storage class is assigned by default. `default` is shown next to its name in parentheses.

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

1. Change the `storageclass.kubernetes.io/is-default-class` parameter of the default storage class to `false`, to remove its status as the default class:

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

1. Specify a new default storage class, such as `my-sc-hdd`:

   ```bash
   kubectl patch storageclass my-sc-hdd \
     -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```

1. Check that `my-sc-hdd` is the default storage class:

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

{% endif %}