---
title: Installing VictoriaLogs
description: Follow this guide to install VictoriaLogs.
---

# Installing VictoriaLogs


[VictoriaLogs](https://docs.victoriametrics.com/victorialogs/) is a solution for collecting, storing, and analyzing logs, installed in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster). With VictoriaLogs, you can:

* Collect app logs using various log collectors.
* Analyze logs using the LogsQL query language.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [VictoriaLogs](/marketplace/products/yc/victoria-logs) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new namespace, e.g., `victoria-logs`. If you leave the default namespace, VictoriaLogs may work incorrectly.
   * **Application name**: Specify the application name.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.
1. Set up `victoria-logs-single-server` port forwarding to your local computer:

   ```bash
   kubectl port-forward service/victoria-logs-single-server 30000:9428 \
      --namespace <application_namespace>
   ```

1. Make sure the VictoriaLogs web interface is accessible by opening `http://localhost:30000`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with VictoriaLogs, run the following command, specifying the parameters of the resources you created [earlier](#before-you-begin):

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_victoria-logs.helmChart.name }} \
        --version {{ mkt-k8s-key.yc_victoria-logs.helmChart.tag }} \
        --untar && \
   helm install \
        --namespace victoria-logs \
        --create-namespace \
        victoria-logs-single ./victoria-logs-single/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## See also {#see-also}

* [VictoriaLogs documentation](https://docs.victoriametrics.com/victorialogs/)
* [Use cases](https://docs.victoriametrics.com/victorialogs/logsql-examples/)
