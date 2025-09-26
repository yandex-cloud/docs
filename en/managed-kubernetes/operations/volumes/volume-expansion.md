---
title: Expanding a pod volume
description: Follow this guide to expand a pod volume.
---

# Expanding a pod volume


To expand a [volume](../../concepts/volume.md):
1. [Enable volume expansion](#enabling-expansion).
1. [Create a PersistentVolumeClaim](#create-pvc).
1. [Create a pod with a dynamically provisioned volume](#create-pod).
1. [Request volume expansion](#volume-expansion).
1. [Check the pod with the volume](#checking-pod).

{% include [Install kubectl to get started](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

## Enable volume expansion {#enabling-expansion}

To enable the volume expansion feature, make sure the [storage class](manage-storage-class.md) (`StorageClass`) description contains the `allowVolumeExpansion: true` parameter. In {{ managed-k8s-name }} storage, this feature is enabled by default:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: yc-network-hdd
provisioner: disk-csi-driver.mks.ycloud.io
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: network-hdd
  csi.storage.k8s.io/fstype: ext4
allowVolumeExpansion: true
reclaimPolicy: Delete
```

## Create a PersistentVolumeClaim object {#create-pvc}

1. Save the following [PersistentVolumeClaim creation](dynamic-create-pv.md) specification to a YAML file named `pvc-expansion.yaml`.

   To learn more about the `PersistentVolumeClaim` creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-expansion
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: yc-network-hdd
     resources:
       requests:
         storage: 1Gi
   ```

1. Create the `PersistentVolumeClaim` object:

   ```bash
   kubectl create -f pvc-expansion.yaml
   ```

   Result:

   ```bash
   persistentvolumeclaim/pvc-expansion created
   ```

## Create a pod with a dynamically provisioned volume {#create-pod}

1. Save the following [pod](../../concepts/index.md#pod) creation specification to a YAML file named `pod.yaml`.

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
       args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
       volumeMounts:
       - name: persistent-storage
         mountPath: /data
     volumes:
     - name: persistent-storage
       persistentVolumeClaim:
         claimName: pvc-expansion
   ```

1. Create a pod:

   ```bash
   kubectl create -f pod.yaml
   ```

   Result:

   ```bash
   pod/pod created
   ```

## Request volume expansion {#volume-expansion}

1. Edit the `spec.resources.requests.storage` field of the `PersistentVolumeClaim` object:

   ```bash
   kubectl patch pvc pvc-expansion -p '{"spec":{"resources":{"requests":{"storage":"2Gi"}}}}'
   ```

1. Wait a few minutes for the volume to expand. Check the change results:

   ```bash
   kubectl get pvc pvc-expansion -o yaml
   ```

   The `status.capacity.storage` field shows the requested volume size:

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
   ...
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 2Gi
   ...
   status:
     accessModes:
     - ReadWriteOnce
     capacity:
       storage: 2Gi
   ...
   ```

## Check the pod with the volume {#checking-pod}

Check the pod status:

   ```bash
   kubectl get pod pod -o yaml
   ```

The pod is running. The `status` section shows no container restarts.
