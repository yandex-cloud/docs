# Создать L7-балансировщик

Чтобы создать L7-балансировщик:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться балансировщик.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. В меню слева выберите **Балансировщики**.
  1. Нажмите кнопку **Создать балансировщик**.
  1. Введите имя балансировщика: `test-load-balancer`.
  1. В блоке **Сетевые настройки** выберите сеть, в подсетях которой будут размещаться узлы балансировщика, и [подходящие группы безопасности](../concepts/application-load-balancer.md#security-groups) (если соответствующего поля нет, для балансировщика будет разрешен любой входящий и исходящий трафик). 
  1. В блоке **Размещение** выберите три подсети для узлов балансировщика и включите передачу трафика в эти подсети.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:
     1. Введите имя обработчика: `test-listener`.
     1. В блоке **Настройки публичного IP-адреса** включите передачу трафика.
     1. Укажите порт `80`.
     1. В поле **Назначить IP-адрес** выберите **Автоматически**.
  1. В поле **HTTP-роутер** выберите [HTTP-роутер](http-router-create.md). 
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

     Результат выполнения команды:
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

  1. Посмотрите описание команды CLI для добавления обработчика для L7-балансировщика:
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

     Результат выполнения команды:
     
     ```
     done (25s)
     id: a5d88ep483cmbfm63g9t
     name: test-balancer2
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

{% endlist %}
