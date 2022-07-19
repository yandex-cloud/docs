# Managing storage classes

_Storage class_ (`StorageClass`) allows administrators to divide the stores they provision into classes with defined parameters.


{{ managed-k8s-short-name }} automatically provides two storage classes, `yc-network-hdd` and `yc-network-ssd`, with the following parameters:

- [Volume Binding Mode](https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode): `WaitForFirstConsumer`.
- [Reclaim Policy](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy): `Delete`.
- The default class is `yc-network-hdd`.

These classes only let you use `PersistentVolumeClaims` and `PersistentVolumes` in [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) `ReadWriteOnce`.

Classes differ based on the [type of disk created](../../../compute/concepts/disk.md#disks_types):

- `yc-network-hdd` uses a standard network drive (`network-hdd`).
- `yc-network-ssd` uses a fast network drive (`network-ssd`).

You can [create your own storage class](#sc-create) as well as [change the default storage class](#sc-default).

{% note info %}

`yc-network-nvme` is deprecated. Use `yc-network-ssd` instead.

{% endnote %}



## Create a storage class {#sc-create}

1. Save the storage class creation specification in the `my-sc-hdd.yaml` YAML file:

   Learn more about [the storage class creation specification format](#sc-spec).

   
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



1. Run the command:

   
   ```bash
   kubectl create -f my-sc-hdd.yaml
   ```



   Result:

   
   ```bash
   storageclass.storage.k8s.io/my-sc-hdd created
   ```



1. Check that the storage class was created:

   ```bash
   kubectl get storageclass
   ```

   Result:

   
   ```bash
   NAME                      PROVISIONER                    AGE
   my-sc-hdd                 disk-csi-driver.mks.ycloud.io  76s
   yc-network-hdd (default)  disk-csi-driver.mks.ycloud.io  16m
   yc-network-ssd            disk-csi-driver.mks.ycloud.io  16m
   ```



### Specification format for creating a storage class {#sc-spec}

Each `StorageClass` object contains the `provisioner`, `parameters`, and `reclaimPolicy` parameters that are used for the dynamic provisioning of `PersistentVolumes`.

Acceptable parameter values:
* `provisioner`: `disk-csi-driver.mks.ycloud.io`.
* `parameters`
  * `type`: `network-hdd` or `network-ssd`.
  * `csi.storage.k8s.io/fstype`: `ext2`, `ext3`, or `ext4`.
* `reclaimPolicy`: `Retain` or `Delete`.

YAML file structure:

```
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: <storage class name> # Used for accessing the storage class.
provisioner: <provisioner name>
volumeBindingMode: WaitForFirstConsumer
parameters: # Storage class parameters.
  type: <disk type>
  csi.storage.k8s.io/fstype: <file system type>
allowVolumeExpansion: false
reclaimPolicy: <reclaim policy>
```


## Change the default storage class {#sc-default}

1. Look up which storage class is assigned by default. `default` is shown next to its name in parentheses.

    ```
    kubectl get storageclass
    NAME                       PROVISIONER                     AGE
    my-sc-hdd                  disk-csi-driver.mks.ycloud.io   76s
    yc-network-hdd (default)   disk-csi-driver.mks.ycloud.io   16m
    yc-network-ssd             disk-csi-driver.mks.ycloud.io   16m
    ```

1. Change the `storageclass.kubernetes.io/is-default-class` parameter of the default storage class to `false`, to remove its status as the default class:

    ```
    kubectl patch storageclass yc-network-hdd \
              -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
    ```

1. Check that `yc-network-hdd` is no longer the default storage class:

    ```
    kubectl get storageclass
    NAME              PROVISIONER                     AGE
    my-sc-hdd         disk-csi-driver.mks.ycloud.io   2m36s
    yc-network-hdd    disk-csi-driver.mks.ycloud.io   17m
    yc-network-ssd    disk-csi-driver.mks.ycloud.io   17m
    ```

1. Specify a new default storage class, such as `my-sc-hdd`:

    ```
    kubectl patch storageclass my-sc-hdd \
              -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    ```

1. Check that `my-sc-hdd` is the default storage class:

    ```
    kubectl get storageclass
    NAME                  PROVISIONER                     AGE
    my-sc-hdd (default)   disk-csi-driver.mks.ycloud.io   4m21s
    yc-network-hdd        disk-csi-driver.mks.ycloud.io   19m
    yc-network-ssd        disk-csi-driver.mks.ycloud.io   19m
    ```
