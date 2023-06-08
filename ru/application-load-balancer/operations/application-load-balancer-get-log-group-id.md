# Получить идентификатор лог-группы L7-балансировщика

Чтобы получить идентификатор [лог-группы](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, в которую передаются [логи](../concepts/application-load-balancer.md#logging) L7-балансировщика:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Нажмите на имя нужного балансировщика.
  1. В блоке **Настройка логов** в поле **Лог-группа {{ cloud-logging-name }}** нажмите на имя лог-группы. 

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об L7-балансировщике:

      ```bash
      yc alb load-balancer get --help
      ```

  1. Выполните команду, указав имя балансировщика:

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      Результат:

      ```yaml
      id: a5d88ep483cmbfm.....
      name: test-balancer2
      folder_id: aoe197919j8elpe.....
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d15178s.....
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hvram.....
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje62sq.....
        - zone_id: {{ region-id }}-c
          subnet_id: fo2ap2nrhjk9vpf.....
      log_group_id: eolul9ap0bv02i8.....
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o4h6.....
      ```

      Идентификатор лог-группы {{ cloud-logging-name }} будет указан в блоке `log_options` в поле `log_group_id`. Обратите внимание, поле `log_group_id`, приведенное после `subnet_id`, содержит другой идентификатор, который относится к устаревшему сервису логирования.

- API

  Воспользуйтесь методом REST API [get](../api-ref/LoadBalancer/get.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Get](../api-ref/grpc/load_balancer_service.md#Get).

  Идентификатор лог-группы {{ cloud-logging-name }} будет указан в блоке `logOptions` в поле `logGroupId`. Обратите внимание, поле `logGroupId`, приведенное вне блока `logOptions`, содержит другой идентификатор, который относится к устаревшему сервису логирования.

{% endlist %}

Если при создании L7-балансировщика в поле **Лог-группа {{ cloud-logging-name }}** вы оставили значение **Лог-группа по умолчанию**, чтобы узнать ее идентификатор:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ cloud-logging-name }}**.
  1. Сохраните идентификатор лог-группы с именем `default`.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить идентификатор лог-группы по умолчанию, выполните команду:

  ```bash
  yc logging group get \
    --name=default \
    --folder-id=<идентификатор_каталога>
  ```

  Где:
  * `--name` — имя лог-группы по умолчанию — `default`.
  * `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создан балансировщик.

  Результат:

  ```yaml
  id: e23qfbb01na0tq7.....
  folder_id: b1gvgqhc57450av.....
  cloud_id: b1g3clmedscm7ui.....
  created_at: "2021-08-07T10:40:55.412Z"
  name: default
  description: Auto-created default group
  ```

{% endlist %}