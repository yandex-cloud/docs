---
title: "Как получить информацию о группе размещения в {{ compute-full-name }}"
---

# Получить информацию о группе размещения

Чтобы получить информацию о группе размещения:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о группе размещения:

      ```bash
      yc compute placement-group get --help
      ```
      
  1. Получите информацию о группе размещения, указав ее имя или идентификатор:
      
      ```bash
      yc compute placement-group get <имя_группы_размещения>
      ```

      Результат:

      ```bash
      id: fd8j3mm3229m********
      folder_id: b1g86q4m5vej********
      created_at: "2023-10-19T10:36:38Z"
      name: test-group
      spread_placement_strategy: {}
      ```

{% endlist %}
