# Integration with {{ objstorage-full-name }}

{{ CSI }} lets you dynamically reserve [buckets](../../../storage/concepts/bucket.md) {{ objstorage-name }} and mount them to [pods](../../concepts/index.md#pod) in a cluster. You can mount existing buckets or create new ones.

To use {{ CSI }} capabilities:
1. [Set up the runtime environment](#create-environment).
1. [Configure {{ CSI }}](#configure-csi).

See also:
* [Using {{ CSI }} with `PersistentVolumeClaim`](#csi-usage).
* [Examples of creating `PersistentVolumeClaim`](#examples).

## Setting up a runtime environment {#create-environment}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.editor` [role](../../../iam/concepts/access-control/roles.md).
1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the [service account](../../../iam/concepts/index.md#sa).

## Set up {{ CSI }} {#configure-csi}

1. Create a file named `secret.yaml` and specify the {{ CSI }} access settings in it:

   ```yaml
   ---
   apiVersion: v1
   kind: Secret
   metadata:
     namespace: kube-system
     name: csi-s3-secret
   stringData:
     accessKeyID: <access key ID>
     secretAccessKey: <secret key>
     endpoint: https://{{ s3-storage-host }}
   ```

   In the `accessKeyID` and the `secretAccessKey`, specify the [previously received](#create-environment) ID and secret key value.
1. Create a file with a description of the `storageclass.yaml` storage class:

   ```yaml
   ---
   kind: StorageClass
   apiVersion: storage.k8s.io/v1
   metadata:
     name: csi-s3
   provisioner: ru.yandex.s3.csi
   parameters:
     mounter: geesefs
     options: "--memory-limit=1000 --dir-mode=0777 --file-mode=0666"
     bucket: <optional: existing bucket name>
     csi.storage.k8s.io/provisioner-secret-name: csi-s3-secret
     csi.storage.k8s.io/provisioner-secret-namespace: kube-system
     csi.storage.k8s.io/controller-publish-secret-name: csi-s3-secret
     csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
     csi.storage.k8s.io/node-stage-secret-name: csi-s3-secret
     csi.storage.k8s.io/node-stage-secret-namespace: kube-system
     csi.storage.k8s.io/node-publish-secret-name: csi-s3-secret
     csi.storage.k8s.io/node-publish-secret-namespace: kube-system
   ```

   To use an existing bucket, specify its name in the `bucket` parameter. This setting is only relevant for [dynamic `PersistentVolumeClaim`](#dpvc-csi-usage).
1. Clone the [GitHub repository](https://github.com/yandex-cloud/k8s-csi-s3.git) containing the current {{ CSI }} driver:

   ```bash
   git clone https://github.com/yandex-cloud/k8s-csi-s3.git
   ```

1. Create resources for {{ CSI }} and your storage class:

   ```bash
   kubectl create -f secret.yaml && \
   kubectl create -f k8s-csi-s3/deploy/kubernetes/provisioner.yaml && \
   kubectl create -f k8s-csi-s3/deploy/kubernetes/attacher.yaml && \
   kubectl create -f k8s-csi-s3/deploy/kubernetes/csi-s3.yaml && \
   kubectl create -f storageclass.yaml
   ```

After installing the {{ CSI }} driver and configuring your storage class, you can create static and dynamic `PersistentVolumeClaim` to use {{ objstorage-name }} buckets.

## {{ CSI }} usage {#csi-usage}

With {{ CSI }} configured, there are certain things to note about creating static and dynamic `PersistentVolumeClaims`.

### Dynamic PersistentVolumeClaim {#dpvc-csi-usage}

For [dynamic `PersistentVolumeClaim`](../../concepts/volume.md#dynamic-provisioning):
* Specify the name of the desired storage class in the `spec.storageClassName` parameter when creating a `PersistentVolumeClaim`.
* If required, specify a bucket name in the`bucket` parameter when [creating a storage class](#configure-csi). This affects {{ CSI }} behavior:
  * If you specified a bucket name in the `bucket` parameter when configuring your storage class, {{ CSI }} will create a separate folder in this bucket for each `PersistentVolumeClaim` created.

    {% note info %}

    This setting can be useful if the cloud enforces strict [quotas]({{ link-console-quotas }}) on the number of {{ objstorage-name }} buckets.

    {% endnote %}

  * If you omitted a bucket name in the `bucket` parameter, {{ CSI }} will create a separate bucket for each `PersistentVolumeClaim` created.

[Example of creating](#create-dynamic-pvc) a dynamic `PersistentVolumeClaim`.

### Static PersistentVolumeClaim {#spvc-csi-usage}

For a [static `PersistentVolumeClaim`](../../concepts/volume.md#static-provisioning):
* Leave the `spec.storageClassName` parameter empty when creating `PersistentVolumeClaim`.
* Specify the name of the desired bucket or bucket directory in the `spec.csi.volumeHandle` parameter when creating `PersistentVolume`. If there is no such bucket, create it.

  {% note info %}

  Deleting this type of `PersistentVolume` will not automatically delete its associated bucket.

  {% endnote %}

* To update [GeeseFS](../../../storage/tools/geesefs.md) options for working with a bucket, specify them in the `spec.csi.volumeAttributes.options` parameter when creating a `PersistentVolume`. For example, in the `--uid` option, you can specify the ID of the user being the owner of all files in storage. To get a list of GeeseFS options, run the `geesefs -h` command or find it in the [GitHub repository](https://github.com/yandex-cloud/geesefs/blob/master/internal/flags.go#L88).

  The GeeseFS options specified in the `parameters.options` parameter of `StorageClass` for static `PersistentVolumeClaims` are ignored. For more information, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/storage/storage-classes/#mount-options).

[Example of creating](#create-static-pvc) a static `PersistentVolumeClaim`.

## Use cases {#examples}

### Dynamic PersistentVolumeClaim {#create-dynamic-pvc}

To use {{ CSI }} with a dynamic `PersistentVolumeClaim`:
1. Create a `PersistentVolumeClaim`:
   1. [Configure {{ CSI }}](#configure-csi).
   1. Create a file named `pvc-dynamic.yaml`containing a description of your dynamic `PersistentVolumeClaim`:

      {% cut "pvc-dynamic.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: csi-s3-pvc-dynamic
        namespace: default
      spec:
        accessModes:
        - ReadWriteMany
        resources:
          requests:
            storage: 5Gi
        storageClassName: csi-s3
      ```

      {% endcut %}

      If necessary, change the requested storage size in the `spec.resources.requests.storage` parameter value.
   1. Create a dynamic `PersistentVolumeClaim`:

      ```bash
      kubectl create -f pvc-dynamic.yaml
      ```

   1. Make sure that your `PersistentVolumeClaim` has transitioned to a `Bound` state:

      ```bash
      kubectl get pvc csi-s3-pvc-dynamic
      ```

      Result:

      ```text
      NAME                STATUS  VOLUME                    CAPACITY  ACCESS MODES  STORAGECLASS  AGE
      csi-s3-pvc-dynamic  Bound   pvc-<dynamic bucket name> 5Gi       RWX           csi-s3        73m
      ```

1. Create a pod to test your dynamic `PersistentVolumeClaim`.
   1. Create a file named `pod-dynamic.yaml` with the pod description:

      {% cut "pod-dynamic.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: Pod
      metadata:
        name: csi-s3-test-ubuntu-dynamic
      spec:
        containers:
        - name: csi-s3-test-ubuntu
          image: ubuntu
          command: ["/bin/sh"]
          args: ["-c", "for i in {1..10}; do echo $(date -u) >> /data/s3-dynamic/dynamic-date.txt; sleep 10; done"]
          volumeMounts:
            - mountPath: /data/dynamic
              name: s3-volume
        volumes:
          - name: s3-volume
            persistentVolumeClaim:
              claimName: csi-s3-pvc-dynamic
              readOnly: false
      ```

      {% endcut %}

   1. Create a pod to mount a bucket to for your dynamic `PersistentVolume`:

      ```bash
      kubectl create -f pod-dynamic.yaml
      ```

   1. Make sure the pod status changed to `Running`:

      ```bash
      kubectl get pods
      ```

   While running, the pod will execute the `date` command several times and it write its output to a file named `/data/s3-dynamic/dynamic-date.txt`. You will find this file in the bucket.
1. Make sure that the file is in the bucket:
   1. Go to the folder page and select **{{ objstorage-name }}**.
   1. Click the `pvc-<dynamic bucket name>` bucket.

### Static PersistentVolumeClaim {#create-static-pvc}

To use {{ CSI }} with a static `PersistentVolumeClaim`:
1. Create a `PersistentVolumeClaim`:
   1. [Configure {{ CSI }}](#configure-csi).
   1. Create a file named `pvc-static.yaml`containing a description of your static `PersistentVolumeClaim`:

      {% cut "pvc-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: csi-s3-pvc-static
        namespace: default
      spec:
        accessModes:
          - ReadWriteMany
        resources:
          requests:
            storage: 10Gi
        storageClassName: ""
      ```

      {% endcut %}

      If necessary, change the requested storage size in the `spec.resources.requests.storage` parameter value.
   1. Create a file named `pv-static.yaml`containing a description of your static `PersistentVolume`:

      {% cut "pv-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        name: <Persistent Volume name>
      spec:
        storageClassName: csi-s3
        capacity:
          storage: 10Gi
        accessModes:
          - ReadWriteMany
        claimRef:
          namespace: default
          name: csi-s3-pvc-static
        csi:
          driver: ru.yandex.s3.csi
          volumeHandle: <bucket name>/<optional: path to folder in bucket>
          controllerPublishSecretRef:
            name: csi-s3-secret
            namespace: kube-system
          nodePublishSecretRef:
            name: csi-s3-secret
            namespace: kube-system
          nodeStageSecretRef:
            name: csi-s3-secret
            namespace: kube-system
          volumeAttributes:
            capacity: 10Gi
            mounter: geesefs
            options: "--memory-limit=1000 --dir-mode=0777 --file-mode=0666 --uid=1001"
      ```

      In this example, GeeseFS settings for working with a bucket are changed as compared to `StorageClass`. The `--uid` option is added to them. It specifies the ID of the user being the owner of all files in storage: `1001`. For more information about setting up GeeseFS for a static `PersistentVolumeClaim`, see [above](#spvc-csi-usage).

      {% endcut %}

   1. Create a static `PersistentVolumeClaim`:

      ```bash
      kubectl create -f pvc-static.yaml
      ```

   1. Create a static `PersistentVolume`:

      ```bash
      kubectl create -f pv-static.yaml
      ```

   1. Make sure that your `PersistentVolumeClaim` has transitioned to a `Bound` state:

      ```bash
      kubectl get pvc csi-s3-pvc-static
      ```

      Result:

      ```text
      NAME               STATUS  VOLUME                   CAPACITY   ACCESS MODES  STORAGECLASS  AGE
      csi-s3-pvc-static  Bound   <PersistentVolume name>  10Gi       RWX           csi-s3        73m
      ```

1. Create a pod to test your static `PersistentVolumeClaim`.
   1. Create a file named `pod-static.yaml` with the pod description:

      {% cut "pod-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: Pod
      metadata:
        name: csi-s3-test-ubuntu-static
      spec:
        containers:
        - name: csi-s3-test-ubuntu
          image: ubuntu
          command: ["/bin/sh"]
          args: ["-c", "for i in {1..10}; do echo $(date -u) >> /data/s3-static/static-date.txt; sleep 10; done"]
          volumeMounts:
            - mountPath: /data/s3-static
              name: s3-volume
        volumes:
          - name: s3-volume
            persistentVolumeClaim:
              claimName: csi-s3-pvc-static
              readOnly: false
      ```

      {% endcut %}

   1. Create a pod to mount a bucket to for your static `PersistentVolume`:

      ```bash
      kubectl create -f pod-static.yaml
      ```

   1. Make sure the pod status changed to `Running`:

      ```bash
      kubectl get pods
      ```

   While running, the pod will execute the `date` command several times and write its output to a file named `/data/s3-static/static-date.txt`. You will find this file in the bucket.
1. Make sure that the file is in the bucket:
   1. Go to the folder page and select **{{ objstorage-name }}**.
   1. Click on `<bucket name>`.