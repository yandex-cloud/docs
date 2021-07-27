---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Изменить L7-балансировщик

Чтобы изменить L7-балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Нажмите на имя нужного балансировщика.
  1. Нажмите **Редактировать**.
  1. Измените параметры балансировщика, например, переименуйте балансировщик.
  1. Внизу страницы нажмите кнопку **Сохранить изменения**.

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

     Результат выполнения команды:
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

{% endlist %}
