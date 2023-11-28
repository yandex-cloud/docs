---
title: "Как получить информацию о целевой группе в {{ alb-full-name }}"
---

# Получить информацию о целевой группе

Вы можете посмотреть идентификатор группы и ее ресурсы.

{% list tabs %}

Чтобы получить информацию о целевой группе:

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о целевой группе:

      ```bash
      yc alb target-group get --help
      ```

  1. Получите информацию о целевой группе, указав ее идентификатор или имя:

      ```bash
      yc alb target-group get <имя_целевой_группы>
      ```

      Результат:

      ```bash
      id: ds7cjrs15ero********
      name: alb-tg
      folder_id: b1geoelk7fld********
      targets:
        - ip_address: 192.168.3.34
          subnet_id: b0cqh32phmc1********
        - ip_address: 192.168.2.4
          subnet_id: e2ltekraekpc********
        - ip_address: 192.168.1.10
          subnet_id: e9bns2fv233c********
      created_at: "2023-10-24T12:21:09.159841076Z"
      ```

{% endlist %}
