# Изменить L7-балансировщик

Чтобы изменить параметры L7-балансировщика:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Нажмите на имя нужного балансировщика.
  1. Нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. Измените параметры балансировщика.
  1. В блоке **Обработчики** напротив нужного обработчика нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. Измените параметры обработчика и нажмите **Сохранить**.
  1. Внизу страницы нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения параметров балансировщика:

     ```
     yc alb load-balancer update --help
     ```

  1. Выполните команду, указав новые параметры балансировщика:

     ```
     yc alb load-balancer update <имя балансировщика> --new-name <новое имя балансировщика>
     ```

     Результат:
     ```
     id: a5d88ep483cmbfm63g9t
     name: test-balancer2-updated
     folder_id: aoe197919j8elpeg1lkp
     status: ACTIVE
     region_id: ru-central1
     network_id: c64l1c06d15178sa87k0
     listeners:
     - name: test-listener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 130.193.32.206
         ports:
         - "80"
       http:
         handler:
           http_router_id: a5dv7tjdo9gt2pq5l906
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: buc4gsmpj8hvramg61g8
       - zone_id: ru-central1-b
         subnet_id: blt6pcatjje62sqvjq5b
       - zone_id: ru-central1-c
         subnet_id: fo2ap2nrhjk9vpfdnno8
     log_group_id: eolul9ap0bv02i8bsp87
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

  1. Укажите новые параметры обработчика:

     * HTTP-обработчик:

       1. Посмотрите описание команды CLI для изменения параметров HTTP-обработчика L7-балансировщика:

          ```
          yc alb load-balancer update-listener --help
          ```

       1. Выполните команду, указав новые параметры обработчика:

          ```
          yc alb load-balancer update-listener <имя балансировщика> \
            --listener-name <имя обработчика> \
            --http-router-id <идентификатор HTTP-роутера> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     * Stream-обработчик:

       1. Посмотрите описание команды CLI для изменения параметров Stream-обработчика L7-балансировщика:

          ```
          yc alb load-balancer update-stream-listener --help
          ```

       1. Выполните команду, указав новые параметры обработчика:

          ```
          yc alb load-balancer update-stream-listener <имя балансировщика> \
            --listener-name=<имя обработчика> \
            --backend-group-id=<идентификатор группы бэкендов> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     Результат обновления двух обработчиков:

     ```
     done (42s)
     id: ds76g8b2op3fej12nab6
     name: test-load-balancer
     folder_id: b1gu6g9ielh690at5bm7
     status: ACTIVE
     network_id: enp0uulja5s3j1ftvfei
     listeners:
     - name: tslistener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 51.250.64.197
         ports:
         - "80"
       http:
         handler:
           http_router_id: ds7d7b14b3fsv7qjkvel
     - name: teststreamlistener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 51.250.64.197
         ports:
         - "443"
       stream:
         handler:
           backend_group_id: ds77tero4f5h46l4e2gl
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: e9bs1hp7lgdl1g3n6ci1
       - zone_id: ru-central1-b
         subnet_id: e2le8i7hqa216f6i6php
       - zone_id: ru-central1-c
         subnet_id: b0cgk1au6fn203f3tqnf
     log_group_id: ckgs4u5km3u8j9f360md
     security_group_ids:
     - enp49ot04g63ih1scuap
     created_at: "2022-04-04T02:12:40.160629110Z"
     ```

{% endlist %}

## Удалить обработчик {#delete-listener}

Чтобы удалить обработчик L7-балансировщика:

{% list tabs %}


- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Обработчики** напротив имени нужного обработчика нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления обработчика:
     ```
     yc alb load-balancer remove-listener --help
     ```

  1. Выполните команду:
     ```
     yc alb load-balancer remove-listener <идентификатор или имя балансировщика> \
       --listener-name=<имя обработчика>
     ```

     Результат:
     ```
     done (50s)
     ```

{% endlist %}
