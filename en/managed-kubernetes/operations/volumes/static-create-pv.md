---
title: How to create a pod with a statically provisioned volume in {{ managed-k8s-full-name }}
description: Follow this guide to create a pod with a statically provisioned volume.
---

# Static volume provisioning


Create a [pod](../../concepts/index.md#pod) with a statically provisioned [volume](../../concepts/volume.md):
1. [Create a PersistentVolume](#create-pv).
1. [Create a PersistentVolumeClaim](#create-claim).
1. [Create a pod](#create-pod).

{% note tip %}

You can use a {{ objstorage-full-name }} [bucket](../../../storage/concepts/bucket.md) as storage for your pod. For more information, see [{#T}](s3-csi-integration.md).

{% endnote %}

## Getting started {#before-you-begin}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Find out the unique ID of the [disk](../../../compute/concepts/disk.md) you are going to use to create a `PersistentVolume`:
   1. If you do not have a disk yet, [create one](../../../compute/operations/disk-create/empty.md).

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
      | ef3ouo4sgl86******** | k8s  | 4294967296 | {{ region-id }}-a     | READY  |              |             |
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

1. Save the `PersistentVolume` creation specification to a YAML file named `test-pv.yaml`.

   For more information about the specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

   When providing the `spec.capacity.storage` parameter, make sure the exact disk size is specified. {{ CSI }} does not verify disk size for statically provisioned volumes.

   To create a `PersistentVolume` from an existing cloud drive, enter its unique disk ID in the `volumeHandle` parameter.


   {% note info %}

   If the `storageClassName` parameter is not specified, the default storage class (`yc-network-hdd`) is used. To change the default class, see [{#T}](manage-storage-class.md#sc-default).

   {% endnote %}



   To learn more about the `PersistentVolumeClaim` creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).


   ```yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: <PersistentVolume_name>
   spec:
     capacity:
       storage: <PersistentVolume_size>
     accessModes:
       - ReadWriteOnce
     csi:
       driver: disk-csi-driver.mks.ycloud.io
       fsType: ext4
       volumeHandle: <disk_ID>
     storageClassName: <storage_class_name>
   ```



1. Run this command:

   ```bash
   kubectl create -f test-pv.yaml
   ```

   Result:

   ```text
   persistentvolume/<PersistentVolume_name> created
   ```

1. View the information about the new `PersistentVolume` object:

   ```bash
   kubectl describe persistentvolume <PersistentVolume_name>
   ```

   Result:

   ```text
   Name:            <PersistentVolume_name>
   Labels:          <none>
   Annotations:     <none>
   Finalizers:      [kubernetes.io/pv-protection]
   StorageClass:    <storage_class_name>
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
     name: <PersistentVolumeClaim_name>
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: <PersistentVolumeClaim_size>
     storageClassName: <storage_class_name>
     volumeName: <PersistentVolume_name>
   ```

   {% note info %}

   The size of `PersistentVolumeClaim` must be less than or equal to that of `PersistentVolume`.

   {% endnote %}

1. Run this command:

   ```bash
   kubectl create -f test-claim.yaml
   ```

   Result:

   ```text
   persistentvolumeclaim/<PersistentVolumeClaim_name> created
   ```

1. View the information about the new `PersistentVolumeClaim`:

   ```bash
   kubectl describe persistentvolumeclaim <PersistentVolumeClaim_name>
   ```

   Result:

   ```text
   Name:          <PersistentVolumeClaim_name>
   Namespace:     default
   StorageClass:  <storage_class_name>
   Status:        Bound
   Volume:        <PersistentVolume_name>
   ...
   ```

## Create a pod with a statically provisioned volume {#create-pod}

1. Create a file named `test-pod.yaml` with a manifest for the pod using `PersistentVolumeClaim`:

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
         claimName: <PersistentVolumeClaim_name>
   ```

   For more information about the specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).
1. Run this command:

   ```bash
   kubectl create -f test-pod.yaml
   ```

   Result:

   ```text
   pod/test-pod created
   ```

1. View the information about the new pod:

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
     Normal  Scheduled               20m   default-scheduler        Successfully assigned default/test-pod to cl1jtehftl7q********-icut
     Normal  SuccessfulAttachVolume  20m   attachdetach-controller  AttachVolume.Attach succeeded for volume "<PersistentVolume_name>"
   ```

In the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** management console under **{{ ui-key.yacloud.compute.switch_disks }}**, the word **{{ ui-key.yacloud.compute.disks.label_disk-used }}** will appear next to your disk.

## How to delete a volume {#delete-volume}

Disks are not deleted automatically from {{ compute-name }} when you delete `PersistentVolume`. To delete the volume completely:
1. Delete the `PersistentVolumeClaim` object:

   ```bash
   kubectl delete pvc <PersistentVolumeClaim_object_ID>
   ```

1. Delete the `PersistentVolume` object:

   ```bash
   kubectl delete pv <PersistentVolume_object_ID>
   ```

1. In {{ compute-name }}, [delete the disk](../../../compute/operations/disk-control/delete.md)  linked to the `PersistentVolume` object.
