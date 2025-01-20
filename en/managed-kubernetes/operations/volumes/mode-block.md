---
title: Mounting a volume in block mode
description: Follow this tutorial to mount a volume in block mode.
---

# Mounting a volume in block mode


To mount a [volume](../../concepts/volume.md#block) in `volumeMode: Block` mode:
1. [Create a PersistentVolumeClaim](#create-pvc).
1. [Create a pod with the mounted volume](#create-pod).

{% include [Install kubectl to get started](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

## Create a PersistentVolumeClaim object {#create-pvc}

1. To create a volume in block mode, set the `spec.volumeMode` field value to `Block`.

   Save the following [`PersistentVolumeClaim`](dynamic-create-pv.md) creation specification to a YAML file named `pvc-block.yaml`.


   {% note info %}

   If the `storageClassName` parameter is not specified, the default storage class (`yc-network-hdd`) is used. To change the default class, see [{#T}](manage-storage-class.md#sc-default).

   {% endnote %}



   To learn more about the `PersistentVolumeClaim` creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).


   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-block
   spec:
     accessModes:
       - ReadWriteOnce
     volumeMode: Block
     storageClassName: "yc-network-hdd"
     resources:
       requests:
         storage: 1Gi
   ```



1. Create the `PersistentVolumeClaim` object:

   ```bash
   kubectl create -f pvc-block.yaml
   ```

   Result:

   ```bash
   persistentvolumeclaim/pvc-block created
   ```

## Create a pod with the mounted volume {#create-pod}

1. When creating a volume pod in block mode, specify the `spec.containers.volumeDevices` field.

   Save the following pod creation specification to a YAML file named `pod.yaml`.

   To learn more about the pod creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#pod-v1-core).

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod
   spec:
     containers:
     - name: app
       image: ubuntu
       command: ["/bin/sh"]
       args: ["-xc", "/bin/dd if=/dev/block of=/dev/null bs=1K count=10; /bin/sleep 3600"]
       volumeDevices:
       - devicePath: /dev/block
         name: persistent-storage
     volumes:
     - name: persistent-storage
       persistentVolumeClaim:
         claimName: pvc-block
   ```

1. Run this command:

   ```bash
   kubectl create -f pod.yaml
   ```

   Result:

   ```bash
   pod/pod created
   ```