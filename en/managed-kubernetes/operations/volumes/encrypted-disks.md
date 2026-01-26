---
title: Using encrypted disks for persistent volumes
description: Follow this guide to use encrypted disks for persistent volumes.
---

# Using encrypted disks for persistent volumes

{% include [encrypted-disks-intro](../../../_includes/managed-kubernetes/encrypted-disks-intro.md) %}

You can use encrypted disks for both [static](#static-provisioning) and [dynamic](#dynamic-provisioning) provisioning of persistent volumes.

## Static volume provisioning {#static-provisioning}

1. [Create](../../../kms/operations/key.md) a symmetric key in {{ kms-name }}.
1. [Create](../../../compute/operations/disk-create/empty.md) an encrypted disk using the key you created.

    Save the disk ID for later use.
1. [Assign](../../../iam/operations/roles/grant.md) the `kms.keys.encrypterDecrypter` [role](../../../kms/security/index.md#kms-keys-encrypterDecrypter) for a key or folder to the cloud service account of the {{ managed-k8s-name }} cluster.
1. [Provide](static-create-pv.md) a persistent volume. In the `PersistentVolume` manifest, specify the ID of the disk you created in the `spec:csi:volumeHandle` parameter.

## Dynamic volume provisioning {#dynamic-provisioning}

1. [Create](../../../kms/operations/key.md) a symmetric key in {{ kms-name }}.

    Save the key ID for later use.
1. [Assign](../../../iam/operations/roles/grant.md) the `kms.keys.encrypterDecrypter` [role](../../../kms/security/index.md#kms-keys-encrypterDecrypter) for a key or folder to the cloud service account of the {{ managed-k8s-name }} cluster.
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. In the `encrypted-storage-class.yaml` file, create a manifest for the new [storage class](manage-storage-class.md):

    {% include [encrypted-storage-class-config](../../../_includes/managed-kubernetes/encrypted-storage-class-config.md) %}

1. Create a storage class:

    ```bash
    kubectl apply -f encrypted-storage-class.yaml
    ```

1. In the `encrypted-pvc.yaml` file, create a manifest for the new `PersistentVolumeClaim`:

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
    * `metadata:name`: Any name for the `PersistentVolumeClaim`.
    * `spec:storageClassName`: Name of the storage class you created earlier.

1. Create a `PersistentVolumeClaim`:

    ```bash
    kubectl apply -f encrypted-pvc.yaml
    ```

1. In the `pod-with-encrypted-pvc.yaml` file, create a manifest for the pod with a dynamically provisioned persistent volume:

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
    * `metadata:name`: Any name for the pod.
    * `spec:volumes:persistentVolumeClaim:claimName`: Name of the `PersistentVolumeClaim` you created earlier.

1. Create a pod:

    ```bash
    kubectl apply -f pod-with-encrypted-pvc.yaml
    ```

    After you create the pod, a new encrypted disk with `k8s-csi` prefixed to its name will appear under **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in **{{ ui-key.yacloud.compute.disks_ddfdb }}** in the [management console]({{ link-console-main }}).

### See also {#see-also}

* [{#T}](../../concepts/volume.md)
* [{#T}](../../concepts/encryption.md) 
* [{#T}](../../../compute/concepts/encryption.md)
* [{#T}](./dynamic-create-pv.md)
* [{#T}](./static-create-pv.md)
* [{#T}](./manage-storage-class.md)