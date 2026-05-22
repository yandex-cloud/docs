# {{ TF }} reference for {{ msp-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ msp-full-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource**  | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_spark_cluster]({{ tf-provider-msp }}) | Cluster |
| [yandex_spark_cluster_iam_binding]({{ tf-provider-resources-link }}/spark_cluster_iam_binding) | [Configuring](../iam/concepts/access-control/index.md#access-bindings) cluster access permissions |