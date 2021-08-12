---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Static volume provisioning

Create a pod with a statically provisioned [volume](../../concepts/volume.md):

1. [Create a PersistentVolume](#create-pv).
1. [Create a PersistentVolumeClaim](#create-claim).
1. [Create a pod](#create-pod).

## Before getting started {#before-you-begin}

Look up the unique ID of the disk to be used to create the `PersistentVolume`, or create a new disk:

1. If you don't have a disk yet, [create one](../../../compute/operations/disk-create/empty.md).

1. Look up the unique disk ID:

    ```
    $ yc compute disk list
    +----------------------+------+--------------+---------------+--------+----------------------+-------------+
    |          ID          | NAME |     SIZE     |     ZONE      | STATUS |     INSTANCE IDS     | DESCRIPTION |
    +----------------------+------+--------------+---------------+--------+----------------------+-------------+
    | ef3ouo4sgl86740ridn6 | k8s  |   4294967296 | ru-central1-c | READY  |                      |             |
    | ef3qh55ckuu7md2kqhbt |      | 103079215104 | ru-central1-c | READY  | ef3sin41eksav1kn4gct |             |
    | epd9vda1h0knttpcuhfu |      |  10737418240 | ru-central1-b | READY  | epdegdecs9o14r13gbad |             |
    +----------------------+------+--------------+---------------+--------+----------------------+-------------+
    ```

## Create a PersistentVolume {#create-pv}

1. Save the `PersistentVolume` creation specification to a YAML file named `test-pv.yaml`.

    To learn more about the specification, see the {{ k8s }} [documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

    When setting the `capacity: storage` parameter, make sure you specify the exact size of the disk. CSI doesn't validate the disk size for statically provisioned volumes.

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

    ```
    $ kubectl create -f test-pv.yaml
    persistentvolume/test-pv created
    ```

1. View information about the `PersistentVolume` created:

    ```
    $ kubectl describe persistentvolume test-pv
    Name:            test-pv
    Labels:          <none>
    Annotations:     <none>
    Finalizers:      [kubernetes.io/pv-protection]
    StorageClass:    yc-network-hdd
    Status:          Available
    ...
    ```

## Create a PersistentVolumeClaim {#create-claim}

1. Save the `PersistentVolumeClaim` creation specification to a YAML file named `test-claim.yaml`.

    To learn more about the specification, see the {{ k8s }} [documentation](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

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

        ```
        $ kubectl create -f test-claim.yaml
        persistentvolumeclaim/test-claim created
        ```

    1. View information about the `PersistentVolumeClaim` created:

        ```
        $ kubectl describe persistentvolumeclaim test-claim
        Name:          test-claim
        Namespace:     default
        StorageClass:  yc-network-hdd
        Status:        Bound
        Volume:        test-pv
        ...
        ```

## Create a pod with a statically provisioned volume {#create-pod}

1. Save the following example to a YAML file named `test-pod.yaml`.

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
          claimName:  test-claim
    ```

    To learn more about the specification, see the {{ k8s }} [documentation](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

1. Run the command:

    ```
    $ kubectl create -f test-pod.yaml
    pod/test-pod created
    ```

1. View information about the pod created:

    ```
    $ kubectl describe pod test-pod
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

In the **{{ compute-name }}** management console under **Disks**, you will see the word **Active** next to the disk you're using.

