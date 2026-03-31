---
title: Setting up a demo app to collect app telemetry in a cluster
description: How to set up a demo app in a {{ k8s }} cluster and send telemetry to {{ monium-name }}.
---

# Setting up a demo app and collecting telemetry in {{ k8s }}

You will set up a demo app in a {{ k8s }} cluster and send the app's telemetry data to {{ monium-name }}. This guide uses {{ managed-k8s-name }} to deploy a cluster, but you can any of your {{ k8s }} clusters.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources you need for {{ monium-name }} includes:
* Fee for using a [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master) (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for [{{ managed-k8s-name }} node group's](../../managed-kubernetes/concepts/index.md#node-group) [computing resources](../../compute/concepts/vm-platforms.md) and [disks](../../compute/concepts/disk.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using {{ monium-name }} (see [{{ monium-name }} pricing](../pricing.md)).

## Setting up a cluster {#preparation}

{% list tabs group=instructions %}

- Management console {#console}

  1. Create a [{{ k8s }} cluster](../../managed-kubernetes/quickstart.md).

  1. {% include [helm-install](../../_includes/managed-kubernetes/helm-install.md) %}

  1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}

  1. Add the OpenTelemetry Helm charts repository:
      
      ```bash
      helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
      helm repo update
      ```

      From this repository you will install OpenTelemetry Collector, which will collect telemetry from your {{ k8s }} cluster apps, plus OpenTelemetry Demo, an online store demo app.

  1. Create a [service account](../../iam/operations/sa/create.md) with the `monium.telemetry.writer` role and an [API key](../../iam/operations/authentication/manage-api-keys.md) with the `yc.monium.telemetry.write` scope.

  1. Add the API key to the cluster secrets:
      
      ```bash
      export NS=default
      kubectl -n $NS create secret generic monium-secrets \
      --from-literal=MONIUM_API_KEY='<API_key>'
      ```

{% endlist %}

## Delivering and viewing telemetry {#view-telemetry}

1. Create a file named `otel-demo-monium.yml` with the following configuration:

    ```yaml
    # https://github.com/open-telemetry/opentelemetry-helm-charts/blob/main/charts/opentelemetry-demo/README.md
    opentelemetry-collector:
    extraEnvsFrom:
        - secretRef:
            name: monium-secrets

    config:
        receivers:
        # Collection of grafana metrics, not configured in the demo app by default
        prometheus:
            config:
            scrape_configs:
                - job_name: "grafana"
                kubernetes_sd_configs:
                    - role: pod
                relabel_configs:
                    # Filtering by label (keep grafana only)
                    - source_labels: [__meta_kubernetes_pod_label_app_kubernetes_io_name]
                    action: keep
                    regex: grafana

                    # Replacing the address with the pod IP and port 3000
                    - source_labels: [__address__]
                    action: replace
                    regex: "([^:]+)(?::\\d+)?"
                    replacement: "$1:3000"
                    target_label: __address__

                    # Specifying the path to the metrics
                    - action: replace
                    target_label: __metrics_path__
                    replacement: /grafana/metrics

        exporters:
        debug:
            verbosity: detailed

        otlp/monium:
            compression: none
            endpoint: {{ api-host-monium }}:443
            headers:
            Authorization: "Api-Key ${env:MONIUM_API_KEY}"
            x-monium-project: folder__<folder_ID>

        service:
        extensions: [health_check]
        pipelines:
            traces:
            receivers: [otlp]
            exporters: [otlp, spanmetrics, otlp/monium]

            logs:
            receivers: [otlp]
            exporters: [opensearch, otlp/monium]

            metrics:
            receivers: [httpcheck/frontend-proxy, otlp, prometheus, redis, spanmetrics]
            exporters: [otlphttp/prometheus, otlp/monium]

        telemetry:
            resource:
            service: otel-collector
            metrics:
            level: detailed
            readers:
                - periodic:
                    exporter:
                    otlp:
                        endpoint: ${env:MY_POD_IP}:4317
                        protocol: grpc
                    interval: 10000
                    timeout: 5000
    ```

1. Install the demo app to deliver logs, metrics, and traces to {{ monium-name }}:

    ```bash
    helm uninstall otel-demo-monium -n $NS --ignore-not-found
    helm install otel-demo-monium open-telemetry/opentelemetry-demo \
    --version 0.37 \
    -n $NS \
    --values otel-demo-monium.yml
    ```
1. Generate traffic to send telemetry.

     1. Configure port forwarding for `frontend-proxy`:

        ```bash
        kubectl --namespace default port-forward svc/frontend-proxy 8080:8080
        ```
     1. In your browser, open the online store at `http://localhost:8080/` and simulate user activity. For example, add an item to the cart.

## View telemetry data {#view-telemetry}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}** on the left.
  1. In the list, select the shard with the name of the service operating within the online store, e.g., `cart` or `product-catalog`.

     The shard name follows the `<project_name>_<cluster_name>_<service_name>` format, e.g., `folder__{{ folder-id-example }}_default_cart`.
  
  1. To view a specific data type, on the left, select:

     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
       
       In the query string, select the following one by one
             * `project=folder__<folder_ID>`.
             * `cluster=default`.
             * `service=cart`.
             * and click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

       {% cut "Example of a chart with metrics" %}
       
       ![image](../../_assets/monium/shop-metrics.png)
       
       {% endcut %}

       More on [metrics](../operations/metric/metric-explorer.md).

     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
     
       In the query string, select `project`, `cluster`, and `service` one by one and click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

       {% cut "Example of a page with logs" %}
       
       ![image](../../_assets/monium/shop-logs.png)
       
       {% endcut %}

       More on [logs](../logs/).
     
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.

       In the query string, select `project` and `service` one by one and click **Execute**.

       {% cut "Example of a page with traces" %}
       
       ![image](../../_assets/monium/shop-traces.png)
       
       {% endcut %}

       More on [traces](../traces/operations/traces-explorer.md).

{% endlist %}

To use telemetry data, create a [dashboard](../operations/dashboard/create.md) and [alerts](../operations/alert/create-alert.md).

## If {{ monium-name }} does not show telemetry {#troubleshooting}

* [Make sure](#preparation) the service account and API key have the required roles and scopes.

* Check that the secrets feature the correct API key:

    ```bash
    kubectl get secret monium-secrets -n $NS -o jsonpath='{.data.MONIUM_API_KEY}' | base64 -d
    ```

* Check the OTel Collector logs:

    ```bash
    kubectl logs -l app.kubernetes.io/name=opentelemetry-collector -n $NS
    ```

* Make sure the {{ monium-name }} endpoint is accessible:

    ```bash
    kubectl run -it --rm debug --image=curlimages/curl --restart=Never -- \
    curl -v https://ingest.monium.yandex.cloud
    ```

