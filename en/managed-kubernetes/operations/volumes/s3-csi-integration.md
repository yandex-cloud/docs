# Integration with {{ objstorage-name }}

{{ CSI }} lets you dynamically reserve [buckets](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} and mount them to [pods](../../concepts/index.md#pod) in a cluster.

To configure bucket mounting to a {{ k8s }} pod:
1. [{#T}](#create-environment).
1. [{#T}](#test-csi).

## Set up a working environment {#create-environment}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.editor` role.
1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the service account.
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
     endpoint: https://storage.yandexcloud.net
   ```

1. Create a file with a description of the `storageclass.yaml` storage class:

   {% cut "storageclass.yaml" %}

   ```yaml
   ---
   kind: StorageClass
   apiVersion: storage.k8s.io/v1
   metadata:
     name: csi-s3
   provisioner: ru.yandex.s3.csi
   parameters:
     mounter: geesefs
     options: "--memory-limit 1000 --dir-mode 0777 --file-mode 0666"
     csi.storage.k8s.io/provisioner-secret-name: csi-s3-secret
     csi.storage.k8s.io/provisioner-secret-namespace: kube-system
     csi.storage.k8s.io/controller-publish-secret-name: csi-s3-secret
     csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
     csi.storage.k8s.io/node-stage-secret-name: csi-s3-secret
     csi.storage.k8s.io/node-stage-secret-namespace: kube-system
     csi.storage.k8s.io/node-publish-secret-name: csi-s3-secret
     csi.storage.k8s.io/node-publish-secret-namespace: kube-system
   ```

   {% endcut %}

   {% note tip %}

   When running the script, the {{ CSI }} driver creates a new bucket. To use an existing bucket, add the `bucket` field to the `parameters` section and specify the bucket name there.

   {% endnote %}

1. Create a `pvc.yaml` file that describes a Persistent Volume Claim with the new storage class:

   {% cut "pvc.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: csi-s3-pvc
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

1. Create a file named `pod.yaml` with a pod description:

   {% cut "pod.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: csi-s3-test-nginx
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
           claimName: csi-s3-pvc
           readOnly: false
   ```

   {% endcut %}

1. Clone the Github repository containing the current {{ CSI }} driver:

   ```bash
   git clone https://github.com/yandex-cloud/k8s-csi-s3.git
   ```

1. Create {{ CSI }} resources:

   ```bash
   kubectl create -f secret.yaml && \
   kubectl create -f k8s-csi-s3/deploy/kubernetes/provisioner.yaml && \
   kubectl create -f k8s-csi-s3/deploy/kubernetes/attacher.yaml && \
   kubectl create -f k8s-csi-s3/deploy/kubernetes/csi-s3.yaml && \
   kubectl create -f storageclass.yaml
   ```

   Expected execution result:

   ```text
   secret/csi-s3-secret created
   serviceaccount/csi-provisioner-sa created
   clusterrole.rbac.authorization.k8s.io/external-provisioner-runner created
   clusterrolebinding.rbac.authorization.k8s.io/csi-provisioner-role created
   service/csi-provisioner-s3 created
   statefulset.apps/csi-provisioner-s3 created
   serviceaccount/csi-attacher-sa created
   clusterrole.rbac.authorization.k8s.io/external-attacher-runner created
   clusterrolebinding.rbac.authorization.k8s.io/csi-attacher-role created
   service/csi-attacher-s3 created
   statefulset.apps/csi-attacher-s3 created
   serviceaccount/csi-s3 created
   clusterrole.rbac.authorization.k8s.io/csi-s3 created
   clusterrolebinding.rbac.authorization.k8s.io/csi-s3 created
   daemonset.apps/csi-s3 created
   storageclass.storage.k8s.io/csi-s3 created
   ```

## Check that the pod can access the bucket {#test-csi}

1. Create a Persistent Volume Claim:

   ```bash
   kubectl create -f pvc.yaml
   ```

1. Make sure that the Persistent Volume Claim status changed to `Bound`:

   ```bash
   kubectl get pvc csi-s3-pvc
   ```

   Expected execution result:

   ```text
   NAME        STATUS  VOLUME             CAPACITY  ACCESS MODES  STORAGECLASS  AGE
   csi-s3-pvc  Bound   pvc-<bucket name>  5Gi       RWX           csi-s3        73m
   ```

1. Create a pod to mount the bucket to:

   ```bash
   kubectl create -f pod.yaml
   ```

1. Make sure the pod status changed to `Running`:

   ```bash
   kubectl get pods
   ```

1. Check that the bucket is mounted to the pod and is available for writes:

   1. Connect to the pod console:

      ```bash
      kubectl exec -ti csi-s3-test-nginx bash
      ```

   1. Check that the bucket is mounted to the pod:

      ```bash
      mount | grep fuse
      ```

      Expected execution result:

      ```text
      pvc-<bucket name>: on /usr/share/nginx/html/s3 type fuse.geesefs (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other)
      ```

   1. Create a file on the pod:

      ```bash
      echo "Test message" > /usr/share/nginx/html/s3/test.txt
      ```

   1. Make sure that the file is in the bucket:
      1. Go to the folder page and select **{{ objstorage-name }}**.
      1. Click on `pvc-<bucket name>`.