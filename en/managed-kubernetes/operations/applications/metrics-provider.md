# Installing {{ MP }}

{{ MP }} streams metrics of [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) objects to monitoring systems and [auto scaling systems](../../concepts/autoscale.md). You can also stream metrics in the opposite direction. For example, cluster objects can receive metrics from [{{ monitoring-full-name }}](../../../monitoring/concepts/index.md).

The provider transforms the request to collect external metrics from a {{ managed-k8s-name }} cluster object into the required {{ monitoring-name }} format, and also performs the reverse transformation: from {{ monitoring-name }} to the cluster object.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `monitoring.viewer` [role](../../../iam/concepts/access-control/roles.md).
1. [Create an authorized access key](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the [service account](../../../iam/concepts/users/service-accounts.md) in JSON format and save it to the `sa-key.json` file:

   ```bash
   yc iam key create \
     --service-account-name=<service_account_name> \
     --output=sa-key.json
   ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [{{ MP }}](/marketplace/products/yc/metric-provider) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `metrics-provider-space`. If you leave the default namespace, {{ MP }} may work incorrectly.
   * **Application name**: Specify the application name.
   * **Folder ID**: Specify the [ID of the folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where {{ MP }} will run.
   * **Time window**: Specify the time window to collect metrics for (in `DdHhMmSs` format, e.g., `5d10h30m20s`).
   * (Optional) **Disable decimation**: Select this option not to apply a data [decimation function](../../../monitoring/concepts/decimation.md).
   * (Optional) **Aggregation function**: Select a data [aggregation function](../../../monitoring/concepts/querying.md#combine-functions). The default value is `AVG`.
   * (Optional) **Data filling**: Configure filling in missing data:
     * `NULL`: Returns `null` as the metric value and `timestamp` as the timestamp value. Default.
     * `NONE`: Returns no values.
     * `PREVIOUS`: Returns the value from the previous data point.
   * (Optional) **Maximum number of points**: Specify the maximum number of points that will be returned in response to a request. The value of this parameter must be greater than `10`.
   * (Optional) **Decimation time window**: Specify a time window (grid) in milliseconds. It is used for decimation: points inside the window are combined into a single one using the aggregation function. The value of the parameter must be greater than `0`.

     {% note info %}

     Select only one of the settings: either **Maximum number of points** or **Decimation time window**. Leave both the fields blank not to use either setting. For more information, see the [API documentation](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

   * **Secret Key**: Copy and paste the contents of the `sa-key.json` file or create a new service account access key. The service account must have the `monitoring.viewer` role.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Add a repository named `metric-provider`:

   ```bash
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_metric-provider.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_metric-provider.helmChart.tag }} \
     --untar
   ```

   If you set `namespace` to the default namespace, {{ MP }} may work incorrectly. We recommend you to specify a value different from all existing namespaces (e.g., `metrics-provider-space`).

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Set up and install {{ MP }}:

   ```bash
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set yandexMetrics.folderId=<folder_ID> \
     --set window=<time_window> \
     --set-file yandexMetrics.token.serviceAccountJson=<path_to_file_with_service_account_authorized_key> \
     --set yandexMetrics.downsampling.gridAggregation=<aggregation_function> \
     --set yandexMetrics.downsampling.gapFilling=<data_filling> \
     --set yandexMetrics.downsampling.maxPoints=<maximum_number_of_points> \
     --set yandexMetrics.downsampling.gridInterval=<decimation_time_window> \
     --set yandexMetrics.downsampling.disabled=<data_decimation_mode> \
     metric-provider ./metric-provider/
   ```

   Required parameters:
   * `--namespace`: [Namespace](../../concepts/index.md#namespace) where the provider will be deployed.
   * `yandexMetrics.folderId`: [ID of the folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the provider will run.
   * `window`: Specify the time window to collect metrics for (in `DdHhMmSs` format, e.g., `5d10h30m20s`).
   * `yandexMetrics.token.serviceAccountJson`: Path to the file with the authorized key of the service account with the `monitoring.viewer` role.

   Decimation (`downsampling`) parameters. For the provider to work, you need to select at least one of the parameters below:
   * `yandexMetrics.downsampling.gridAggregation`: Data [aggregation function](../../../monitoring/concepts/querying.md#combine-functions). The default value is `AVG`.
   * `yandexMetrics.downsampling.gapFilling`: Settings for filling in missing data:
     * `NULL`: Returns `null` as the metric value and `timestamp` as the timestamp value.
     * `NONE`: Returns no values.
     * `PREVIOUS`: Returns the value from the previous data point.
   * `yandexMetrics.downsampling.maxPoints`: Maximum number of points to receive in response to a request. The value of this parameter must be greater than `10`.
   * `yandexMetrics.downsampling.gridInterval`: Time window (grid) in milliseconds. It is used for decimation: points inside the window are combined into a single one using the aggregation function. The value of this parameter must be greater than `0`.
   * `yandexMetrics.downsampling.disabled`: Disable data decimation. Possible values: `true` or `false`.

     {% note info %}

     Use only one of these parameters: `yandexMetrics.downsampling.maxPoints`, `yandexMetrics.downsampling.gridInterval`, or `yandexMetrics.downsampling.disabled`. For more information about decimation parameters, see the [API documentation](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

## Use cases {#examples}

* [{{ MP }} for {{ managed-k8s-name }} autoscaling](../../tutorials/load-testing-grpc-autoscaling.md)
* [{#T}](../../tutorials/marketplace/metrics-provider.md)
