---
title: How to create a pod with a dynamically provisioned volume in {{ managed-k8s-full-name }}
description: Follow this guide to create a pod with a dynamically provisioned volume.
---

# Dynamic volume provisioning


Create a [pod](../../concepts/index.md#pod) with a dynamically provisioned [volume](../../concepts/volume.md):
1. [Create a PersistentVolumeClaim](#create-pvc).
1. [Create a pod](#create-pod).

{% include [Install kubectl to get started](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

{% note tip %}

You can use a [{{ objstorage-full-name }}](../../../storage/) [bucket](../../../storage/concepts/bucket.md) as storage for your pod. For more information, see [{#T}](s3-csi-integration.md).

{% endnote %}

## Create a PersistentVolumeClaim object {#create-pvc}

1. Save the following `PersistentVolumeClaim` creation specification to a YAML file named `pvc-dynamic.yaml`.

   {% note info %}

   If the `storageClassName` parameter is not specified, the default storage class (`yc-network-hdd`) is used. To change the default class, see [{#T}](manage-storage-class.md#sc-default).

   {% endnote %}

   To learn more about the `PersistentVolumeClaim` creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-dynamic
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: yc-network-hdd
     resources:
       requests:
         storage: 4Gi
   ```

1. Run this command:

   ```bash
   kubectl create -f pvc-dynamic.yaml
   ```

   Result:

   ```text
   persistentvolumeclaim/pvc-dynamic created
   ```

1. View the information about the new `PersistentVolumeClaim` object:

   ```bash
   kubectl describe persistentvolumeclaim pvc-dynamic
   ```

   Result:

   ```text
   Name:          pvc-dynamic
   Namespace:     default
   StorageClass:  yc-network-hdd
   ...
   Type    Reason                Age               From                         Message
   ----    ------                ----              ----                         -------
   Normal  WaitForFirstConsumer  9s (x3 over 15s)  persistentvolume-controller  waiting for first consumer to be created before binding
   ```

## Create a pod with a dynamically provisioned volume {#create-pod}

1. Save the following pod creation specification to a YAML file named `pod.yaml`.

   To learn more about the pod creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

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
         claimName: pvc-dynamic
   ```

1. Run this command:

   ```bash
   kubectl create -f pod.yaml
   ```

   Result:

   ```text
   pod/pod created
   ```

1. View the information about the new pod:

   ```bash
   kubectl describe pod pod
   ```

   Result:

   ```text
   Name:         pod
   Namespace:    default
   Priority:     0
   ...
     Normal  Pulled                  11s   kubelet, cl1gqrct5oie********-ytas  Successfully pulled image "ubuntu"
     Normal  Created                 10s   kubelet, cl1gqrct5oie********-ytas  Created container
     Normal  Started                 10s   kubelet, cl1gqrct5oie********-ytas  Started container
   ```

   After creating a pod:
   * In the [management console]({{ link-console-main }}) in **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in the **{{ ui-key.yacloud.compute.switch_disks }}** section, a new [disk](../../../compute/concepts/disk.md) will appear with the `k8s-csi` prefix in the disk name.
   * You can find disk provisioning information in the `PersistentVolumeClaim` events:

     ```bash
     kubectl describe persistentvolumeclaim pvc-dynamic
     ```

     Result:

     ```text
     Name:          pvc-dynamic
     Namespace:     default
     StorageClass:  yc-network-hdd
     ...
       Normal  ExternalProvisioning   4m10s (x3 over 4m10s)  persistentvolume-controller                                                              waiting for a volume to be created, either by external provisioner "disk-csi-driver.mks.ycloud.io" or manually created by system administrator
       Normal  Provisioning           4m10s                  disk-csi-driver.mks.ycloud.io_cat1h5l0v862oq74cp8j_d0f0b837-a875-11e9-b6cb-d00d********  External provisioner is provisioning volume for claim "default/pvc-dynamic"
       Normal  ProvisioningSucceeded  4m7s                   disk-csi-driver.mks.ycloud.io_cat1h5l0v862oq74cp8j_d0f0b837-a875-11e9-b6cb-d00d********  Successfully provisioned volume pvc-c4794058-ad68-11e9-b71a-d00d********
     ```

## How to delete a volume {#delete-volume}

To delete a dynamically provisioned volume, delete the `PersistentVolumeClaim` object:

```bash
kubectl delete pvc <PersistentVolumeClaim_object_ID>
```

The disk will be deleted automatically from [{{ compute-full-name }}](../../../compute/).