---
title: "Как получить информацию о группе бэкендов в {{ alb-full-name }}"
---

# Получить информацию о группе бэкендов

Вы можете посмотреть идентификатор группы, ее бэкенды, а также целевые группы бэкендов.

{% list tabs %}

Чтобы получить информацию о группе бэкендов:

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о группе бэкендов:

      ```bash
      yc alb backend-group get --help
      ```

  1. Получите информацию о группе бэкендов, указав ее имя или идентификатор:

      ```bash
      yc alb backend-group get <имя_группы_бэкендов>
      ```

      Результат:

      ```bash
      id: ds7maho6c4or********
      name: alb-bg
      folder_id: b1geoelk7fld********
      http:
        backends:
          - name: backend-1
            backend_weight: "1"
            port: "80"
            target_groups:
              target_group_ids:
                - ds7cjrs15ero********
            healthchecks:
              - timeout: 10s
                interval: 2s
                healthcheck_port: "80"
                http:
                  path: /
      created_at: "2023-10-24T12:22:20.870326850Z"
      ```

{% endlist %}
