{{ prometheus-name }} Operator with {{ monitoring-full-name }} support streamlines the installation of {{ prometheus-name }} Operator, a popular solution for {{ k8s }} cluster monitoring, providing integration with {{ monitoring-full-name }}. You can use it to collect, store, and read metrics from containers, applications, and the infrastructure. The system leverages the {{ prometheus-name }} data model and [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/).

## Getting started {#before-you-begin}

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}

1. [Create a service account](../../iam/operations/sa/create.md) with the [monitoring.editor](../../monitoring/security/index.md#monitoring-editor) role.

1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account:

   * If you want to install {{ prometheus-name }} Operator using [{{ marketplace-full-name }}](#marketplace-install), create an API key in JSON format and save it to the `sa-key.json` file:

      ```bash
      yc iam api-key create \
         --service-account-name=<service_account_name> \
         --format=json | jq -c > sa-key.json
      ```

      {% note tip %}

      You can also automatically create a new API key during the app installation.

      {% endnote %}

   * If you want to install {{ prometheus-name }} Operator using a [Helm chart](#helm-install), run the following command and save the `secret` key you get:

      ```bash
      yc iam api-key create --service-account-name=<service_account_name>
      ```

1. {% include [kubectl-install](../managed-kubernetes/kubectl-install.md) %}

1. If you do not have a {{ prometheus-name }} workspace yet, create one:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Open the {{ monitoring-name }} [home page]({{ link-monitoring }}).
      1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
      1. Click **{{ ui-key.yacloud_monitoring.prometheus.action_create }}**.

   {% endlist %} 

## Installation from {{ marketplace-full-name }} {#marketplace-install}

{% include [install-marketplace](../../_includes/managed-kubernetes/prometheus-install-marketplace.md) %}

## Installation using a Helm chart {#helm-install}

{% include [install-helm-chart](../../_includes/managed-kubernetes/prometheus-install-helm-chart.md) %}

## Viewing charts based on metrics {#add-graph}

{% include [add-graph](../../_includes/managed-kubernetes/prometheus-add-graph.md) %}

## Adding charts to dashboards {#add-to-dashboard}

{% include [add-graph-to-dashboard](../../_includes/managed-kubernetes/prometheus-add-graph-to-dashboard.md) %}

## (Optional) Configuring alerts based on metrics {#set-alerting}

{% include [set-alerting](../../_includes/managed-kubernetes/prometheus-alerting-set.md) %}
