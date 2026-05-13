# Получить идентификатор лог-группы L7-балансировщика

Чтобы получить идентификатор [лог-группы](../../logging/concepts/log-group.md) Yandex Cloud Logging, в которую передаются [логи](../concepts/monitoring.md#logging) L7-балансировщика:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан балансировщик.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Application Load Balancer**.
  1. Нажмите на имя нужного балансировщика.
  1. В блоке **Настройки логов** в поле **Лог-группа Cloud Logging** нажмите на имя лог-группы.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации об L7-балансировщике:

      ```bash
      yc alb load-balancer get --help
      ```

  1. Выполните команду, указав имя балансировщика:

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      Результат:

      ```text
      id: a5d88ep483cm********
      name: test-balancer2
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: ru-central1
      network_id: c64l1c06d151********
      allocation_policy:
        locations:
        - zone_id: ru-central1-a
          subnet_id: buc4gsmpj8hv********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

      Идентификатор лог-группы Cloud Logging будет указан в блоке `log_options` в поле `log_group_id`. Обратите внимание, поле `log_group_id`, приведенное после `subnet_id`, содержит другой идентификатор, который относится к устаревшему сервису логирования.

- API {#api}

  Воспользуйтесь методом REST API [get](../api-ref/LoadBalancer/get.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Get](../api-ref/grpc/LoadBalancer/get.md).

  Идентификатор лог-группы Cloud Logging будет указан в блоке `logOptions` в поле `logGroupId`. Обратите внимание, поле `logGroupId`, приведенное вне блока `logOptions`, содержит другой идентификатор, который относится к устаревшему сервису логирования.

{% endlist %}

Если при создании L7-балансировщика в поле **Лог-группа Cloud Logging** вы оставили значение **Лог-группа по умолчанию**, чтобы узнать ее идентификатор:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором создан балансировщик.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Logging**.
  1. Сохраните идентификатор лог-группы с именем `default`.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  ```text
  id: e23qfbb01na0********
  folder_id: b1gvgqhc5745********
  cloud_id: b1g3clmedscm********
  created_at: "2021-08-07T10:40:55.412Z"
  name: default
  description: Auto-created default group
  ```

{% endlist %}