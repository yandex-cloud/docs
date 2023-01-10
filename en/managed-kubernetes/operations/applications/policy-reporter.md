# Installing Policy Reporter

[Policy Reporter](https://kyverno.github.io/policy-reporter/) is designed for working with Kyverno policy results: [PolicyReports](https://kyverno.io/docs/policy-reports/). It also supports tools such as Falco, jsPolicy, Kube Bench, and Trivy. Policy Reporter can visualize results in a graphical view. For long-term storage or further uploading to the SIEM system, results can be exported to external storage, for example, [{{ objstorage-full-name }} (S3)](../../../storage/).

To use Policy Reporter, install [Kyverno](/marketplace/products/yc/kyverno) or another product that supports writing results to [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md). It is required for Policy Reporter to run.
1. [Create a static access key](https://cloud.yandex.ru/docs/iam/operations/sa/create-access-key) for the service account in JSON format and save it to the `sa-key.json` file:

   ```bash
   yc iam access-key create \
     --service-account-name=<service account name> \
     --format=json > sa-key.json
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Policy Reporter](/marketplace/products/yc/policy-reporter) and click **Use**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Policy Reporter.
   * **Application name**: Enter an application name.
   * **Cluster ID**: Select the desired {{ managed-k8s-name }} cluster from the list.
   * **Install Policy Reporter UI**: Enable to install the **Policy Reporter UI** component for displaying results in a graphical view.
   * **Export to {{ objstorage-name }}**: Enable to export results to {{ objstorage-name }}. You also need to fill in the additional fields:
     * **{{ objstorage-name }} bucket name**: Specify the name of the bucket in {{ objstorage-name }}. Leave the field blank if you don't need to save logs.
     * **{{ objstorage-name }} static access key**: Copy the contents of the `sa-key.json` file or create a new access key for the service account. The service account must have the `storage.uploader` role. Leave the field blank if you don't need to save logs.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [install-helm](../../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Policy Reporter, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/kyverno/chart/policy-reporter \
     --version 2.9.0-1 \
     --untar && \
   helm upgrade --install \
     --namespace <namespace> \
     --create-namespace \
     --set clusterId=<cluster ID> \
     --set ui.enabled=<enable Policy Reporter UI: true or false> \
     --set target.s3.enabled=<export to {{ objstorage-name }}: true or false> \
     --set target.s3.bucket=<{{ objstorage-name }} bucket name> \
     --set-file serviceaccountawskeyvalue=<path to service account static key file> \
     policy-reporter ./policy-reporter
   ```

   The `target.s3.bucket` and `serviceaccountawskeyvalue` parameters are only required if export to {{ objstorage-name }} is enabled (`target.s3.enabled=true`).

## See also {#see-also}

* [Policy Reporter documentation](https://kyverno.github.io/policy-reporter/)
* [Example in the {{ yandex-cloud }} Solution Library: Analyzing {{ k8s }} security logs in ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/export-auditlogs-to-ELK_k8s/README.md)