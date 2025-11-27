1. {% include [helm-install](helm-install.md) %}

1. Get the {{ prometheus-name }} workspace ID:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Open the {{ monitoring-name }} [home page]({{ link-monitoring }}).
      1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
      1. Select a {{ prometheus-name }} workspace.
      1. This will open the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.info }}** tab displaying the workspace ID. Save the ID.

   {% endlist %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with {{ prometheus-name }} Operator, run this command:

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

   This command will also create a new namespace for {{ prometheus-name }} Operator.

   If you set `namespace` to the default namespace, {{ prometheus-name }} Operator may work incorrectly. Use a value different from all the existing namespaces, e.g., `prometheus-operator-space`.

   {% include [Support OCI](note-helm-experimental-oci.md) %}

1. Make sure the {{ prometheus-name }} Operator pods have changed their status to `Running`:

   ```bash
   kubectl get pods --namespace=<namespace_for_{{ prometheus-name }}_Operator> \
      -l "release=prometheus"
   ```