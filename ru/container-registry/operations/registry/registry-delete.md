---
title: "Как удалить реестр"
description: "Следуя данной инструкции, вы сможете удалить реестр."
---

# Удалить реестр

{% note info %}

Удалить можно только пустой [реестр](../../concepts/registry.md). Не забудьте [удалить Docker-образы из реестра](../docker-image/docker-image-delete.md) перед началом операции.

{% endnote %}

Для обращения к реестру используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить реестр:
  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется удалить реестр.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis-vertical.svg) в строке реестра, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите реестр:

     ```bash
     yc container registry delete new-reg
     ```

     Результат выполнения команды:

     ```text
     done
     ```

  1. Проверьте, что реестр действительно удален:

     ```bash
     yc container registry list
     ```

     Результат выполнения команды:

     ```text
     +----+------+-----------+
     | ID | NAME | FOLDER ID |
     +----+------+-----------+
     +----+------+-----------+
     ```

- API {#api}

  Чтобы удалить реестр, воспользуйтесь методом [delete](../../api-ref/Registry/delete.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}