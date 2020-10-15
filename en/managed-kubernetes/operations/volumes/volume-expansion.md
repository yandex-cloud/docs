# Expanding a volume

To expand a [volume](../../concepts/volume.md), follow these steps.

## Enable volume expansion {#enabling-expansion}

To enable the volume expansion feature, make sure the [storage class](manage-storage-class.md) (`StorageClass`) description contains `allowVolumeExpansion: true`. In {{ managed-k8s-short-name }} storage, this feature is enabled by default:

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

## Create a PersistentVolumeClaim {#create-pvc}

1. Save the following [PersistentVolumeClaim](dynamic-create-pv.md) creation specification to a YAML file named `pvc-expansion.yaml`.

   To learn more about the `PersistentVolumeClaim` creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#persistentvolumeclaim-v1-core).

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

1. Create a `PersistentVolumeClaim`:

   ```bash
   kubectl create -f pvc-expansion.yaml
   ```

   Command execution result:

   ```bash
   persistentvolumeclaim/pvc-expansion created
   ```

## Create a pod with a dynamically provisioned volume {#create-pod}

1. Save the following pod creation specification to a YAML file named `pod.yaml`.

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
         claimName:  pvc-expansion
   ```

1. Create a pod:

   ```bash
   kubectl create -f pod.yaml
   ```

   Command execution result:

   ```bash
   pod/pod created
   ```

## Delete the pod with the volume {#restart-pod}

To request volume expansion, you need to delete the pod.

1. Delete the pod:

   ```bash
   kubectl delete pod pod
   ```

   Command execution result:

   ```bash
   pod "pod" deleted
   ```

## Request volume expansion {#volume-expansion}

Make changes to the `spec.resources.requests.storage` field of the `PersistentVolumeClaim`.

1. Open the YAML file named `pvc-expansion.yaml`:

   ```bash
   kubectl edit pvc pvc-expansion
   ```

   In the text editor, change the disk size value and save it:

   ```
   # Please edit the object below. Lines beginning with a '#' will be ignored,
   # and an empty file will abort the edit. If an error occurs while saving this file will be
   # reopened with the relevant failures.
   #
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
   ...
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
        storage: 1Gi # Change the value to 2Gi.
   ...
   status:
     accessModes:
     - ReadWriteOnce
     capacity:
       storage: 1Gi
   phase: Bound
   ```

1. Wait for the volume to expand. Check the change results:

   ```bash
   kubectl get pvc pvc-expansion -o yaml
   ```

   The `spec.resources.requests.storage` field shows the requested volume size:

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
       storage: 1Gi
   ...
   ```

## Create a pod with a volume {#restart-pod}

1. To resize the volume, create a pod:

   ```bash
   kubectl create -f pod.yaml
   ```

   Command execution result:

   ```bash
   pod/pod created
   ```

1. Check the change results:

   ```bash
   kubectl get pvc pvc-expansion -o yaml
   ```

   The volume size increased. The `status.capacity.storage` field shows the expanded size:

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
