# Integration with {{ objstorage-name }}

{{ CSI }} allows you to dynamically reserve [{{ objstorage-full-name }}](../../../storage/) [buckets](../../../storage/concepts/bucket.md) and mount them in [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) [pods](../../concepts/index.md#pod). You can mount existing buckets or create new ones.

To use {{ CSI }} capabilities:

1. [Set up a work environment](#create-environment).
1. [Configure {{ CSI }}](#configure-csi).

See also:

* [Using {{ CSI }} with a `PersistentVolume`](#csi-usage).
* [`PersistentVolume` creation example](#examples).

## Setting up a runtime environment {#create-environment}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.editor` [role](../../../iam/concepts/access-control/roles.md).
1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for your [service account](../../../iam/concepts/index.md#sa). Save the key ID and secret key, as you will need them when installing {{ CSI }}.
1. [Create an {{ objstorage-name }} bucket](../../../storage/operations/buckets/create.md) that will be mounted to a `PersistentVolume`. Save the bucket name, as you will need it when installing {{ CSI }}.
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Configuring {{ CSI }} {#configure-csi}

{% include [csi-s3-actual](../../../_includes/managed-kubernetes/csi-s3-actual.md) %}

{% list tabs group=instructions %}

- {{ marketplace-full-name }} {#marketplace}

  Install the {{ CSI }} application for S3 by following [this step-by-step guide](../applications/csi-s3.md#install-fb-marketplace). While installing the application, specify the following parameters:

  * **Namespace**: `kube-system`.
  * **S3 key ID**: Copy the key ID of the [created service account](#create-environment) into this field.
  * **S3 secret key**: Copy the secret key of the [created service account](#create-environment) into this field.
  * **Shared S3 bucket for volumes**: To use the existing bucket, specify its name. This setting is only relevant for [dynamic `PersistentVolume` objects](#dpvc-csi-usage).
  * **Storage class name**: `csi-s3`. Also select the **Create a storage class** option.
  * **Secret name**: `csi-s3-secret`. Also select the **Create a secret** option.

  Leave the default values for the other parameters.

  After installing the application, you can create [static](../../concepts/volume.md#static-provisioning) and [dynamic](../../concepts/volume.md#dynamic-provisioning) `PersistentVolume` objects to use {{ objstorage-name }} buckets.

- Manually {#manual}

  1. Create a file named `secret.yaml` and specify the {{ CSI }} access settings in it:

     ```yaml
     ---
     apiVersion: v1
     kind: Secret
     metadata:
       namespace: kube-system
       name: csi-s3-secret
     stringData:
       accessKeyID: <access_key_ID>
       secretAccessKey: <secret_key>
       endpoint: https://{{ s3-storage-host }}
     ```

     In the `accessKeyID` and `secretAccessKey` fields, specify the [previously received](#create-environment) ID and secret key value.
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
       bucket: <optionally:_existing_bucket_name>
       csi.storage.k8s.io/provisioner-secret-name: csi-s3-secret
       csi.storage.k8s.io/provisioner-secret-namespace: kube-system
       csi.storage.k8s.io/controller-publish-secret-name: csi-s3-secret
       csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
       csi.storage.k8s.io/node-stage-secret-name: csi-s3-secret
       csi.storage.k8s.io/node-stage-secret-namespace: kube-system
       csi.storage.k8s.io/node-publish-secret-name: csi-s3-secret
       csi.storage.k8s.io/node-publish-secret-namespace: kube-system
     ```

     To use an existing bucket, specify its name in the `bucket` parameter. This setting is only relevant for [dynamic `PersistentVolume` objects](#dpvc-csi-usage).
  1. Clone the [GitHub repository](https://github.com/yandex-cloud/k8s-csi-s3.git) containing the current {{ CSI }} driver:

     ```bash
     git clone https://github.com/yandex-cloud/k8s-csi-s3.git
     ```

  1. Create resources for {{ CSI }} and your storage class:

     ```bash
     kubectl create -f secret.yaml && \
     kubectl create -f k8s-csi-s3/deploy/kubernetes/provisioner.yaml && \
     kubectl create -f k8s-csi-s3/deploy/kubernetes/driver.yaml && \
     kubectl create -f k8s-csi-s3/deploy/kubernetes/csi-s3.yaml && \
     kubectl create -f storageclass.yaml
     ```

     After installing the {{ CSI }} driver and configuring your storage class, you can create static and dynamic `PersistentVolume` objects to use {{ objstorage-name }} buckets.

{% endlist %}

## {{ CSI }} usage {#csi-usage}

With {{ CSI }} configured, there are certain things to note about creating static and dynamic `PersistentVolumes` objects.

### Dynamic PersistentVolume {#dpvc-csi-usage}

For a dynamic `PersistentVolume`:

* Specify the name of the storage class in the `spec.storageClassName` parameter when creating a `PersistentVolumeClaim`.
* If required, specify the bucket name in the `bucket` parameter (or the **Shared S3 bucket for volumes** field in the {{ marketplace-full-name }} settings) when [creating a storage class](#configure-csi). This affects {{ CSI }} behavior:
  * If you specify the bucket name when configuring your storage class, {{ CSI }} will create a separate folder in this bucket for each created `PersistentVolume` object.

    {% note info %}

    This setting can be useful if the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) enforces strict [quotas]({{ link-console-quotas }}) on the number of {{ objstorage-name }} buckets.

    {% endnote %}

  * If you skip the bucket name, {{ CSI }} will create a separate bucket for each created `PersistentVolume`.

See also the [example of creating](#create-dynamic-pvc) a dynamic `PersistentVolume`.

### Static PersistentVolume {#spvc-csi-usage}

For a static `PersistentVolume`:

* When creating your `PersistentVolumeClaim`, set an empty value for the `spec.storageClassName` parameter.
* Then, specify the name of the bucket or bucket directory of your choice in the `spec.csi.volumeHandle` parameter. If no such bucket exists, create one.

  {% note info %}

  Deleting this type of `PersistentVolume` will not automatically delete its associated bucket.

  {% endnote %}

* To update [GeeseFS](../../../storage/tools/geesefs.md) options for working with a bucket, specify them in the `spec.csi.volumeAttributes.options` parameter when creating your `PersistentVolume`. For example, in the `--uid` option, you can specify the ID of the user being the owner of all files in storage. To get a list of GeeseFS options, run the `geesefs -h` command or find it in the [GitHub repository](https://github.com/yandex-cloud/geesefs/blob/master/internal/flags.go#L88).

  The GeeseFS options specified under `parameters.options` (or the **GeeseFS mount options** field in the {{ marketplace-full-name }} settings) in `StorageClass` are ignored for a static `PersistentVolume`. For more information, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/storage/storage-classes/#mount-options).

See also the [example of creating](#create-static-pvc) a static `PersistentVolume`.

## Use cases {#examples}

### Dynamic PersistentVolume {#create-dynamic-pvc}

To use {{ CSI }} with a dynamic `PersistentVolume`:

1. [Configure {{ CSI }}](#configure-csi).
1. Create the `PersistentVolumeClaim`:
   1. Create a file named `pvc-dynamic.yaml` with the `PersistentVolumeClaim` description:

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

      You can change the requested storage size as you need in the `spec.resources.requests.storage` parameter value.
   1. Create the `PersistentVolumeClaim`:

      ```bash
      kubectl create -f pvc-dynamic.yaml
      ```

   1. Make sure the `PersistentVolumeClaim` status changed to `Bound`:

      ```bash
      kubectl get pvc csi-s3-pvc-dynamic
      ```

      Result:

      ```text
      NAME                STATUS  VOLUME                    CAPACITY  ACCESS MODES  STORAGECLASS  AGE
      csi-s3-pvc-dynamic  Bound   pvc-<dynamic_bucket_name>  5Gi       RWX           csi-s3        73m
      ```

1. Create a pod to test your dynamic `PersistentVolume`.
   1. Create a file named `pod-dynamic.yaml` with the pod description:

      {% cut "pod-dynamic.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: Pod
      metadata:
        name: csi-s3-test-nginx-dynamic
        namespace: default
      spec:
        containers:
        - name: csi-s3-test-nginx
          image: nginx
          volumeMounts:
            - mountPath: /usr/share/nginx/html/s3
              name: webroot
        volumes:
          - name: webroot
            persistentVolumeClaim:
              claimName: csi-s3-pvc-dynamic
              readOnly: false
      ```

      {% endcut %}

   1. Create a pod to mount a bucket for your dynamic `PersistentVolume`:

      ```bash
      kubectl create -f pod-dynamic.yaml
      ```

   1. Make sure the pod status changed to `Running`:

      ```bash
      kubectl get pods
      ```

1. Create the `/usr/share/nginx/html/s3/hello_world` file in the container. For this, [run the following command](https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/) on the pod:

    ```bash
    kubectl exec -ti csi-s3-test-nginx-dynamic -- touch /usr/share/nginx/html/s3/hello_world
    ```

1. Make sure that the file is in the bucket:
   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click the `pvc-<dynamic_bucket_name>` bucket. If you specified the bucket name when configuring your storage class, open that bucket and the `pvc-<dynamic_bucket_name>` folder located inside.

### Static PersistentVolume {#create-static-pvc}

To use {{ CSI }} with a static `PersistentVolume`:

1. [Configure {{ CSI }}](#configure-csi).
1. Create the `PersistentVolumeClaim`:
   1. Create a file named `pvc-static.yaml` with the `PersistentVolumeClaim` description:

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

      For a static `PersistentVolume`, you do not need to specify the storage class name in the `spec.storageClassName` parameter. You can change the requested storage size as you need in the `spec.resources.requests.storage` parameter value.
   1. Create a file named `pv-static.yaml` with the static `PersistentVolume` description, and specify the `volumeHandle` parameter value in the file:

      {% cut "pv-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        name: s3-volume
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
          volumeHandle: "<static_bucket_name>/<optionally:_path_to_folder_inside_bucket>"
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

      In this example, GeeseFS settings for working with a bucket are changed as compared to `StorageClass`. The `--uid` option is added to them. It specifies the ID of the user being the owner of all files in storage: `1001`. For more information about setting up GeeseFS for a static `PersistentVolume`, see [this section](#spvc-csi-usage).

      {% endcut %}

   1. Create the `PersistentVolumeClaim`:

      ```bash
      kubectl create -f pvc-static.yaml
      ```

   1. Create a static `PersistentVolume`:

      ```bash
      kubectl create -f pv-static.yaml
      ```

   1. Make sure the `PersistentVolumeClaim` status changed to `Bound`:

      ```bash
      kubectl get pvc csi-s3-pvc-static
      ```

      Result:

      ```text
      NAME               STATUS  VOLUME                  CAPACITY  ACCESS MODES  STORAGECLASS  AGE
      csi-s3-pvc-static  Bound   <PersistentVolume_name>  10Gi      RWX           csi-s3        73m
      ```

1. Create a pod to test your static `PersistentVolume`.
   1. Create a file named `pod-static.yaml` with the pod description:

      {% cut "pod-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: Pod
      metadata:
        name: csi-s3-test-nginx-static
        namespace: default
      spec:
        containers:
        - name: csi-s3-test-nginx-static
          image: nginx
          volumeMounts:
            - mountPath: /usr/share/nginx/html/s3
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

1. Create the `/usr/share/nginx/html/s3/hello_world_static` file in the container. For this, [run the following command](https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/) on the pod:

    ```bash
    kubectl exec -ti csi-s3-test-nginx-static -- touch /usr/share/nginx/html/s3/hello_world_static
    ```

1. Make sure that the file is in the bucket:
   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click `<static_bucket_name>`. If you specified the path to the folder located inside the bucket in the static `PersistentVolume` description, you need to open that folder first.
