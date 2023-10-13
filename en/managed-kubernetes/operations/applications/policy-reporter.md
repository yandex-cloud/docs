# Installing Policy Reporter

[Policy Reporter](https://kyverno.github.io/policy-reporter/) is designed for working with Kyverno policy results: [PolicyReports](https://kyverno.io/docs/policy-reports/). It also supports tools such as Falco, jsPolicy, Kube Bench, and Trivy. Policy Reporter can visualize results in a graphical view. For long-term storage or further uploading to the SIEM system, results can be exported to external storage, such as [{{ objstorage-full-name }} (S3)](../../../storage/) or [{{ yds-full-name }}](../../../data-streams/).

{% note warning %}

To use Policy Reporter, install [Kyverno](/marketplace/products/yc/kyverno) or another product that supports writing results to [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

{% endnote %}

## Getting started {#before-you-begin}

To export policy results, set up external storage:

* {{ objstorage-name }}:

   1. {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.uploader` [role](../../../iam/concepts/access-control/roles.md). You need it to access {{ objstorage-name }}.
   1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the [service account](../../../iam/concepts/users/service-accounts.md) in JSON format and save it to the `sa-key.json` file:

      ```bash
      yc iam access-key create \
        --service-account-name=<service_account_name> \
        --format=json > sa-key.json
      ```

   1. [Create a bucket](../../../storage/operations/buckets/create.md) with restricted access in {{ objstorage-name }}.

* {{ yds-name }}:

   [Create a data stream](../../../data-streams/quickstart/create-stream.md).

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Policy Reporter](/marketplace/products/yc/policy-reporter) and click **Use**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Policy Reporter.
   * **Application name**: Enter an application name.
   * **Cluster ID**: Select the desired {{ managed-k8s-name }} cluster from the list.
   * **Install Policy Reporter UI**: Enable to install the **Policy Reporter UI** component for displaying results in a graphical view.
   * **Export to {{ objstorage-name }}**: Enable to export results to {{ objstorage-name }}. You also need to fill in the additional fields:
      * **{{ objstorage-name }} bucket name**: Specify the name of the [bucket](../../../storage/concepts/bucket.md) in {{ objstorage-name }}.
      * **{{ objstorage-name }} static access key**: Copy the contents of the `sa-key.json` file or create a new access key for the service account. The service account must have the `storage.uploader` role.
   * **Export to YDS**: Enable to export results to {{ yds-name }}. You also need to fill in the additional fields:
      * **Endpoint YDS**: Specify the {{ yds-name }} [stream](../../../data-streams/concepts/glossary.md#stream-concepts) endpoint.
      * **YDS stream name**: Specify the {{ yds-name }} stream name.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [install-helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Policy Reporter, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_policy-reporter.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_policy-reporter.helmChart.tag }} \
     --untar && \
   helm upgrade --install \
     --namespace <namespace> \
     --create-namespace \
     --set clusterId=<cluster_ID> \
     --set ui.enabled=<enable_Policy_Reporter_UI_(true_or_false)> \
     --set target.s3.enabled=<export_to_Object_Storage_(true_or_false)> \
     --set target.s3.bucket=<Object_Storage_bucket_name> \
     --set-file serviceaccountawskeyvalue=<path_to_service_account_static_key_file> \
     --set target.kinesis.enabled=<export_to_Data_Streams_(true_or_false)> \
     --set target.kinesis.endpoint=<Data_Streams_stream_endpoint> \
     --set target.kinesis.streamName=<Data_Streams_stream_name> \
     policy-reporter ./policy-reporter/
   ```

   The `target.s3.bucket` and `serviceaccountawskeyvalue` parameters are only required if export to {{ objstorage-name }} is enabled (`target.s3.enabled=true`), and the `target.kinesis.endpoint` and `target.kinesis.streamName` parameters are required if export to {{ yds-name }} is enabled (`target.kinesis.enabled=true`).

## See also {#see-also}

* [Policy Reporter documentation](https://kyverno.github.io/policy-reporter/).
* [Example in the {{ yandex-cloud }} Solution Library: Analyzing {{ k8s }} security logs in ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/export-auditlogs-to-ELK_k8s/README.md).