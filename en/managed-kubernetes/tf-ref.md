# {{ TF }} reference for {{ managed-k8s-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ managed-k8s-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-resources-link }}/kubernetes_cluster) | [{{ k8s }} cluster](./concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group]({{ tf-provider-resources-link }}/kubernetes_node_group) | [Node group](./concepts/index.md#node-group) |

## {#data-sources} data sources

{{ managed-k8s-name }} supports the following {{ TF }} data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-datasources-link }}/datasource_kubernetes_cluster) | [{{ k8s }} cluster](./concepts/index.md#kubernetes-cluster) information |
| [yandex_kubernetes_node_group]({{ tf-provider-datasources-link }}/datasource_kubernetes_node_group) | [Node group](./concepts/index.md#node-group) information |