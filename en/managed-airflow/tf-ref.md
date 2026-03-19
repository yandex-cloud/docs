# {{ TF }} reference for {{ maf-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ maf-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_airflow_cluster]({{ tf-provider-maf }}) | [Cluster](./concepts/index.md#cluster) |
| [yandex_airflow_cluster_iam_binding]({{ tf-provider-resources-link }}/airflow_cluster_iam_binding) | [Configuring](../iam/concepts/access-control/index.md#access-bindings) cluster access permissions |