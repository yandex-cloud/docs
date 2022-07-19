---
title: "Удаление кластера Redis"
description: "После удаления кластера баз данных Redis его резервные копии сохраняются и могут быть использованы для восстановления в течение 7 дней. Чтобы восстановить удаленный кластер из резервной копии, вам потребуется его идентификатор, поэтому сохраните идентификатор кластера в надежном месте перед удалением."
---

# Удаление кластера

## Перед удалением кластера {#before-you-delete}

* [Отключите защиту от удаления](update.md#change-additional-settings) для кластера, если она включена.
* [Сохраните идентификатор кластера](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Удалить кластер {#delete}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором нужно удалить кластер.
  1. Выберите сервис **{{ mrd-name }}**.
  1. В строке нужного кластера нажмите значок ![image](../../_assets/options.svg) и выберите **Удалить**.
  1. В открывшемся окне поставьте флаг **Я удаляю кластер** и нажмите кнопку **Удалить**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить кластер, выполните команду:
  
  ```
  {{ yc-mdb-rd }} cluster delete <имя или идентификатор кластера>
  ```
  
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}

    {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [delete](../api-ref/Cluster/delete.md) и передайте идентификатор удаляемого кластера в параметре `clusterId` запроса.

  Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

{% endlist %}
