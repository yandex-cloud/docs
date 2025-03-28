---
title: Installing Policy Reporter
description: Follow this guide to install Policy Reporter.
---

# Installing Policy Reporter


[Policy Reporter](https://kyverno.github.io/policy-reporter/) is designed for working with Kyverno policy results: [PolicyReports](https://kyverno.io/docs/policy-reports/). It also supports such tools as Falco, jsPolicy, Kube Bench, and Trivy. Policy Reporter provides graphical visualization of results. For long-term storage or further uploading to the SIEM system, results can be exported to external storage, e.g., [{{ objstorage-full-name }} (S3)](../../../storage/) or [{{ yds-full-name }}](../../../data-streams/).

{% note warning %}

To use Policy Reporter, install [Kyverno](/marketplace/products/yc/kyverno) or another product that supports writing results to [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

{% endnote %}

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. To export policy results, set up external storage:

    * **{{ objstorage-name }}**

      1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.uploader` [role](../../../iam/concepts/access-control/roles.md). You need it to access {{ objstorage-name }}.
      1. [Create a static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the [service account](../../../iam/concepts/users/service-accounts.md) in JSON format and save it to the `sa-key.json` file:

         ```bash
         yc iam access-key create \
           --service-account-name=<service_account_name> \
           --format=json > sa-key.json
         ```

      1. [Create a bucket](../../../storage/operations/buckets/create.md) with restricted access in {{ objstorage-name }}.

    * **{{ yds-name }}**

      [Create a data stream](../../../data-streams/quickstart/create-stream.md).

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Policy Reporter](/marketplace/products/yc/policy-reporter) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Policy Reporter.
   * **Application name**: Specify the app name.
   * **Cluster ID**: Select the desired {{ managed-k8s-name }} cluster from the list.
   * **Install Policy Reporter UI**: Enable to install the **Policy Reporter UI** component for displaying results in a graphical view.
   * **Export to {{ objstorage-name }}**: Enable this option to export results to {{ objstorage-name }}. You also need to fill in the additional fields:
     * **{{ objstorage-name }} bucket name**: Specify the name of the [bucket](../../../storage/concepts/bucket.md) in {{ objstorage-name }}.
     * **{{ objstorage-name }} static access key**: Copy the contents of the `sa-key.json` file or create a new access key for the service account. The service account must have the `storage.uploader` role.
   * **Export to YDS**: Enable this option to export results to {{ yds-name }}. You also need to fill in the additional fields:
     * **Endpoint YDS**: Specify the {{ yds-name }} [stream](../../../data-streams/concepts/glossary.md#stream-concepts) endpoint.
     * **YDS stream name**: Specify the {{ yds-name }} stream name.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [install-helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Policy Reporter, run the following command, specifying the parameters of the resources you created [earlier](#before-you-begin):

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_policy-reporter.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_policy-reporter.helmChart.tag }} \
     --untar && \
   helm upgrade --install \
     --namespace <namespace> \
     --create-namespace \
     --set clusterId=<cluster_ID> \
     --set ui.enabled=<enable_Policy_Reporter_UI> \
     --set target.s3.enabled=<export_to_Object_Storage> \
     --set target.s3.bucket=<Object_Storage_bucket_name> \
     --set-file serviceaccountawskeyvalue=<path_to_static_key_file_of_service_account> \
     --set target.kinesis.enabled=<export_to_Data_Streams> \
     --set target.kinesis.endpoint=<Data_Streams_stream_endpoint> \
     --set target.kinesis.streamName=<Data_Streams_stream_name> \
     policy-reporter ./policy-reporter/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   Command parameters:

   * `ui.enabled`: Enabling Policy Reporter UI. The possible values are `true` or `false`.
   * `target.s3.enabled`: Exporting to {{ objstorage-name }}. The possible values are `true` or `false`.
   * `target.kinesis.enabled`: Exporting to {{ yds-name }}. The possible values are `true` or `false`.

   The `target.s3.bucket` and `serviceaccountawskeyvalue` parameters are only required if export to {{ objstorage-name }} is enabled (`target.s3.enabled=true`), while the `target.kinesis.endpoint` and `target.kinesis.streamName` parameters, if export to {{ yds-name }} is enabled (`target.kinesis.enabled=true`).

## Testing the app {#check}

1. Set up the Kyverno Application & Kyverno Policies app in the {{ managed-k8s-name }} cluster and follow this [guide](../../tutorials/marketplace/kyverno.md) to create a test policy.
1. [Connect to the Policy Reporter UI](https://kyverno.github.io/policy-reporter/#core--policy-reporter-ui--kyverno-plugin) to analyze and visualize PolicyReports or ensure that data is received by {{ objstorage-name }} or {{ yds-name }}.

## Use cases {#examples}

* [{#T}](../../tutorials/marketplace/kyverno.md)
* [{#T}](../../tutorials/sign-cr-with-cosign.md)

## See also {#see-also}

* [Policy Reporter documentation](https://kyverno.github.io/policy-reporter/).
* [Example in the {{ yandex-cloud }} Solution Library: Analyzing {{ k8s }} security logs in ELK](https://github.com/yandex-cloud-examples/yc-export-mk8s-auditlogs-to-elk/blob/main/README.md).
