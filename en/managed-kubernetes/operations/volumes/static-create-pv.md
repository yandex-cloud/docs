# Static volume provisioning

Create a [pod](../../concepts/index.md#pod) with a statically provisioned [volume](../../concepts/volume.md):
1. [Create a PersistentVolume](#create-pv).
1. [Create a PersistentVolumeClaim](#create-claim).
1. [Create a pod](#create-pod).

{% note tip %}

You can use a {{ objstorage-full-name }} [bucket](../../../storage/concepts/bucket.md) as storage for the pod. For more information, see [{#T}](s3-csi-integration.md).

{% endnote %}

## Before you begin {#before-you-begin}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Look up the unique ID of the [disk](../../../compute/concepts/disk.md) to be used to create a `PersistentVolume`:
   1. If you don't have a disk yet, [create one](../../../compute/operations/disk-create/empty.md).

      {% note warning %}

      Make sure the disk is located in the same [availability zone](../../../overview/concepts/geo-scope.md) as the [nodes of the group](../../concepts/index.md#node-group) that the pods will be running on.

      {% endnote %}

   1. Get the disk ID (the `ID` column):

      ```bash
      yc compute disk list
      ```

      Result:

      ```text
      +----------------------+------+------------+-------------------+--------+--------------+-------------+
      |          ID          | NAME |    SIZE    |       ZONE        | STATUS | INSTANCE IDS | DESCRIPTION |
      +----------------------+------+------------+-------------------+--------+--------------+-------------+
      | ef3ouo4sgl86740ridn6 | k8s  | 4294967296 | {{ region-id }}-a | READY  |              |             |
      +----------------------+------+------------+-------------------+--------+--------------+-------------+
      ```

1. Check what [storage classes](manage-storage-class.md) are available and select the appropriate one:

   ```bash
   kubectl get storageclass
   ```

   Result:

   
   ```text
   NAME                          PROVISIONER                    RECLAIMPOLICY  VOLUMEBINDINGMODE     ALLOWVOLUMEEXPANSION  AGE
   yc-network-hdd (default)      disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   yc-network-nvme               disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   yc-network-ssd                disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   yc-network-ssd-nonreplicated  disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   ```



   {% note info %}

   Please note that [{{ k8s }} storage classes](manage-storage-class.md) and [{{ compute-full-name }} disk types](../../../compute/concepts/disk.md#disks_types) are different concepts.

   {% endnote %}

## Create a PersistentVolume object {#create-pv}

1. Save the specification you used to create your `PersistentVolume` to a YAML file named `test-pv.yaml`.

   For more information about the specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

   When setting the `spec.capacity.storage` parameter, make sure you specified the exact size of the disk. {{ CSI }} doesn't validate the disk size for statically prepared volumes.

   To create a `PersistentVolume` from an existing cloud drive, enter its unique disk ID in the `volumeHandle` parameter.

   
   {% note info %}

   If the `storageClassName` parameter is not specified, the default storage class (`yc-network-hdd`) is used. To change the default class, see [{#T}](manage-storage-class.md#sc-default).

   {% endnote %}



   To learn more about the `PersistentVolumeClaim` creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   
   ```yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: <PersistentVolume name>
   spec:
     capacity:
       storage: <PersistentVolume size>
     accessModes:
       - ReadWriteOnce
     csi:
       driver: disk-csi-driver.mks.ycloud.io
       fsType: ext4
       volumeHandle: <disk ID>
     storageClassName: <storage class name>
   ```



1. Run the following command:

   ```bash
   kubectl create -f test-pv.yaml
   ```

   Result:

   ```text
   persistentvolume/<PersistentVolume name> created
   ```

1. View information about the created `PersistentVolume`:

   ```bash
   kubectl describe persistentvolume <PersistentVolume name>
   ```

   Result:

   ```text
   Name:            <PersistentVolume name>
   Labels:          <none>
   Annotations:     <none>
   Finalizers:      [kubernetes.io/pv-protection]
   StorageClass:    <storage class name>
   Status:          Available
   ...
   ```

## Create a PersistentVolumeClaim object {#create-claim}

1. Save the `PersistentVolumeClaim` creation specification to a YAML file named `test-claim.yaml`.

   For more information about the specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: <PersistentVolumeClaim name>
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: <PersistentVolumeClaim size>
     storageClassName: <storage class name>
     volumeName: <PersistentVolume name>
   ```

   {% note info %}

   The size of `PersistentVolumeClaim` must be less than or equal to that of `PersistentVolume`.

   {% endnote %}

   1. Run the following command:

      ```bash
      kubectl create -f test-claim.yaml
      ```

      Result:

      ```text
      persistentvolumeclaim/<PersistentVolumeClaim name> created
      ```

   1. View information about the `PersistentVolumeClaim` created:

      ```bash
      kubectl describe persistentvolumeclaim <PersistentVolumeClaim name>
      ```

      Result:

      ```text
      Name:          <PersistentVolumeClaim name>
      Namespace:     default
      StorageClass:  <storage class name>
      Status:        Bound
      Volume:        <PersistentVolume name>
      ...
      ```

## Create a pod with a statically provisioned volume {#create-pod}

1. Create a file named `test-pod.yaml` with a manifest of a pod that uses `PersistentVolumeClaim`:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: test-pod
   spec:
     containers:
     - name: app
       image: ubuntu
       command: ["/bin/sh"]
       args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
       volumeMounts:
       - name: persistent-storage
         mountPath: /data
     volumes:
     - name: persistent-storage
       persistentVolumeClaim:
         claimName: <PersistentVolumeClaim name>
   ```

   For more information about the specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).
1. Run the following command:

   ```bash
   kubectl create -f test-pod.yaml
   ```

   Result:

   ```text
   pod/test-pod created
   ```

1. View information about the pod created:

   ```bash
   kubectl describe pod test-pod
   ```

   Result:

   ```text
   Name:       test-pod
   Namespace:  default
   Priority:   0
   ...
     ----    ------                  ----  ----                     -------
     Normal  Scheduled               20m   default-scheduler        Successfully assigned default/test-pod to cl1jtehftl7q1umj18ll-icut
     Normal  SuccessfulAttachVolume  20m   attachdetach-controller  AttachVolume.Attach succeeded for volume "<PersistentVolume name>"
   ```

In the **{{ compute-name }}** management console under **Disks**, you will see the word **Active** next to the disk you're using.

## How to delete a volume {#delete-volume}

Disks aren't deleted automatically from {{ compute-name }} when you delete `PersistentVolume`. To delete the volume completely:
1. Delete the `PersistentVolumeClaim` object:

   ```bash
   kubectl delete pvc <PersistentVolumeClaim object ID>
   ```

1. Delete the `PersistentVolume` object:

   ```bash
   kubectl delete pv <PersistentVolume object ID>
   ```

1. [Delete the disk](../../../compute/operations/disk-control/delete.md) in {{ compute-name }} that is linked to the `PersistentVolume` object.