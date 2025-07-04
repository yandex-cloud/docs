---
title: Удаление кластера Elasticsearch
description: Вы можете удалить кластер Elasticsearch, если он вам больше не нужен. Все данные в кластере будут удалены. В консоли управления выберите каталог, из которого нужно удалить кластер.
keywords:
  - создание кластера Elasticsearch
  - кластер Elasticsearch
  - Elasticsearch
---

# Удаление кластера {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Вы можете удалить кластер {{ ES }}, если он вам больше не нужен. Все данные в кластере будут удалены.

## Перед удалением кластера {#before-you-delete}

* [Отключите защиту от удаления](cluster-update.md#change-additional-settings) для кластера, если она включена.
* [Сохраните идентификатор кластера](cluster-list.md#list-clusters).

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Удалить кластер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
  1. Выберите сервис **Managed Service for&nbsp;Elasticsearch**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить кластер, выполните команду:

  ```bash
  {{ yc-mdb-es }} cluster delete <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

  Чтобы удалить кластер, воспользуйтесь методом REST API [delete](../api-ref/Cluster/delete.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Delete](../api-ref/grpc/Cluster/delete.md) и передайте в запросе идентификатор удаляемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}