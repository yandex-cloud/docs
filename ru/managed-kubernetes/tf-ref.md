---
title: Справочник {{ TF }} для {{ managed-k8s-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ managed-k8s-name }}.
---

# Справочник {{ TF }} для {{ managed-k8s-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ managed-k8s-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-resources-link }}/kubernetes_cluster) | [Кластер {{ k8s }}](./concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group]({{ tf-provider-resources-link }}/kubernetes_node_group) | [Группа узлов](./concepts/index.md#node-group) |
| [yandex_kubernetes_cluster_iam_binding]({{ tf-provider-resources-link }}/kubernetes_cluster_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру {{ k8s }}. <br>Вместо `yandex_kubernetes_cluster_iam_binding` рекомендуется использовать `yandex_kubernetes_cluster_iam_member` |
| [yandex_kubernetes_cluster_iam_member]({{ tf-provider-resources-link }}/kubernetes_cluster_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру {{ k8s }} |


## Источники данных {#data-sources}

Для {{ managed-k8s-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-datasources-link }}/kubernetes_cluster) | Информация о [кластере {{ k8s }}](./concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group]({{ tf-provider-datasources-link }}/kubernetes_node_group) | Информация о [группе узлов](./concepts/index.md#node-group) |
