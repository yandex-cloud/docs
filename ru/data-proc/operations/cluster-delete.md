---
title: "Удаление кластера {{ dataproc-name }}"
description: "Вы можете удалить кластер {{ dataproc-name }} вместе со всеми хранимыми данными. Помните, что резервные копии данных не создаются автоматически: если вы хотите сохранить данные для восстановления кластера или последующего использования, используйте, например, сервис {{ objstorage-full-name }}."
---

# Удаление кластера {{ dataproc-name }}

Вы можете удалить кластер вместе со всеми хранимыми данными. Помните, что резервные копии данных не создаются автоматически: если вы хотите сохранить данные для восстановления кластера или последующего использования, используйте, например, сервис [{{ objstorage-full-name }}]({{ link-cloud-services }}/storage).

Для удаления кластера {{ dataproc-name }} пользователю должны быть назначены роли `editor` и `dataproc.agent`. Подробнее см. в [описании ролей](../security/index.md#roles-list).

## Перед удалением кластера {#before-you-delete}

[Отключите защиту от удаления](./cluster-update.md) для кластера, если она включена.

## Удалить кластер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. (Опционально) Укажите таймаут [декомиссии](../concepts/decommission.md).
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить кластер, выполните команду:

  ```bash
  {{ yc-dp }} cluster delete <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

{% endlist %}