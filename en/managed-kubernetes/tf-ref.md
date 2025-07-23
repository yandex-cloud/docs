---
title: '{{ TF }} reference for {{ managed-k8s-full-name }}'
description: This page describes the {{ TF }} provider’s resources and data sources supported by {{ managed-k8s-name }}.
---

# {{ TF }} reference for {{ managed-k8s-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ managed-k8s-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-resources-link }}/kubernetes_cluster) | [{{ k8s }} cluster](./concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group]({{ tf-provider-resources-link }}/kubernetes_node_group) | [Node group](./concepts/index.md#node-group) |
| [yandex_kubernetes_cluster_iam_binding]({{ tf-provider-resources-link }}/kubernetes_cluster_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a {{ k8s }} cluster. <br>We recommend using `yandex_kubernetes_cluster_iam_member` instead of `yandex_kubernetes_cluster_iam_binding`. |
| [yandex_kubernetes_cluster_iam_member]({{ tf-provider-resources-link }}/kubernetes_cluster_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a {{ k8s }} cluster |


## Data sources {#data-sources}

{{ managed-k8s-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-datasources-link }}/kubernetes_cluster) | [{{ k8s }} cluster](./concepts/index.md#kubernetes-cluster) information |
| [yandex_kubernetes_node_group]({{ tf-provider-datasources-link }}/kubernetes_node_group) | [Node group](./concepts/index.md#node-group) information |