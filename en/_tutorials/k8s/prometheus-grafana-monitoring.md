# Cluster monitoring with the help of {{ prometheus-name }} Operator with {{ monitoring-full-name }} support

{{ managed-k8s-name }} enables you to export cluster object metrics to monitoring systems.

In this article, you will learn how to configure [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) monitoring with the help of {{ prometheus-name }} Operator with {{ monitoring-full-name }} support.

{{ prometheus-name }} Operator with {{ monitoring-name }} support streamlines the installation of {{ prometheus-name }} Operator, a popular solution for {{ k8s }} cluster monitoring, providing integration with {{ monitoring-full-name }}. You can use it to collect, store, and read metrics from containers, applications, and the infrastructure. The system leverages the {{ prometheus-name }} data model and [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/).

To set up monitoring for your {{ managed-k8s-name }} cluster:

1. Install {{ prometheus-name }} Operator using a [Helm chart](#helm-install) or [{{ marketplace-full-name }}](#marketplace-install).
1. [Set up and test alerts](#set-alerting).
1. [Visualize metrics](#check-metrics).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for the {{ managed-k8s-name }} master: (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for {{ managed-k8s-name }} cluster nodes: specifically using computing resources and storage (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for public IP addresses for {{ managed-k8s-name }} cluster hosts and {{ managed-k8s-name }} cluster nodes with public access enabled (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration with internet access and the security groups you set up earlier.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Create a service account](../../iam/operations/sa/create.md) with the [monitoring.editor](../../monitoring/security/index.md#monitoring-editor) role.

1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account:

   * If you want to install {{ prometheus-name }} Operator using a [Helm chart](#helm-install), run the following command and save the `secret` key you get:

      ```bash
      yc iam api-key create --service-account-name=<service_account_name>
      ```

   * If you want to install {{ prometheus-name }} Operator using [{{ marketplace-name }}](#marketplace-install), create an API key in JSON format and save it to the `sa-key.json` file:

     ```bash
     yc iam api-key create \
        --service-account-name=<service_account_name> \
        --format=json | jq -c > sa-key.json
     ```

      {% note tip %}

      You can also automatically create a new API key during the app installation.

      {% endnote %}

1. Create a {{ prometheus-name }} workspace:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Open the {{ monitoring-name }} [home page]({{ link-monitoring }}).
      1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
      1. Click **{{ ui-key.yacloud_monitoring.prometheus.action_create }}**.

   {% endlist %}

## Install {{ prometheus-name }} Operator using a Helm chart {#helm-install}

{% include [install-helm-chart](../../_includes/managed-kubernetes/prometheus-install-helm-chart.md) %}

## Install {{ prometheus-name }} Operator using {{ marketplace-name }} {#marketplace-install}

{% include [install-marketplace](../../_includes/managed-kubernetes/prometheus-install-marketplace.md) %}

## Configure alerts based on metrics {#set-alerting}

{% include [set-alerting](../../_includes/managed-kubernetes/prometheus-alerting-set.md) %}

## Visualize metrics {#check-metrics}

Build a chart based on the metrics and add it to the dashboard.

### Build a chart based on metrics {#add-graph}

{% include [add-graph](../../_includes/managed-kubernetes/prometheus-add-graph.md) %}

### Add the chart to the dashboard {#add-to-dashboard}

{% include [add-graph-to-dashboard](../../_includes/managed-kubernetes/prometheus-add-graph-to-dashboard.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete](../../vpc/operations/address-delete.md) the [public static IP address](../../vpc/concepts/address.md#public-addresses) for your {{ managed-k8s-name }} cluster if you reserved one.
