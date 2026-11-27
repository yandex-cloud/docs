---
title: '{{ TF }} reference for {{ msp-full-name }}'
description: This page lists {{ TF }} provider resources and data sources supported by {{ msp-name }}.
alternate:
  - href: en/managed-spark/tf-ref.md
    type: text/markdown
    title: Markdown version
---

# {{ TF }} reference for {{ msp-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ msp-full-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource**  | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_spark_cluster]({{ tf-provider-msp }}) | Cluster |
| [yandex_spark_cluster_iam_binding]({{ tf-provider-resources-link }}/spark_cluster_iam_binding) | [Configuring](../iam/concepts/access-control/index.md#access-bindings) cluster access permissions |