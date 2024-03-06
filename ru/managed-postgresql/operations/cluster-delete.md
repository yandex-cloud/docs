---
title: "Удаление кластера PostgreSQL"
description: "После удаления кластера баз данных PostgreSQL его резервные копии сохраняются и могут быть использованы для восстановления в течение 7 дней. Чтобы восстановить удаленный кластер из резервной копии, вам потребуется его идентификатор, поэтому сохраните идентификатор кластера в надежном месте перед удалением."
---

# Удаление кластера {{ PG }}

## Перед удалением кластера {#before-you-delete}

* [Отключите защиту от удаления](update.md#change-additional-settings) для кластера, если она включена.
* [Сохраните идентификатор кластера](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Удалить кластер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. Откройте страницу каталога в консоли управления.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера, выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}** и подтвердите удаление.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить кластер, выполните команду:
  
  ```bash
  {{ yc-mdb-pg }} cluster delete <имя_или_идентификатор_кластера>
  ```
  
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API {#api}

  Чтобы удалить кластер, воспользуйтесь методом REST API [delete](../api-ref/Cluster/delete.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Delete](../api-ref/grpc/cluster_service.md#Delete) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
