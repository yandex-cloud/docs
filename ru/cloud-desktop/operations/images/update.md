---
title: Изменить образ {{ cloud-desktop-full-name }}
description: Следуя данной инструкции, вы сможете изменить образ {{ cloud-desktop-name }}.
---

# Изменить образ

Изменение [образа](../../concepts/images.md) приводит к пересозданию [рабочих столов](../../concepts/desktops-and-groups.md).

[Загрузочный диск](../../concepts/disks.md#boot-disk) создается заново из образа, который был ранее выбран для группы рабочих столов. Установленные на загрузочный диск ПО и обновления будут потеряны. Рабочий диск остается прежним. Изменения не затрагивают директорию пользователя.

Чтобы применить изменения к конкретному рабочему столу, [обновите](../desktops/update.md) его.

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/index.yaml) для изменения [образа](../../concepts/desktops-and-groups.md):

      ```bash
      yc desktops image update --help
      ```

  1. Получите список образов в каталоге по умолчанию:

      ```bash
     yc desktops image list
      ```

      Результат:

      ```bash
      +----------------------+-----------------+--------+---------------------+
      |          ID          |       NAME      | STATUS |   CREATED (UTC-0)   |
      +----------------------+-----------------+--------+---------------------+
      | e3vc67qdve8q******** | desktop-image-1 | ACTIVE | 2023-09-13 06:38:12 |
      | e3vqt6ucp1vr******** | desktop-image-2 | ACTIVE | 2025-02-18 00:00:00 |
      +----------------------+-----------------+--------+---------------------+
      ```


  1. Выберите идентификатор (`ID`) нужного образа, например `e3vc67qdve8q********`.
  1. Измените параметры образа, например, имя:

      ```bash
      yc desktops image update \
        --id <идентификатор_образа> \
        --new-name <новое_имя_образа>
      ```
      Результат:

      ```text
      id: e3vc67qdve8q********
      folder_id: b1go79qlt1tp********
      created_at: "2023-09-13T06:38:12.285Z"
      status: ACTIVE
      name: renamed-desktop-image
      min_disk_size: "64424509440"
      ```

{% endlist %}