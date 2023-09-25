---
title: "Как удалить реестр"
description: "Следуя данной инструкции, вы сможете удалить реестр."
---

# Удалить реестр

{% note info %}

Удалить можно только пустой [реестр](../../concepts/registry.md). Не забудьте [удалить Docker-образы из реестра](../docker-image/docker-image-delete.md) перед началом операции.

{% endnote %}

Для обращения к реестру используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

{% list tabs %}

- Консоль управления

  Чтобы удалить реестр:
  1. Откройте раздел **{{ container-registry-name }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется удалить реестр.
  1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) в строке реестра, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

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

- API

  Чтобы удалить реестр, воспользуйтесь методом [delete](../../api-ref/Registry/delete.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}