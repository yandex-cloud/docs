# Installing Loki

[Loki](https://grafana.com/oss/loki/) is a horizontally scalable, highly available, multi-tenant log aggregation and storage system. It doesn't index the contents of logs, but rather a set of labels for each log stream.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.uploader` and `storage.viewer` [roles](../../../iam/concepts/access-control/roles.md). You need it to access [{{ objstorage-full-name }}](../../../storage/).
1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the [service account](../../../iam/concepts/users/service-accounts.md) in JSON format and save it to the `sa-key.json` file:

   ```bash
   yc iam access-key create \
     --service-account-name=<service account name> \
     --format=json > sa-key.json
   ```

1. [Create a bucket in {{ objstorage-name }}](../../../storage/operations/buckets/create.md).

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Loki](/marketplace/products/yc/loki) and click **Use**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Loki.
   * **Application name**: Enter an application name.
   * **Bucket name**: Specify the name of the [bucket](../../../storage/concepts/bucket.md) in {{ objstorage-name }}.
   * **Static access key**: Copy the contents of the `sa-key.json` file or create a new access key for the service account. The service account must have the `storage.uploader` and `storage.viewer` roles.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.
1. Once deployed, Loki is available within the {{ managed-k8s-name }} cluster at `http://loki-gateway.<namespace>.svc.cluster.local`.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubectl installation](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Loki, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/grafana/loki/chart/loki \
     --version <Helm chart version> \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set storageConfig.aws.bucketnames=<{{ objstorage-name }} bucket name> \
     --set-file serviceaccountawskeyvalue=<path to service account static key file> \
     loki ./loki
   ```

   You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/loki#docker-images).

## See also {#see-also}

* [Grafana Loki documentation](https://grafana.com/docs/loki/latest/).