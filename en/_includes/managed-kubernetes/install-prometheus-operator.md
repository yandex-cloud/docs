{{ prometheus-name }} Operator with {{ monitoring-full-name }} support makes it easy to install and manage the [{{ managed-prometheus-full-name }}](../../monitoring/operations/prometheus/index.md) monitoring system. You can use it to collect, store, and read metrics from your containers, applications, and infrastructure. The system uses the {{ prometheus-name }} data model and the [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/) query language. This allows you to work with dashboards existing in [{{ grafana-name }}](https://grafana.com/grafana/).

## Getting started {#before-you-begin}

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}

1. [Create a service account](../../iam/operations/sa/create.md) with the [monitoring.editor](../../monitoring/security/index.md#monitoring-editor) role.
1. [Create an API key](../../iam/operations/api-key/create.md) for the service account:

   * If you want to install {{ prometheus-name }} Operator using [{{ marketplace-full-name }}](#marketplace-install), create an API key in JSON format and save it to the `sa-key.json` file:

      ```bash
      yc iam api-key create \
         --service-account-name=<service_account_name> \
         --format=json > sa-key.json
      ```

   * If you want to install {{ prometheus-name }} Operator using a [Helm chart](#helm-install), run the following command and save the `secret` key you get:

      ```bash
      yc iam api-key create --service-account-name=<service_account_name>
      ```

1. {% include [kubectl-install](../managed-kubernetes/kubectl-install.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ k8s }} cluster you need and select the ![image](../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [{{ prometheus-name }} Operator with {{ monitoring-full-name }} support](/marketplace/products/yc/prometheus-operator) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../managed-kubernetes/concepts/index.md#namespace) or create a new one.
   * **Application name**: Specify the app name.
   * **{{ prometheus-name }} Workspace**: Select the required {{ prometheus-name }} workspace.
   * **API key**: Specify the contents of the `sa-key.json` file you got earlier.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../managed-kubernetes/helm-install.md) %}
1. Get the {{ prometheus-name }} workspace ID, you will need it for further setup:

   1. On the {{ monitoring-full-name }} [home page]({{ link-monitoring }}), select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** in the left-hand panel.
   1. Go to the page of the required workspace. The page displays its ID.

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with {{ prometheus-name }} Operator, run the following command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_prometheus-operator.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_prometheus-operator.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace_for_{{ prometheus-name }}_Operator> \
     --create-namespace \
     --set prometheusWorkspaceId=<{{ prometheus-name }}_workspace_ID> \
     --set iam_api_key_value_generated.secretAccessKey=<secret_part_of_API_key> \
     prometheus ./kube-prometheus-stack/
   ```

   The command will also create a new namespace required for {{ prometheus-name }} Operator.

   {% include [Support OCI](../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Make sure the {{ prometheus-name }} Operator pods have changed their status to `Running`:

   ```bash
   kubectl get pods --namespace=<namespace_for_{{ prometheus-name }}_Operator> \
      -l "release=prometheus"
   ```

## Connecting to a {{ grafana-name }} dashboard

To connect to a {{ grafana-name }} dashboard:

1. Get the name of the pod with the running {{ grafana-name }} application:

   ```bash
   kubectl get pods --namespace=<namespace_for_{{ prometheus-name }}_Operator> \
     | grep grafana
   ```

1. Configure `grafana` port forwarding to the local computer:

   ```bash
   kubectl port-forward --namespace=<namespace_for_{{ prometheus-name }}_Operator> \
     <{{ grafana-name }}_pod_name> 8080:3000
   ```

   {% note info %}

   If you close the terminal window or abort the command, port forwarding will be stopped.

   {% endnote %}

1. In your browser, open the {{ grafana-name }} dashboard at `http://localhost:8080`.
1. Sign in using the `admin` username and `prom-operator` password.
