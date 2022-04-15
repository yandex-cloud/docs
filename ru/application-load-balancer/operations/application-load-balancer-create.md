# Создать L7-балансировщик

Чтобы создать L7-балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан балансировщик.

  1. В списке сервисов выберите **{{ alb-name }}**.

  1. Нажмите кнопку **Создать балансировщик** и выберите **Вручную**.

  1. Введите имя балансировщика: `test-load-balancer`.

  1. В блоке **Сетевые настройки** выберите сеть, в подсетях которой будут размещаться узлы балансировщика, и [подходящие группы безопасности](../concepts/application-load-balancer.md#security-groups) (если соответствующего поля нет, для балансировщика будет разрешен любой входящий и исходящий трафик).

  1. В блоке **Размещение** выберите три подсети для узлов балансировщика и включите передачу трафика в эти подсети.

  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:
     1. Введите имя обработчика: `test-listener`.
     1. (опционально) Включите опцию **Публичный IP-адрес**. Укажите **Порт**: `80` и выберите **Тип**:
        * `Автоматически`.
        * `Список` — в появившемся поле справа выберите адрес в выпадающем списке.
     1. (опционально) Включите опцию **Внутренний IP-адрес**. Укажите **Порт** и выберите **Подсеть** в выпадающем списке.
     1. В блоке **Прием и обработка трафика** выберите тип обработчика: `HTTP` или `Stream`.
     
        Для `HTTP` выберите:
        
        * Протокол: `HTTP`,`HTTPS` или `Перенаправлять на HTTPS`.
        * [HTTP-роутер](http-router-create.md) в выпадающем списке.
        
        Для `Stream` выберите протокол:
        
        * `Открытый`: выберите **Группы бэкендов** в выпадающем списке.
        * `Зашифрованный`: в блоке **Основной обработчик** выберите **Сертификаты** и **Группы бэкендов** в выпадающих списках.

  1. При необходимости добавьте дополнительные обработчики.

  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания L7-балансировщика:
     ```
     yc alb load-balancer create --help
     ```

  1. Выполните команду, указав сеть и подсети, в которых будут размещаться узлы балансировщика, а также [подходящие группы безопасности](../concepts/application-load-balancer.md#security-groups):
     ```
     yc alb load-balancer create <имя балансировщика> \
       --network-name <имя сети> \
       --location subnet-name=<имя подсети 1>,zone=<зона доступности> \
       --location subnet-name=<имя подсети 2>,zone=<зона доступности> \
       --location subnet-name=<имя подсети 3>,zone=<зона доступности>
     ```

     Результат:
     ```
     done (1m40s)
     id: a5d88ep483cmbfm63g9t
     name: test-balancer2
     folder_id: aoe197919j8elpeg1lkp
     status: ACTIVE
     region_id: ru-central1
     network_id: c64l1c06d15178sa87k0
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

  1. Добавьте обработчик для L7-балансировщика:

     * HTTP-обработчик:

       1. Посмотрите описание команды CLI для добавления HTTP-обработчика L7-балансировщика:

          ```
          yc alb load-balancer add-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```
          yc alb load-balancer add-listener <имя балансировщика> \
            --listener-name <имя обработчика> \
            --http-router-id <идентификатор HTTP-роутера> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     * Stream-обработчик:

       1. Посмотрите описание команды CLI для добавления Stream-обработчика L7-балансировщика:

          ```
          yc alb load-balancer add-stream-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```
          yc alb load-balancer add-stream-listener <имя балансировщика> \
            --listener-name=<имя обработчика> \
            --backend-group-id=<идентификатор группы бэкендов> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     Результат после добавления двух обработчиков:
 
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
