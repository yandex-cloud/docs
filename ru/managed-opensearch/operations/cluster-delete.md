---
title: "Удаление кластера {{ OS }}"
description: "Вы можете удалить кластер {{ OS }}, если он вам больше не нужен. Все данные в кластере будут удалены. В консоли управления выберите каталог, из которого нужно удалить кластер."
keywords:
  - создание кластера OpenSearch
  - кластер OpenSearch
  - OpenSearch
---

# Удаление кластера {{ OS }}

Вы можете удалить кластер {{ OS }}, если он вам больше не нужен. Все данные в кластере будут удалены.

## Перед удалением кластера {#before-you-delete}

* [Отключите защиту от удаления](update.md) для кластера, если она включена.
* [Сохраните идентификатор кластера](cluster-list.md#list-clusters).

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Удалить кластер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. Подтвердите удаление кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- API {#api}

  Чтобы удалить кластер, воспользуйтесь методом REST API [delete](../api-ref/Cluster/delete.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Delete](../api-ref/grpc/cluster_service.md#Delete) и передайте в запросе идентификатор удаляемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}
