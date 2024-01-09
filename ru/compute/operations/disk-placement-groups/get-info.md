---
title: "Как получить информацию о группе размещения дисков в {{ compute-full-name }}"
---

# Получить информацию о группе размещения дисков

Вы можете узнать идентификатор каталога, зону доступности и другую информацию о группе размещения дисков.

{% list tabs group=instructions %}

Чтобы получить информацию о группе размещения дисков:

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о группе размещения дисков:

      ```bash
      yc compute disk-placement-group get --help
      ```

  1. Получите информацию о группе размещения дисков, указав ее идентификатор или имя:
      
      ```bash
      yc compute disk-placement-group get <идентификатор_группы_размещения_дисков>
      ```

      Результат:

      ```bash
      id: d9h3qkknmtsl********
      folder_id: aoe3hggkil3t********
      created_at: "2023-10-27T13:01:20Z"
      name: test-placement-group
      zone_id: ru-central1-c
      status: READY
      spread_placement_strategy: {}
      ```

{% endlist %}