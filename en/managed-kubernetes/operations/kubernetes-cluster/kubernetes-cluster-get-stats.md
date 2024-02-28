# Monitoring cluster state {{ managed-k8s-name }}

{% include [metrics-resources-list](../../../_includes/managed-kubernetes/metrics-resources-list.md) %}

You can find metrics description in [{#T}](../../metrics.md).

## How to get statistics {#methods}

There are several alternative ways:

* [View the statistics in the management console](#console). It visualizes only the metrics for master hosts, nodes, and pods.
* [Open the {{ monitoring-name }} web interface](#monitoring). It visualizes all {{ managed-k8s-name }} metrics.
* [Upload metrics](../../../monitoring/operations/metric/get.md) using the {{ monitoring-name }} API. This method is suitable if you want to get only numerical values of metrics without visualization.
* [Install the Metrics Provider app](../applications/metrics-provider.md). You can use it to transmit metrics in two directions:

   * From {{ k8s }} objects to monitoring systems and [automatic scaling systems](../../concepts/autoscale.md)
   * From {{ monitoring-name }} to {{ k8s }} objects

* [Install the Prometheus Operator app](../applications/prometheus-operator.md) to work with the [{{ managed-prometheus-name }}](../../../monitoring/operations/prometheus/index.md) monitoring system. This way you can work with dashboards in [{{ grafana-name }}](https://grafana.com/grafana/) and take advantage of [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/).

## Viewing statistics in the management console {#console}

### Viewing master statistics {#master}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the {{ managed-k8s-name }} cluster page.
   1. In the **{{ ui-key.yacloud.common.overview }}** section, go to the **{{ ui-key.yacloud.k8s.cluster.overview.label_master-title }}** tab.

      Widgets with {{ managed-k8s-name }} master metrics will open. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-master-metrics).

   1. Specify the statistics period.

      The charts on the widgets will be automatically updated.

{% endlist %}

### Viewing node statistics {#node}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the {{ managed-k8s-name }} cluster page.
   1. In the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** section, go to the **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** tab.
   1. Open the page of the node for which you want to view statistics.
   1. Go to the **Monitoring** tab.

      Widgets with {{ managed-k8s-name }} node metrics will open. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-node-metrics).

      The widgets show only some of the available metrics. All metrics are available in the [{{ monitoring-name }} service](#monitoring).

   1. Specify the statistics period.

      The charts on the widgets will be automatically updated.

{% endlist %}

### Viewing pod statistics {#pod}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the {{ managed-k8s-name }} cluster page.
   1. In the left-hand panel, select **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
   1. Open the page of the pod for which you want to view statistics.
   1. Go to the **Monitoring** tab.

      Widgets with {{ managed-k8s-name }} pod metrics will open. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-pod-metrics).

      The widgets show only some of the available metrics. All metrics are available in the [{{ monitoring-name }} service](#monitoring).

   1. Specify the statistics period.

      The charts on the widgets will be automatically updated.

{% endlist %}

## Viewing statistics in {{ monitoring-name }} {#monitoring}

1. Open the [service home page]({{ link-monitoring }}) {{ monitoring-name }}.
1. In the panel on the left, select the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** section.
1. In the request field, click ![image](../../../_assets/console-icons/code.svg).
1. [Configure a request for statistics](#requests-in-monitoring).
1. Specify the statistics period.
1. Click **Run**.

### Requests for statistics in {{ monitoring-name }} {#requests-in-monitoring}

* For a {{ managed-k8s-name }} **container**:

   ```
   "<metric>"{folderId="<folder_ID>", service="managed-kubernetes", cluster_id="<cluster_ID>", container="<container_name>"}
   ```

   In the request, specify the following parameters:

   * `"<metric>"`: Container metric name, e.g., `"container.cpu.core_usage_time"`. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-container-metrics).
   * `folderId`: Folder ID.
   * `cluster_id`: {{ managed-k8s-name }} cluster name.
   * `container`: Name of the container you need the statistics for.

* For a {{ managed-k8s-name }} **master**:

   ```
   "<metric>"{folderId="<folder_ID>", service="managed-kubernetes", cluster_id="<cluster_name>"}
   ```

   In the request, specify the following parameters:

   * `"<metric>"`: Container metric name, e.g., `"master.cpu.utilization_percent"`. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-master-metrics).
   * `folderId`: Folder ID.
   * `cluster_id`: {{ managed-k8s-name }} cluster name.

* For a {{ managed-k8s-name }} **node**:

   ```
   "<metric>"{folderId="<folder_ID>", service="managed-kubernetes", cluster_id="<cluster_name>", node="<node_name>"}
   ```

   In the request, specify the following parameters:

   * `"<metric>"`: Container metric name, e.g., `"node.cpu.core_usage_time"`. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-node-metrics).
   * `folderId`: Folder ID.
   * `cluster_id`: {{ managed-k8s-name }} cluster name.
   * `node`: Name of the node you need the statistics for.

* For a {{ managed-k8s-name }} **pod**:

   ```
   "<metric>"{folderId="<folder_ID>", service="managed-kubernetes", cluster_id="<cluster_name>", pod="<pod_name>"}
   ```

   In the request, specify the following parameters:

   * `"<metric>"`: Container metric name, e.g., `"pod.memory.used_bytes"`. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-pod-metrics).
   * `folderId`: Folder ID.
   * `cluster_id`: {{ managed-k8s-name }} cluster name.
   * `pod`: Name of the pod you need the statistics for.

* For a {{ managed-k8s-name }} **persistent volume claim (PVC)**:

   ```
   "<metric>"{folderId="<folder_ID>", service="managed-kubernetes", cluster_id="<cluster_name>", persistentvolumeclaim="<PVC_name>"}
   ```

   In the request, specify the following parameters:

   * `"<metric>"`: Container metric name, e.g., `"pod.memory.used_bytes"`. The metrics are listed in the [reference](../../metrics.md#managed-kubernetes-persistent-volume-metrics).
   * `folderId`: Folder ID.
   * `cluster_id`: {{ managed-k8s-name }} cluster name.
   * `persistentvolumeclaim`: Name of the PVC you need the statistics for.
