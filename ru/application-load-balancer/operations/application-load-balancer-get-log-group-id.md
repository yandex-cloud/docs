# Получить идентификатор лог-группы L7-балансировщика

Чтобы получить идентификатор лог-группы, созданной вместе с L7-балансировщиком для хранения его [логов](../concepts/application-load-balancer.md#logging):

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для получения информации об L7-балансировщике:
     ```
     yc alb load-balancer get --help
     ```

  1. Выполните команду, указав имя балансировщика:
     ```
     yc alb load-balancer get <имя балансировщика>
     ```

     Результат выполнения команды:
     ```
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

     Идентификатор лог-группы будет указан в поле `log_group_id`.
     
- API

  Используйте вызов gRPC API [LoadBalancerService/Get](../api-ref/grpc/load_balancer_service.md#Get) или метод REST API [get](../api-ref/LoadBalancer/create.md). Идентификатор лог-группы будет указан в поле `log_group_id`.

{% endlist %}