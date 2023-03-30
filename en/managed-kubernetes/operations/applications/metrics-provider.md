# Installing Metrics Provider

Metrics Provider is an element connecting a {{ managed-k8s-name }} cluster object and [{{ monitoring-full-name }}](../../../monitoring/concepts/index.md).

The provider converts a request to get external metrics from a {{ k8s }} cluster object to the format required by {{ monitoring-name }} and also performs the reverse conversion: from {{ monitoring-name }} to a cluster object.

## Creating a service account and a static access key {#create-sa-key}

For the provider to work, you need to create a [service account](../../../iam/concepts/users/service-accounts.md) and get a service account key.
1. Install the [`jq` JSON stream processor](https://stedolan.github.io/jq/):

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Create a [service account](../../../iam/operations/sa/create.md) with the `monitoring.viewer` role.
1. Create a service account key and save it to your local machine:

   ```bash
   yc iam key create \
     --service-account-id <service account ID> \
     --folder-id <folder ID> \
     --cloud-id <cloud ID> \
     --description metrics-provider \
     --format json \
     -o key.json
   ```

   Result:

   ```text
   {
     "id": "<service account key ID>",
     "service_account_id": "<service account ID>",
     "created_at": "2022-01-27T03:29:45.139311367Z",
     "description": "metrics-provider",
     "key_algorithm": "RSA_2048"
   }
   ```

   {% note info %}

   Save the service account and the service account key IDs: you will use them for subsequent installation steps.

   {% endnote %}

1. Save the service account key in Base64 format:

   ```bash
   jq -r .private_key key.json > key.pem
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

   * **Service account ID**: Specify the ID of the [previously created](#create-sa-key) service account.
   * **Service account key ID**: Specify the service account key ID.
   * **Service account private key**: Copy the contents of the `key.pem` file to this field.
1. Click **Install**.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Add the `metric-provider` repository:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/metric-provider/chart \
     --version=<Helm chart version> \
     --untar
   ```

   You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/metric-provider#docker-images).
1. Configure and install Metrics Provider:

   ```bash
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set folderId=<folder ID> \
     --set window=<time window> \
     --set-file saKeySecretKey=key.json \
     --set gridAggregation=<aggregation function> \
     --set gapFilling=<data filling> \
     --set maxPoints=<maximum number of points> \
     --set gridInterval=<decimation time window> \
     --set disabled=<true or false> \
     metric-provider ./chart/
   ```

   Required parameters:
   * `namespace`: [namespace](../../concepts/index.md#namespace) where the provider will be deployed.
   * `folderId`: [ID of the folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), where the provider will run.
   * `window`: Time window for which metrics will be collected (in `DdHhMmSs` format, such as `5d10h30m20s`).

   Decimation parameters (`downsampling`). For the provider to work, you need to select at least one of the parameters below:
   * `gridAggregation`: Data [aggregation function](../../../monitoring/concepts/querying.md#combine-functions). Default value: `AVG`.
   * `gapFilling`: Settings for filling in missing data:
     * `NULL`: Returns `null` as the metric value and `timestamp` as the timestamp value.
     * `NONE`: Returns no values.
     * `PREVIOUS`: Returns the value from the previous data point.
   * `maxPoints`: Maximum number of points to be received in response to a request. The value of the parameter must be greater than `10`.
   * `gridInterval`: Time window (grid) in milliseconds. Used for decimation: Points inside the window are combined into a single one using the aggregation function. The value of the parameter must be greater than `0`.
   * `disabled`: Disable data decimation.

     {% note info %}

     Use only one of the parameters: `maxPoints`, `gridInterval`, or `disabled`. For more information about decimation parameters, see the [API documentation](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

## Use cases {#examples}

* [Metrics Provider for {{ managed-k8s-name }} auto scaling](../../tutorials/load-testing-grpc-autoscaling.md).