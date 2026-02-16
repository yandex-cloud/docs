---
title: Installing KEDA with {{ monitoring-full-name }} support
description: In this tutorial, you will learn how to install KEDA with {{ monitoring-name }} support.
---

# Installing KEDA with {{ monitoring-full-name }} support


[KEDA](https://keda.sh) is an application that performs autoscaling of {{ k8s }} resources based on load monitoring.

KEDA application:

* Integrates {{ k8s }} autoscaling with {{ monitoring-full-name }}.
* Allows you to scale applications based on metrics from {{ monitoring-name }}, such as {{ alb-name }} metrics or managed databases.
* Supports time window configuration, as well as aggregation and processing of `NaN` values.

## Getting started {#before-you-begin}

1. [Create a service account](../../../iam/operations/sa/create.md):

   ```bash
   yc iam service-account create --name keda-sa
   ```

1. [Assign](../../../iam/operations/roles/grant.md) the `monitoring.viewer` role to the service account you created previously.

   ```bash
   yc resource-manager folder add-access-binding \
     --id <folder_ID> \
     --service-account-name keda-sa \
     --role monitoring.viewer
   ```

   You can fetch the folder ID with the [list of folders](../../../resource-manager/operations/folder/get-id.md).

1. [Create an authorized key](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the service account you created earlier and save it to a file named `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name keda-sa \
     --output authorized-key.json
   ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation from {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the [{{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [KEDA with {{ monitoring-full-name }} support](/marketplace/products/yc/keda) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), `keda-system`. If you keep the default namespace, KEDA may work incorrectly.
   * **Application name**: Specify the application name.
   * **Service account key**: Copy the contents of the `authorized-key.json` file to this field.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application status to change to `Deployed`.
1. Create the `ScaledObject` resource with these resource autoscaling settings:

   ```yaml
   apiVersion: keda.sh/v1alpha1
   kind: ScaledObject
   metadata:
     name: <resource_name>
   spec:
     scaleTargetRef:
       name: <autoscaling_resource_name>
     pollingInterval: <monitoring_event_check_interval>
     cooldownPeriod: <waiting_period_after_event>
     minReplicaCount: <minimum_number_of_replicas_for_autoscaling>
     maxReplicaCount: <maximum_number_of_replicas_for_autoscaling>
     triggers:
     - type: external
       metadata:
         scalerAddress: keda-external-scaler-yc.keda-system.svc.cluster.local:8080
         query: <Yandex_Monitoring_metrics_request>
         folderId: "<folder_ID>"
         targetValue: "<target_metric_value>"
         downsampling.disabled: <enable_data_decimation_mode>
         downsampling.gridAggregation: "<data_aggregation_function>"
         downsampling.gridInterval: "<decimation_time_window>"
         downsampling.maxPoints: <maximum_number_of_points>
         downsampling.gapFilling: <data_filling>

         timeWindow: "<time_interval_window>"
         timeWindowOffset: "<time_window_indent>"
    
         logLevel: "<logging_level>"
         logMetrics: "<allow_{{ monitoring-name}}_request_logging>"
         logAggregation: "<enable_data_aggregation_logging>"
   ```

   Required metadata in the `triggers` field:

   * `scalerAddress`: Autoscaling service address. It is always `keda-external-scaler-yc.keda-system.svc.cluster.local:8080`.
   * `query`: {{ monitoring-name }} metrics request.
   * `folderId`: [ID of the folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the provider will run.
   * `targetValue`: Target metric value, exceeding which adds a pod for the replica.

   Decimation (`downsampling`) parameters. For autoscaling to work, you need to select at least one of these parameters:
   * `downsampling.gridAggregation`: Data [aggregation function](../../../monitoring/concepts/querying.md#combine-functions). The possible values are: `MAX`, `MIN`, `SUM`, `AVG`, `LAST`, `COUNT`. The default value is `AVG`.
   * `downsampling.gapFilling`: Settings for filling in missing data:
     * `NULL`: Returns `null` as the metric value and `timestamp` as the timestamp value.
     * `NONE`: Returns no values.
     * `PREVIOUS`: Returns the value from the previous data point.
   * `downsampling.maxPoints`: Maximum number of points to receive in response to a request. The value of this parameter must be greater than `10`.
   * `downsampling.gridInterval`: Time window (grid) width in milliseconds. It is used for decimating: Data points within this time window are merged into a single value using the selected aggregation function. The value of this parameter must be greater than `0`.
   * `downsampling.disabled`: Disable data decimation. The possible values are: `true` or `false`.

     {% note info %}

     Use only one of these parameters: `downsampling.maxPoints`, `downsampling.gridInterval`, or `downsampling.disabled`. For more information about decimation parameters, see the [API documentation](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

   Time window parameters:
   * `timeWindow`: Time period for calculating the aggregation function (in `DdHhMmSs` format, e.g., `5d10h30m20s`).
   * `timeWindowOffset`: Delay in calculating the function in the time window.

   Logging parameters:
   * `logLevel`: Logging level. The possible values are: `debug`, `info`, `warn`, `error`, `none`. The default value is `info`.
   * `logMetrics`: Enable {{ monitoring-name }} request logging: `true` or `false`. The default value is `false`.
   * `logAggregation`: Enable data aggregation logging: `true` or `false`. The default value is `false`.

   For more information on the `ScaledObject` resource parameters, see the [project's guide on Github](https://github.com/yandex-cloud/yc-keda-external-scaler).

## Installation using a Helm chart {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with KEDA, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_keda.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_keda.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace keda-system \
     --create-namespace \
     --set-file secret.data=./authorized-key.json \
     --set keda.enabled=true \
     keda ./keda
   ```

   If you set `namespace` to the default namespace, KEDA may work incorrectly.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## An example of using KEDA {#keda-usage}

1. Deploy `nginx` in the {{ managed-k8s-name }} cluster.
1. Install [ALB Ingress Controller](alb-ingress-controller.md) and the `Ingress` resource for `nginx`.
1. Create the `ScaledObject` resource with these settings for autoscaling web application pods based on {{ alb-name }} metrics:

   ```yaml
   apiVersion: keda.sh/v1alpha1
   kind: ScaledObject
   metadata:
     name: demo-app-scaler
   spec:
     scaleTargetRef:
       name: <Deployment_resource_name>
     pollingInterval: 30
     cooldownPeriod: 60
     minReplicaCount: 1
     maxReplicaCount: 20
     triggers:
     - type: external
       metadata:
         scalerAddress: keda-external-scaler-yc.keda-system.svc.cluster.local:8080
         query: |
          alias(replace_nan(series_sum("load_balancer.requests_count_per_second"{
          service="application-load-balancer", 
          load_balancer="<load_balancer_ID>", 
          http_router="*", virtual_host="*", 
          route="<route_ID>", 
          backend_group="*", backend="*", 
          zone="*", code="total"}), 0), "Total requests count")
         folderId: "<folder_ID>"
         targetValue: "<target_metric_value>"
         downsampling.gridAggregation: "AVG"
         downsampling.gridInterval: "120000"

         timeWindow: "2m"
         timeWindowOffset: "30s"
    
         logLevel: "debug"
         logMetrics: "true"
         logAggregation: "true"
   ```

## See also {#see-also}

* [KEDA documentation](https://keda.sh/docs/)
* [KEDA with {{ monitoring-full-name }} support on GitHub](https://github.com/yandex-cloud/yc-keda-external-scaler)
