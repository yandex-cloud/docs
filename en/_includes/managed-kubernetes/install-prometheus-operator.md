Prometheus Operator with {{ monitoring-full-name }} support makes it easy to install and manage the [{{ managed-prometheus-full-name }}](../../monitoring/operations/prometheus/index.md) monitoring system. You can use it to collect, store, and read metrics from your containers, applications, and infrastructure. The system uses the {{ prometheus-name }} data model and the [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/) query language. This allows you to work with dashboards existing in [{{ grafana-name }}](https://grafana.com/grafana/).

{% include [preview-pp](../preview-pp.md) %}

## Getting started {#before-you-begin}

1. [Request](../../monitoring/operations/prometheus/index.md#access) access to {{ managed-prometheus-name }} and wait until your request is approved.
1. On the {{ monitoring-full-name }} [home page]({{ link-monitoring }}), select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** in the left-hand panel.
1. In the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.write }}** tab, find the URL of the endpoint to write metrics to:

   ```text
   https://{{ api-host-monitoring-1 }}/prometheus/workspaces/<Prometheus_Workspace_ID>/api/v1/write
   ```

   Save the Prometheus Workspace ID (a substring in `mon*****************` format); you will need it later during setup.

1. [Create](../../iam/operations/sa/create.md) a service account for Prometheus Operator.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the service account the `monitoring.editor` [role](../../monitoring/security/index.md#monitoring-editor).
1. [Create](../../iam/operations/api-key/create.md) an API key for the service account and save its secret part.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the {{ k8s }} cluster name and select the ![image](../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Prometheus Operator with {{ monitoring-full-name }} support](/marketplace/products/yc/prometheus-operator) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../managed-kubernetes/concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter a name for the application.
   * **Workspace ID**: Enter the Prometheus Workspace ID (`mon*****************`).
   * **API key**: Enter the secret part of the API key.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Установка Helm](../managed-kubernetes/helm-install.md) %}
1. {% include [Настройка kubectl](../managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Prometheus Operator, run this command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_prometheus-operator.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_prometheus-operator.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace_for_Prometheus_Operator> \
     --create-namespace \
     --set prometheusWorkspaceId=<Prometheus_Workspace_ID> \
     --set apiKeySecret=<secret_part_of_API_key> \
     prometheus ./kube-prometheus-stack/
   ```

   The command will also create a new namespace required for Prometheus Operator.

1. Make sure the Prometheus Operator pods have changed their status to `Running`:

   ```bash
   kubectl get pods --namespace=<Prometheus_Operator_namespace> \
     | grep prometheus
   ```

## Connecting to a {{ grafana-name }} dashboard

To connect to a {{ grafana-name }} dashboard:

1. {% include [Настройка kubectl](../managed-kubernetes/kubectl-install.md) %}
1. Get the name of the pod with the running {{ grafana-name }} application:

   ```bash
   kubectl get pods --namespace=<Prometheus_Operator_namespace> \
     | grep grafana
   ```

1. Configure `grafana` service port forwarding to the local computer:

   ```bash
   kubectl port-forward --namespace=<Prometheus_Operator_namespace> \
     <{{ grafana-name }}_pod_name> 8080:3000
   ```

   {% note info %}

   If you close the terminal window or abort the command port forwarding will be stopped.

   {% endnote %}

1. In your browser, open the {{ grafana-name }} dashboard at `http://localhost:8080`.
1. Log in as `admin` using the `prom-operator` password.