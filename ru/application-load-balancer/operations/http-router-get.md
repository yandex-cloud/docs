---
title: "Как получить информацию об HTTP-роутере в {{ alb-full-name }}"
---

# Получить информацию об HTTP-роутере

Вы можете посмотреть идентификатор роутера, его хосты, а также маршруты в хостах.

{% list tabs %}

Чтобы получить информацию об HTTP-роутере:

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об HTTP-роутере:

      ```bash
      yc alb http-router get --help
      ```

  1. Получите информацию об HTTP-роутере, указав его идентификатор или имя:

      ```bash
      yc alb http-router get <имя_HTTP-роутера>
      ```

      Результат:

      ```bash
      id: ds7u8nv8gl2s********
      name: alb-router
      folder_id: b1geoelk7fld********
      virtual_hosts:
        - name: alb-host
          authority:
            - www.first-site.ru
            - first-site.ru
          routes:
            - name: route-1
              http:
                route:
                  backend_group_id: ds7maho6c4or********
      created_at: "2023-10-24T12:20:44.091821711Z"
      ```

{% endlist %}
