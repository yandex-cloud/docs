---
title: "Как получить информацию о диске в {{ compute-full-name }}"
---

# Получить информацию о диске

Вы можете узнать размер, зону доступности и другую информацию о дисках.

{% list tabs %}

Чтобы получить информацию о диске:

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о диске:

      ```bash
      yc compute disk get --help
      ```

  1. Получите информацию о диске, указав его идентификатор или имя:
      
      ```bash
      yc compute disk get <идентификатор_диска>
      ```

      Результат:

      ```bash
      id: epdi2r341gcq********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:14:30Z"
      name: test-disk
      type_id: network-hdd
      zone_id: ru-central1-b
      size: "21474836480"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

{% endlist %}