# Static volume provisioning

Create a [pod](../../concepts/index.md#pod) with a statically provisioned [volume](../../concepts/volume.md):
1. [Create a PersistentVolume](#create-pv).
1. [Create a PersistentVolumeClaim](#create-claim).
1. [Create a pod](#create-pod).

{% note tip %}

You can use a [bucket](../../../storage/concepts/bucket.md) in {{ objstorage-full-name }} as storage for the pod. For more information, see [{#T}](s3-csi-integration.md).

{% endnote %}

## Before you start {#before-you-begin}

Retrieve a unique identifier for the [disk](../../../compute/concepts/disk.md) to be used to create the `PersistentVolume` object or create a new disk:
1. If you don't have a disk yet, [create one](../../../compute/operations/disk-create/empty.md).
1. Look up the unique disk ID:

   ```bash
   yc compute disk list
   ```

   Result:

   ```
   +----------------------+------+--------------+-------------------+--------+----------------------+-------------+
   |          ID          | NAME |     SIZE     |        ZONE       | STATUS |     INSTANCE IDS     | DESCRIPTION |
   +----------------------+------+--------------+-------------------+--------+----------------------+-------------+
   | ef3ouo4sgl86740ridn6 | k8s  |   4294967296 | {{ region-id }}-a | READY  |                      |             |
   | ef3qh55ckuu7md2kqhbt |      | 103079215104 | {{ region-id }}-a | READY  | ef3sin41eksav1kn4gct |             |
   | epd9vda1h0knttpcuhfu |      |  10737418240 | {{ region-id }}-a | READY  | epdegdecs9o14r13gbad |             |
   +----------------------+------+--------------+-------------------+--------+----------------------+-------------+
   ```

## Create a PersistentVolume object {#create-pv}

1. Save the specification you used to create your `PersistentVolume` to a YAML file named `test-pv.yaml`.

   More information on specifications is available in the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

   When specifying the `capacity: storage` parameter, please make sure that exact disk size is specified. {{ CSI }} does not verify disk size for statically provisioned volumes.

   To create a `PersistentVolume` from an existing cloud drive, enter its unique disk ID in the `volumeHandle` parameter.

   ```
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: test-pv
   spec:
     capacity:
       storage: 4Gi
     accessModes:
       - ReadWriteOnce
     csi:
       driver: disk-csi-driver.mks.ycloud.io
       fsType: ext4
       volumeHandle: ef3ouo4sgl86740ridn6
   ```

1. Run the command:

   ```bash
   kubectl create -f test-pv.yaml
   ```

   Result:

   ```
   persistentvolume/test-pv created
   ```

1. View information about the `PersistentVolume` created:

   ```bash
   kubectl describe persistentvolume test-pv
   ```

   Result:

   
   ```
   Name:            test-pv
   Labels:          <none>
   Annotations:     <none>
   Finalizers:      [kubernetes.io/pv-protection]
   StorageClass:    yc-network-hdd
   Status:          Available
   ...
   ```



## Create a PersistentVolumeClaim object {#create-claim}

1. Save the `PersistentVolumeClaim` creation specification to a YAML file named `test-claim.yaml`.

   More information on specifications is available in the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

   ```
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: test-claim
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 4Gi
     volumeName: test-pv
   ```

   1. Run the command:

      ```bash
      kubectl create -f test-claim.yaml
      ```

      Result:

      ```
      persistentvolumeclaim/test-claim created
      ```

   1. View information about the `PersistentVolumeClaim` created:

      ```bash
      kubectl describe persistentvolumeclaim test-claim
      ```

      Result:

      
      ```
      Name:          test-claim
      Namespace:     default
      StorageClass:  yc-network-hdd
      Status:        Bound
      Volume:        test-pv
      ...
      ```



## Create a pod with a statically provisioned volume {#create-pod}

1. Save the following example to a YAML file named `test-pod.yaml`:

   ```
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
         claimName: test-claim
   ```

   More information on specifications is available in the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

1. Run the command:

   ```bash
   kubectl create -f test-pod.yaml
   ```

   Result:

   ```
   pod/test-pod created
   ```

1. View information about the pod created:

   ```bash
   kubectl describe pod test-pod
   ```

   Result:

   ```
   Name:         test-pod
   Namespace:    default
   Priority:     0
   Node:         cl1gqrct5oier258n08t-ypap/10.0.0.9
   Start Time:   Tue, 23 Jul 2019 18:34:57 +0300
   Labels:       <none>
   Annotations:  <none>
   Status:       Pending
   ...
   Events:
     Type    Reason     Age   From               Message
     ----    ------     ----  ----               -------
     Normal  Scheduled  3s    default-scheduler  Successfully assigned default/test-pod to cl1gqrct5oier258n08t-ypap
   ```

In the **{{ compute-full-name }}** management console under **Disks**, you will see the word **Active** next to the disk you're using.