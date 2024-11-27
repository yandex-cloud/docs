# Installing Container Storage Interface for S3


[Container Storage Interface for S3](/marketplace/products/yc/csi-s3) (_CSI_) enables you to dynamically reserve [buckets](../../../storage/concepts/bucket.md) of S3-compatible storages and mount them in [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) [pods](../../concepts/index.md#pod) as [persistent volumes](../../concepts/volume.md#persistent-volume) (_PersistentVolume_). The connection is made using the [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) implementation of the [GeeseFS](https://github.com/yandex-cloud/geesefs) file system.

{% include [csi-s3-actual](../../../_includes/managed-kubernetes/csi-s3-actual.md) %}

You can install container Storage Interface for S3 in the following ways:
* [Using {{ marketplace-name }}](#marketplace-install) in the management console
* [Using a Helm chart from the {{ marketplace-name }} repository](#helm-install)
* [Using a Helm chart from the remote GitHub storage](#helm-github-install)

## Getting started {#before-you-begin}

1. [Create](../../../iam/operations/sa/create.md) a service account with the `storage.editor` [role](../../../storage/security/index.md#storage-editor).
1. [Create](../../../iam/operations/sa/create-access-key.md) a static access key for the service account. Save the key ID and secret key, you will need them when installing the application.
1. (Optional) To make new volumes fit into a single bucket with different prefixes, [create](../../../storage/operations/buckets/create.md) a {{ objstorage-full-name }} bucket. Save the bucket name, you will need it when installing the application. Skip this step if you need to create a separate bucket for each volume.

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation in the management console using {{ marketplace-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Container Storage Interface for S3](/marketplace/products/yc/csi-s3) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select the `kube-system` [namespace](../../concepts/index.md#namespace).
   * **Application name**: Specify the app name, e.g., `csi-s3`.
   * **Create storage class**: Select this option to create a new [storage class](../volumes/manage-storage-class.md) when deploying the application.
   * **Create secret**: Select this option to create a new secret for a storage class when installing the application.
   * **S3 key ID**: Copy the service account key ID into this field.
   * **S3 secret key**: Copy the service account secret key into this field.
   * **General S3 bucket for volumes**: Specify the name of the general bucket where [dynamically allocated volumes](../../concepts/volume.md#dynamic-provisioning) will be created. For CSI to create a new bucket for each volume, leave this field blank.
   * **S3 service address**: Address of the S3 service the application will use. The default address is `https://{{ s3-storage-host }}`.
   * **GeeseFS mounting options**: Mounting options for GeeseFS. For a complete list of options, see the [GeeseFS documentation](https://github.com/yandex-cloud/geesefs).
   * **Volume cleanup policy**: Select the policy to clean up PersistentVolumes when deleting PersistentVolumeClaims:
     * **Retain**: Retain a volume.
     * **Delete**: Delete a volume.
   * **Storage class name**: If you previously selected the **Create storage class** option, specify the name of the new storage class.
   * **Secret name**: If you previously selected the **Create secret** option, specify the name of the new secret to be created for the storage class. Otherwise, specify the name of the existing secret to be used for the storage class.
   * **Ignore all taints**: Select this option if you want the CSI driver used to mount the file system on nodes to ignore all taints set for the {{ managed-k8s-name }} cluster nodes.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart from the {{ marketplace-name }} repository {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with CSI, run the following command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_csi-s3.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_csi-s3.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace kube-system \
     --set secret.accessKey=<key_ID> \
     --set secret.secretKey=<secret_key> \
     csi-s3 ./csi-s3/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   You can also specify additional Container Storage Interface [parameters](#installation-parameters) for S3.

## Installation using a Helm chart from the GitHub repository {#helm-github-install}

The latest version of Container Storage Interface for S3 with {{ objstorage-name }} support is available in the [GitHub repository](https://github.com/yandex-cloud/k8s-csi-s3).

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with CSI, run the following command:

    ```bash
    helm repo add yandex-s3 https://yandex-cloud.github.io/k8s-csi-s3/charts && \
    helm repo update && \
    helm pull yandex-s3/csi-s3 --untar && \
    helm install \
      --namespace kube-system \
      --set secret.accessKey=<key_ID> \
      --set secret.secretKey=<secret_key> \
      csi-s3 ./csi-s3/
    ```

    You can also specify additional Container Storage Interface [parameters](#installation-parameters) for S3.

## Parameters for installation using a Helm chart {#installation-parameters}

When installing a Container Storage Interface for S3 application, the only required parameters are `secret.accessKey` and `secret.secretKey`. You can skip other parameters or redefine them in the install command using this key: `--set <parameter_name>=<new_value>`.

The list of parameters available for redefining and their default values are shown in the table below:

Parameter name | Description | Default value
--- | --- | ---
`storageClass.create` | Whether a new storage class needs to be created | `true`
`storageClass.name` | Storage class name | `csi-s3`
`storageClass.singleBucket` | Use a single bucket for all PersistentVolumeClaims |
`storageClass.mountOptions` | GeeseFS mounting options | `--memory-limit 1000 --dir-mode 0777 --file-mode 0666`
`storageClass.reclaimPolicy` | Volume cleanup policy | `Delete`
`storageClass.annotations` | Storage class description |
`secret.create` | Whether a new secret needs to be created | `true`
`secret.name` | Secret name | `csi-s3-secret`
`secret.accessKey` | Key ID |
`secret.secretKey` | Secret key |
`secret.endpoint` | S3 service address | `https://{{ s3-storage-host }}`

## See also {#see-also}

* [CSI specification](https://github.com/container-storage-interface/spec/blob/master/spec.md)
* [Container Storage Interface for S3 with {{ objstorage-name }} support in GitHub](https://github.com/yandex-cloud/k8s-csi-s3)
* [Integration with {{ objstorage-name }}](../volumes/s3-csi-integration.md)
* [CSI Use cases](../volumes/s3-csi-integration.md#examples)
* [Working with persistent and dynamic volumes in {{ k8s }}](../../concepts/volume.md)
