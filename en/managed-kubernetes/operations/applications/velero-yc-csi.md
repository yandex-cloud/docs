# Installing Velero

[Velero](https://velero.io/) is a backup, recovery, and migration tool for [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) objects, including [persistent volumes](../../concepts/volume.md#persistent-volume). With Velero, you can:
* Protect your data from loss using a flexible backup system.
* Recover a {{ managed-k8s-name }} cluster faster if it goes down.
* Transfer data across {{ managed-k8s-name }} clusters.

Velero uses the {{ CSI }} driver to [create backups](../../tutorials/backup.md) and restore persistent volumes from {{ yandex-cloud }} [disk snapshots](../../../compute/concepts/snapshot.md).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) needed to access [{{ objstorage-full-name }}](../../../storage/).

   ```bash
   yc iam service-account create --name <service_account_name>
   ```

1. [Assign the service account](../../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` role:

   ```bash
   yc resource-manager folder add-access-binding <folder_ID> \
     --role storage.editor \
     --subject serviceAccount:<service_account_ID>
   ```

1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the [service account](../../../iam/concepts/users/service-accounts.md) in JSON format and save it to the `sa-key.json` file:

   ```bash
   yc iam access-key create \
     --service-account-name=<service_account_name> \
     --format=json > sa-key.json
   ```

1. [Create an {{ objstorage-name }} bucket](../../../storage/operations/buckets/create.md).

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the {{ managed-k8s-name }} cluster name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [Velero](/marketplace/products/yc/velero-yc-csi) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Create a [namespace](../../concepts/index.md#namespace) called `velero`. The application uses it by default.

      {% note info %}

      If you select a different namespace, you will have to specify its name in each command.

      {% endnote %}

   * **Application name**: Enter a name for the application.
   * **{{ objstorage-name }} static access key**: Copy the contents of the `sa-key.json` file or create a new [access key](../../../iam/concepts/authorization/access-key.md) for the service account. The service account must have the `storage.editor` role.
   * **{{ objstorage-name }} bucket name**: Specify the name of the {{ objstorage-name }} bucket.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [kubectl setup](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Velero, run this command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_velero-yc-csi.helmChart.name }} \
        --version {{ mkt-k8s-key.yc_velero-yc-csi.helmChart.tag }} \
        --untar && \
   helm install \
        --namespace velero \
        --create-namespace \
        --set configuration.backupStorageLocation.bucket=<bucket_name> \
        --set-file serviceaccountawskeyvalue=<path_to_sa-key.json_file> \
        velero ./velero/
   ```

## See also {#see-also}

* [Velero documentation](https://velero.io/docs/v1.11/examples/).
