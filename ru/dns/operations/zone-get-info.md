---
title: "Как получить информацию о зоне DNS в {{ dns-full-name }}"
---

# Получить информации о зоне DNS

Чтобы получить информацию о зоне DNS:

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о зоне DNS:

      ```bash
      yc dns zone get --help
      ```
  
  1. Получите информацию о зоне DNS, указав ее имя или идентификатор:

      ```bash
      yc dns zone get <имя_зоны_DNS>
      ```

      Результат:

      ```bash
      id: dns6oh57qm9n********
      folder_id: f01derqpemb4********
      created_at: "2023-11-02T08:34:58.493Z"
      name: example.com.
      zone: example-zone-name
      public_visibility: {}
      ```

{% endlist %}
