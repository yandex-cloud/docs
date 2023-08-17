---
title: "Удаление кластера MongoDB"
description: "После удаления кластера баз данных MongoDB его резервные копии сохраняются и могут быть использованы для восстановления в течение 7 дней. Чтобы восстановить удаленный кластер из резервной копии, вам потребуется его идентификатор, поэтому сохраните идентификатор кластера в надежном месте перед удалением."
---

# Удаление {{ MG }}-кластера

## Перед удалением кластера {#before-you-delete}

* [Отключите защиту от удаления](update.md#change-additional-settings) для кластера, если она включена.
* [Сохраните идентификатор кластера](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Удалить кластер {#delete}

{% list tabs %}

- Консоль управления
  
  1. Откройте [страницу каталога]({{ link-console-main }}) в консоли управления.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить кластер, выполните команду:
  
  ```bash
  {{ yc-mdb-mg }} cluster delete <имя или идентификатор кластера>
  ```
  
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Чтобы удалить кластер, воспользуйтесь методом REST API [delete](../api-ref/Cluster/delete.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Delete](../api-ref/grpc/cluster_service.md#Delete) и передайте в запросе идентификатор кластера в параметре `clusterId`.

Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
