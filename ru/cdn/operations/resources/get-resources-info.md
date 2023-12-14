---
title: "Как получить информацию о ресурсе в {{ cdn-full-name }}"
---

# Получение информации о ресурсе

Вы можете узнать доменное имя, дату создания и другую информацию о ресурсе.

Чтобы получить информацию о ресурсе:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о ресурсе:

      ```bash
      yc cdn resource get --help
      ```

  1. Получите информацию о ресурсе, указав его идентификатор или имя:
      
      ```bash
      yc cdn resource get <идентификатор_ресурса>
      ```

      Результат:

      ```bash
      id: bc8v43fzihmv********
      folder_id: b1ggmp8es27t********
      cname: cdn-res-group.test.com
      created_at: "2023-10-25T11:18:13.630839Z"
      updated_at: "2023-10-25T11:18:13.630858Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "345600"
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        stale:
          enabled: true
          value:
          - error
          - updating
      origin_group_id: "27272********"
      origin_group_name: test-cdn-group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

{% endlist %}
