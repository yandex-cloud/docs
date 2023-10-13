# Installing Metrics Provider

Metrics Provider is an element connecting a {{ managed-k8s-name }} cluster object and [{{ monitoring-full-name }}](../../../monitoring/concepts/index.md).

The provider converts a request to get external metrics from a {{ k8s }} cluster object to the format required by {{ monitoring-name }} and also performs the reverse conversion: from {{ monitoring-name }} to a cluster object.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Create a [service account](../../../iam/operations/sa/create.md) with the `monitoring.viewer` role.
1. [Create an authorized access key](../../../iam/operations/authorized-key/create.md) for the [service account](../../../iam/concepts/users/service-accounts.md) in JSON format and save it to the `sa-key.json` file:

   ```bash
   yc iam key create \
     --service-account-name=<service account name> \
     --output=sa-key.json
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation** select [Metrics Provider](/marketplace/products/yc/metric-provider) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Folder ID**: Specify the [ID of the folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where Metrics Provider will run.
   * **Time window**: Specify the time window for which metrics will be collected (in `DdHhMmSs` format, such as `5d10h30m20s`).
   * (optional) **Disable decimation**: Select this option not to apply a data [decimation function](../../../monitoring/concepts/decimation.md).
   * (optional) **Aggregation function**: Select a data [aggregation function](../../../monitoring/concepts/querying.md#combine-functions). Default value: `AVG`.
   * (optional) **Data filling**: Select settings to fill in missing data:
     * `NULL`: Returns `null` as the metric value and `timestamp` as the timestamp value. Default value.
     * `NONE`: Returns no values.
     * `PREVIOUS`: Returns the value from the previous data point.
   * (optional) **Maximum number of points**: Specify the maximum number of points that will be returned in response to a request. The value of the parameter must be greater than `10`.
   * (optional) **Decimation time window**: Specify a time window (grid) in milliseconds. Used for decimation: Points inside the window are combined into a single one using the aggregation function. The value of the parameter must be greater than `0`.

     {% note info %}

     Select only one of the settings: either **Maximum number of points** or **Decimation time window**. Leave both the fields blank not to use either setting. For more information, see the [API documentation](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

   * **Secret Key**: Copy and paste the contents of the `sa-key.json` file or create a new service account access key. The service account must have the `monitoring.viewer` role.
1. Click **Install**.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Add the `metric-provider` repository:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_metric-provider.helmChart.name }} \
     --version={{ mkt-k8s-key.yc_metric-provider.helmChart.tag }} \
     --untar
   ```

1. Configure and install Metrics Provider:

   ```bash
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set yandexMetrics.folderId=<folder_ID> \
     --set window=<time_window> \
     --set-file yandexMetrics.token.serviceAccountJson=<service_account_static_key_file_path> \
     --set yandexMetrics.downsampling.gridAggregation=<aggregation_function> \
     --set yandexMetrics.downsampling.gapFilling=<data_filling> \
     --set yandexMetrics.downsampling.maxPoints=<maximum_number_of_points> \
     --set yandexMetrics.downsampling.gridInterval=<decimation_time_window> \
     --set yandexMetrics.downsampling.disabled=<true_or_false> \
     metric-provider ./chart/
   ```

   Required parameters:
   * `namespace`: [namespace](../../concepts/index.md#namespace) where the provider will be deployed.
   * `yandexMetrics.folderId`: [ID of the folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the provider will run.
   * `window`: Time window for which metrics will be collected (in `DdHhMmSs` format, such as `5d10h30m20s`).
   * `yandexMetrics.token.serviceAccountJson`: Path to the static access key of the service account with the `monitoring.viewer` role.

   Decimation parameters (`downsampling`). For the provider to work, you need to select at least one of the parameters below:
   * `yandexMetrics.downsampling.gridAggregation`: Data [aggregation function](../../../monitoring/concepts/querying.md#combine-functions). Default value: `AVG`.
   * `yandexMetrics.downsampling.gapFilling`: Settings for filling in missing data:
     * `NULL`: Returns `null` as the metric value and `timestamp` as the timestamp value.
     * `NONE`: Returns no values.
     * `PREVIOUS`: Returns the value from the previous data point.
   * `yandexMetrics.downsampling.maxPoints`: Maximum number of points to be received in response to a request. The value of the parameter must be greater than `10`.
   * `yandexMetrics.downsampling.gridInterval`: Time window (grid) in milliseconds. Used for decimation: Points inside the window are combined into a single one using the aggregation function. The value of the parameter must be greater than `0`.
   * `yandexMetrics.downsampling.disabled`: Disable data decimation.

     {% note info %}

     Use only one of the parameters: `yandexMetrics.downsampling.maxPoints`, `yandexMetrics.downsampling.gridInterval`, or `yandexMetrics.downsampling.disabled`. For more information about decimation parameters, see the [API documentation](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

## Use cases {#examples}

* [Metrics Provider for {{ managed-k8s-name }} auto scaling](../../tutorials/load-testing-grpc-autoscaling.md).