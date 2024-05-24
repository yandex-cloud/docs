# Installing Loki


[Loki](https://grafana.com/oss/loki/) is a horizontally scalable, highly available, multi-tenant log aggregation and storage system. It indexes a set of labels for each log stream rather than the contents of logs.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Prepare for Loki installation:

1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.uploader` and `storage.viewer` [roles](../../../iam/concepts/access-control/roles.md). You need it to access [{{ objstorage-full-name }}](../../../storage/).
1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the [service account](../../../iam/concepts/users/service-accounts.md):

   * If you install Loki using [{{ marketplace-full-name }}](#marketplace-install), create a static access key in JSON format and save it to the `sa-key.json` file:

     ```bash
     yc iam access-key create \
       --service-account-name=<service_account_name> \
       --format=json > sa-key.json
     ```

   * If you use a [Helm chart](#helm-install) to install Loki, run the following command and save the obtained `key_id` and `secret` key:

      ```bash
      yc iam access-key create \
         --service-account-name=<service_account_name>
      ```

1. [Create a bucket](../../../storage/operations/buckets/create.md) with restricted access in {{ objstorage-name }}.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [Loki](/marketplace/products/yc/loki) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:

   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Loki.
   * **Application name**: Enter a name for the application.
   * **Bucket name**: Specify the name of the [bucket](../../../storage/concepts/bucket.md) in {{ objstorage-name }}.
   * **Static access key**: Paste the contents of the `sa-key.json` file.
   * **Install Promtail**: Leave the option enabled to deliver local logs to the Grafana Loki instance using the [Promtail agent](https://grafana.com/docs/loki/latest/clients/promtail/). This agent is usually used for applications that require regular monitoring.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.
1. Once deployed, Loki is available within the {{ managed-k8s-name }} cluster at `http://loki-gateway.<namespace>.svc.cluster.local`.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubectl installation](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Loki, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_loki.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_loki.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set loki-distributed.loki.storageConfig.aws.bucketnames=<Object_Storage_bucket_name> \
     --set loki-distributed.serviceaccountawskeyvalue_generated.accessKeyID=<service_account_key_ID> \
     --set loki-distributed.serviceaccountawskeyvalue_generated.secretAccessKey=<service_account_secret_key> \
     loki ./loki/
   ```

## See also {#see-also}

* [Grafana Loki documentation](https://grafana.com/docs/loki/latest/).