# Dynamic volume provisioning

Create a pod with a dynamically provisioned [volume](../../concepts/volume.md):

1. [Create a PersistentVolumeClaim](#create-pvc).
1. [Create a pod](#create-pod).

## Create a PersistentVolumeClaim {#create-pvc}

1. Save the following `PersistentVolumeClaim` creation specification to a YAML file named `pvc-dynamic.yaml`.

    {% note info %}

    If the `storageClassName` parameter is not specified, the default storage class (`yc-network-hdd`) is used. To change the default class, see [{#T}](manage-storage-class.md#sc-default).

    {% endnote %}

    To learn more about the `PersistentVolumeClaim` creation specification, see the {{ k8s }} [documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#persistentvolumeclaim-v1-core).

    ```
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

    1. Run the command:

        ```
        $ kubectl create -f pvc-dynamic.yaml
        persistentvolumeclaim/pvc-dynamic created
        ```

    1. View information about the `PersistentVolumeClaim` created:

        ```
        $ kubectl describe persistentvolumeclaim pvc-dynamic
        Name:          pvc-dynamic
        Namespace:     default
        StorageClass:  yc-network-hdd
        Status:        Pending
        ...
        Events:
          Type    Reason                Age               From                         Message
          ----    ------                ----              ----                         -------
          Normal  WaitForFirstConsumer  9s (x3 over 15s)  persistentvolume-controller  waiting for first consumer to be created before binding
        ```

## Create a pod with a dynamically provisioned volume {#create-pod}

1. Save the following pod creation specification to a YAML file named `pod.yaml`.

    To learn more about the pod creation specification, see the {{ k8s }} [documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#pod-v1-core).

    ```
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
          claimName:  pvc-dynamic
    ```

1. Run the command:

    ```
    $ kubectl create -f pod.yaml
    pod/pod created
    ```

1. View information about the pod created:

    ```
    $ kubectl describe pod pod
    Name:         pod
    Namespace:    default
    Priority:     0
    Node:         cl1gqrct5oier258n08t-ytas/10.0.0.20
    Start Time:   Tue, 23 Jul 2019 19:42:43 +0300
    Labels:       <none>
    Annotations:  <none>
    Status:       Running
    ...
    Events:
      Type    Reason                  Age   From                                Message
      ----    ------                  ----  ----                                -------
      Normal  Scheduled               30s   default-scheduler                   Successfully assigned default/pod to cl1gqrct5oier258n08t-ytas
      Normal  SuccessfulAttachVolume  28s   attachdetach-controller             AttachVolume.Attach succeeded for volume "pvc-c4794058-ad68-11e9-b71a-d00df1cbdf81"
      Normal  Pulling                 21s   kubelet, cl1gqrct5oier258n08t-ytas  pulling image "ubuntu"
      Normal  Pulled                  11s   kubelet, cl1gqrct5oier258n08t-ytas  Successfully pulled image "ubuntu"
      Normal  Created                 10s   kubelet, cl1gqrct5oier258n08t-ytas  Created container
      Normal  Started                 10s   kubelet, cl1gqrct5oier258n08t-ytas  Started container
    ```

    After creating a pod:

    - In the **{{ compute-name }}** management console under **Disks**, a new disk appears with the `k8s-csi` prefix in the disk name.

    - You can find disk provisioning information in the `PersistentVolumeClaim` events:

        ```
        $ kubectl describe persistentvolumeclaim pvc-dynamic
        Name:          pvc-dynamic
        Namespace:     default
        StorageClass:  yc-network-hdd
        Status:        Bound
        Volume:        pvc-c4794058-ad68-11e9-b71a-d00df1cbdf81
        ...
        Events:
          Type    Reason                 Age                    From                                                                                     Message
          ----    ------                 ----                   ----                                                                                     -------
          Normal  WaitForFirstConsumer   4m25s (x5 over 5m1s)   persistentvolume-controller                                                              waiting for first consumer to be created before binding
          Normal  ExternalProvisioning   4m10s (x3 over 4m10s)  persistentvolume-controller                                                              waiting for a volume to be created, either by external provisioner "disk-csi-driver.mks.ycloud.io" or manually created by system administrator
          Normal  Provisioning           4m10s                  disk-csi-driver.mks.ycloud.io_cat1h5l0v862oq74cp8j_d0f0b837-a875-11e9-b6cb-d00df1cbdf81  External provisioner is provisioning volume for claim "default/pvc-dynamic"
          Normal  ProvisioningSucceeded  4m7s                   disk-csi-driver.mks.ycloud.io_cat1h5l0v862oq74cp8j_d0f0b837-a875-11e9-b6cb-d00df1cbdf81  Successfully provisioned volume pvc-c4794058-ad68-11e9-b71a-d00df1cbdf81
        ```

