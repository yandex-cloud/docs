---
title: "Инструкция по удалению Docker-образ из реестра {{ container-registry-full-name }}"
description: "Из статьи вы узнаете, как удалить Docker-образ из реестра {{ container-registry-full-name }}."
---

# Удалить Docker-образ из реестра

{% note alert %}

Удаление [Docker-образа](../../concepts/docker-image.md) — это операция с отложенным действием: при удалении Docker-образа его слои физически удаляются **через 1 час**. Информация о суммарном размере реестра обновляется также через 1 час.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы удалить Docker-образ:
  1. Перейдите в репозиторий, из которого надо удалить образ:
     1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. Откройте нужный реестр.
     1. Откройте нужный репозиторий.
  1. Нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) в строке Docker-образа, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.cr.image.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Чтобы удалить Docker-образ, используйте его идентификатор. Узнать идентификатор можно, [запросив список Docker-образов в нужном реестре](docker-image-list.md#docker-image-list).
  1. Удалите Docker-образ:

     ```bash
     yc container image delete crp9vik7sgeco7emq743
     ```

  1. Проверьте, что Docker-образ действительно удален:

     ```bash
     yc container image list
     ```

     Результат выполнения команды:

     ```bash
     +----+---------+------+------+-----------------+
     | ID | CREATED | NAME | TAGS | COMPRESSED SIZE |
     +----+---------+------+------+-----------------+
     +----+---------+------+------+-----------------+
     ```

- API

  Чтобы удалить Docker-образ, воспользуйтесь методом [delete](../../api-ref/Image/delete.md) для ресурса [Image](../../api-ref/Image/).

{% endlist %}