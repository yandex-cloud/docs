---
title: Using encrypted disks for persistent volumes
description: Follow this guide to use encrypted disks for persistent volumes.
---

# Using encrypted disks for persistent volumes

{% include [encrypted-disks-intro](../../../_includes/managed-kubernetes/encrypted-disks-intro.md) %}

You can use encrypted disks for both [static](#static-provisioning) and [dynamic](#dynamic-provisioning) preparation of persistent volumes.

## Static volume provisioning {#static-provisioning}

1. [Create](../../../kms/operations/key.md) a symmetric key in {{ kms-name }}.
1. [Create](../../../compute/operations/disk-create/empty.md) an encrypted disk using the key you created earlier.

    Save the ID of the disk. You will need it later.
1. [Assign](../../../iam/operations/roles/grant.md) the `kms.keys.encrypterDecrypter` [role](../../../kms/security/index.md#kms-keys-encrypterDecrypter) for a key or folder to the cloud service account of the {{ managed-k8s-name }} cluster.
1. [Prepare](static-create-pv.md) a persistent volume. In the manifest of the `PersistentVolume` object, specify the ID of the created disk in the `spec:csi:volumeHandle` parameter.

## Dynamic volume provisioning {#dynamic-provisioning}

1. [Create](../../../kms/operations/key.md) a symmetric key in {{ kms-name }}.

    Save the ID of the key. You will need it later.
1. [Assign](../../../iam/operations/roles/grant.md) the `kms.keys.encrypterDecrypter` [role](../../../kms/security/index.md#kms-keys-encrypterDecrypter) for a key or folder to the cloud service account of the {{ managed-k8s-name }} cluster.
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. In the `encrypted-storage-class.yaml` file, create a manifest for the new [storage class](manage-storage-class.md):

    {% include [encrypted-storage-class-config](../../../_includes/managed-kubernetes/encrypted-storage-class-config.md) %}

1. Create a storage class:

    ```bash
    kubectl apply -f encrypted-storage-class.yaml
    ```

1. In the `encrypted-pvc.yaml` file, create a manifest for the new `PersistentVolumeClaim` object:

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <PVC_name>
    spec:
      accessModes:
        - ReadWriteOnce
      storageClassName: <storage_class_name>
      resources:
        requests:
          storage: 4Gi
    ```

    Where:
    * `metadata:name`: Random name for the `PersistentVolumeClaim` object.
    * `spec:storageClassName`: Name of the storage class created earlier.

1. Create the `PersistentVolumeClaim` object:

    ```bash
    kubectl apply -f encrypted-pvc.yaml
    ```

1. In the `pod-with-encrypted-pvc.yaml` file, create a manifest for the pod with a dynamically prepared persistent volume:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
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
            claimName: <PVC_name>
    ```

    Where:
    * `metadata:name`: Random name for the pod.
    * `spec:volumes:persistentVolumeClaim:claimName`: Name of the `PersistentVolumeClaim` object created earlier.

1. Create a pod.

    ```bash
    kubectl apply -f pod-with-encrypted-pvc.yaml
    ```

    After creating a pod in the [management console]({{ link-console-main }}) in **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in the **{{ ui-key.yacloud.compute.disks_ddfdb }}** section, a new encrypted disk will appear with the `k8s-csi` prefix in the name.

### See also {#see-also}

* [{#T}](../../concepts/volume.md)
* [{#T}](../../concepts/encryption.md) 
* [{#T}](../../../compute/concepts/encryption.md)
* [{#T}](./dynamic-create-pv.md)
* [{#T}](./static-create-pv.md)
* [{#T}](./manage-storage-class.md)