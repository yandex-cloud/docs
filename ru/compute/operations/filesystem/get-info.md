---
title: "Как получить информацию о файловом хранилище в {{ compute-full-name }}"
---

# Получить информацию о файловом хранилище

Вы можете узнать размер, зону доступности и другую информацию о файловом хранилище.

{% list tabs %}

Чтобы получить информацию о файловом хранилище:

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о файловом хранилище:

      ```bash
      yc compute filesystem get --help
      ```

  1. Получите информацию о файловом хранилище, указав его идентификатор или имя:
      
      ```bash
      yc compute filesystem get <идентификатор_файлового_хранилища>
      ```

      Результат:

      ```bash
      id: epdt429j3unu********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:15:53Z"
      name: test-filesystem
      type_id: network-hdd
      zone_id: ru-central1-b
      size: "1073741824"
      block_size: "4096"
      status: READY
      ```

{% endlist %}