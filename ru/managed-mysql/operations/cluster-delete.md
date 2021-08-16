---
title: "Удаление кластера MySQL"
description: "После удаления кластера баз данных MySQL его резервные копии сохраняются и могут быть использованы для восстановления в течение 7 дней. Чтобы восстановить удаленный кластер из резервной копии, вам потребуется его идентификатор, поэтому сохраните идентификатор кластера в надежном месте перед удалением."
---

# Удаление кластера

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

{% list tabs %}

- Консоль управления
  
  1. Откройте страницу каталога в консоли управления.
  1. Выберите сервис **{{ mmy-name }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **Удалить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить кластер, выполните команду:
  
  ```
  $ {{ yc-mdb-my }} cluster delete <имя или идентификатор кластера>
  ```
  
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}
  
{% endlist %}


