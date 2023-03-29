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
     region_id: {{ region-id }}
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
       - zone_id: {{ region-id }}-a
         subnet_id: buc4gsmpj8hvramg61g8
       - zone_id: {{ region-id }}-b
         subnet_id: blt6pcatjje62sqvjq5b
       - zone_id: {{ region-id }}-c
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
       - zone_id: {{ region-id }}-a
         subnet_id: e9bs1hp7lgdl1g3n6ci1
       - zone_id: {{ region-id }}-b
         subnet_id: e2le8i7hqa216f6i6php
       - zone_id: {{ region-id }}-c
         subnet_id: b0cgk1au6fn203f3tqnf
     log_group_id: ckgs4u5km3u8j9f360md
     security_group_ids:
     - enp49ot04g63ih1scuap
     created_at: "2022-04-04T02:12:40.160629110Z"
     ```
  1. (опционально) Установите новые ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling):
 
     {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием L7-балансировщика:

     ```hcl
     ...
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "my-load-balancer"
       network_id  = yandex_vpc_network.test-network.id

       allocation_policy {
         location {
           zone_id   = "{{ region-id }}-a"
           subnet_id = yandex_vpc_subnet.test-subnet.id
         }
       }

       listener {
         name = "my-listener"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [ 9000 ]
         }
         http {
           handler {
             http_router_id = yandex_alb_http_router.test-router.id
           }
         }
       }
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/alb_load_balancer).

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение L7-балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc alb load-balancer get <имя L7-балансировщика>
     ```

- API

  Воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update).

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

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации {{ TF }} и удалите блок `listener` в описании L7-балансировщика:

     ```hcl
     ...
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "my-load-balancer"
       network_id  = yandex_vpc_network.test-network.id

       allocation_policy {
         location {
           zone_id   = "{{ region-id }}-a"
           subnet_id = yandex_vpc_subnet.test-subnet.id 
         }
       }

       listener {
         name = "my-listener"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [ 9000 ]
         }    
         http {
           handler {
             http_router_id = yandex_alb_http_router.test-router.id
           }
         }
       }    
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/alb_load_balancer).

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение L7-балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc alb load-balancer get <имя L7-балансировщика>
     ```

- API

  Воспользуйтесь методом REST API [removeListener](../api-ref/LoadBalancer/removeListener.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/RemoveListener](../api-ref/grpc/load_balancer_service.md#RemoveListener).

{% endlist %}
