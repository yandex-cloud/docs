---
title: "Как получить информацию об L7-балансировщике в {{ alb-full-name }}"
---

# Получить информацию об L7-балансировщике

Вы можете посмотреть идентификатор балансировщика, его обработчики, размещение, группы безопасности и настройки логирования.

{% list tabs group=instructions %}

Чтобы получить информацию об L7-балансировщике:

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об L7-балансировщике:

      ```bash
      yc alb load-balancer get --help
      ```

  1. Получите информацию о балансировщике, указав его имя или идентификатор:

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      Результат:

      ```bash
      id: a5d88ep483cm********
      name: test-balancer2
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d151********
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hv********
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje6********
        - zone_id: {{ region-id }}-c
          subnet_id: fo2ap2nrhjk9********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

{% endlist %}
