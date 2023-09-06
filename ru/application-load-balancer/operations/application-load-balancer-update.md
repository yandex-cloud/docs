# Изменить L7-балансировщик

Чтобы изменить параметры L7-балансировщика:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите на имя нужного балансировщика.
  1. Нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры балансировщика.
  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** измените параметры нужных обработчиков.
  1. (Опционально) В блоке **{{ ui-key.yacloud.alb.section_logs-settings }}**:
  
      1. Измените [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи балансировщика.
      1. Измените [правила отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):

          * **{{ ui-key.yacloud.alb.label_discard-http-codes }}** — измените HTTP-коды.
          * **{{ ui-key.yacloud.alb.label_discard-http-code-intervals }}** — измените классы HTTP-кодов.
          * **{{ ui-key.yacloud.alb.label_discard-grpc-codes }}** — измените gRPC-коды.
          * **{{ ui-key.yacloud.alb.label_discard-percent }}** — измените процент отбрасываемых логов.

          Чтобы добавить еще одно правило, нажмите кнопку **{{ ui-key.yacloud.alb.button_add-discard-rule }}**.
  1. Внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения параметров балансировщика:

     ```bash
     yc alb load-balancer update --help
     ```

  1. Выполните команду, указав новые параметры балансировщика:

     ```bash
     yc alb load-balancer update <имя_балансировщика> --new-name <новое_имя_балансировщика>
     ```

     Результат:
     
          
     ```yaml
     id: a5d88ep483cmbfm.....
     name: test-balancer2-updated
     folder_id: aoe197919j8elpe.....
     status: ACTIVE
     region_id: {{ region-id }}
     network_id: c64l1c06d15178s.....
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
           http_router_id: a5dv7tjdo9gt2pq.....
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
     ```
     


  1. (Опционально) Измените параметры записи [логов](../logs-ref.md) в [{{ cloud-logging-full-name }}](../../logging/):

      1. Посмотрите описание команды CLI для управления логированием в балансировщике:

          ```bash
          yc alb load-balancer logging --help
          ```

      1. Добавьте новое правило отбрасывания логов:

          ```bash
          yc alb load-balancer logging <имя_балансировщика> \
            --log-group-id <идентификатор_лог-группы> \
            --enable \
            --discard codes=[200,3XX,GRPC_OK],percent=90
          ```

          Где:

          * `--log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md).
          * `--discard` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules). Параметры правила:
            * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
            * `percent` — доля отбрасываемых логов в процентах.

          Результат:

          ```yaml
          done (42s)
          id: ds76g2zpgp3fej1.....
          name: test-load-balancer
          folder_id: b1gug7dbelh690.....
          ...
          log_options:
            log_group_id: e23p9bcvh6gra3t.....
            discard_rules:
              - http_codes:
                  - "200"
                http_code_intervals:
                  - HTTP_3XX
                grpc_codes:
                  - OK
                discard_percent: "90"
          ```

  1. Укажите новые параметры обработчика:

     * HTTP-обработчик:

       1. Посмотрите описание команды CLI для изменения параметров HTTP-обработчика L7-балансировщика:

          ```bash
          yc alb load-balancer update-listener --help
          ```

       1. Выполните команду, указав новые параметры обработчика:

          ```bash
          yc alb load-balancer update-listener <имя_балансировщика> \
            --listener-name <имя_обработчика> \
            --http-router-id <идентификатор_HTTP-роутера> \
            --external-ipv4-endpoint port=<порт_обработчика>
          ```

     * Stream-обработчик:

       1. Посмотрите описание команды CLI для изменения параметров Stream-обработчика L7-балансировщика:

          ```bash
          yc alb load-balancer update-stream-listener --help
          ```

       1. Выполните команду, указав новые параметры обработчика:

          ```bash
          yc alb load-balancer update-stream-listener <имя_балансировщика> \
            --listener-name=<имя_обработчика> \
            --backend-group-id=<идентификатор_группы_бэкендов> \
            --external-ipv4-endpoint port=<порт_обработчика>
          ```

     Результат обновления двух обработчиков:

     ```yaml
     done (42s)
     id: ds76g8b2op3fej1.....
     name: test-load-balancer
     folder_id: b1gu6g9ielh690a.....
     status: ACTIVE
     network_id: enp0uulja5s3j1f.....
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
           http_router_id: ds7d7b14b3fsv7q.....
     - name: teststreamlistener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 51.250.64.197
         ports:
         - "443"
       stream:
         handler:
           backend_group_id: ds77tero4f5h46l.....
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-a
         subnet_id: e9bs1hp7lgdl1g3.....
       - zone_id: {{ region-id }}-b
         subnet_id: e2le8i7hqa216f6.....
       - zone_id: {{ region-id }}-c
         subnet_id: b0cgk1au6fn203f.....
     log_group_id: ckgs4u5km3u8j9f.....
     security_group_ids:
     - enp49ot04g63ih1.....
     created_at: "2022-04-04T02:12:40.160629110Z"
     log_options:
       log_group_id: e23p9bfjvsgra3t.....
       discard_rules:
         - http_codes:
             - "200"
           http_code_intervals:
             - HTTP_3XX
           grpc_codes:
             - OK
           discard_percent: "90"
     ```

  1. (Опционально) Установите новые ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling):
 
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

       log_options {
         log_group_id = "<идентификатор_лог-группы>"
         discard_rule {
           http_codes          = ["200"]
           http_code_intervals = ["HTTP_2XX"]
           grpc_codes          = ["GRPC_OK"]
           discard_percent     = 15
         }
       }
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).

  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```bash
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение L7-балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer get <имя_балансировщика>
     ```

- API

  Воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update).

{% endlist %}

## Удалить обработчик {#delete-listener}

Чтобы удалить обработчик L7-балансировщика:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** напротив имени нужного обработчика нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления обработчика:

     ```bash
     yc alb load-balancer remove-listener --help
     ```

  1. Выполните команду:

     ```bash
     yc alb load-balancer remove-listener <идентификатор или имя балансировщика> \
       --listener-name=<имя обработчика>
     ```

     Результат:

     ```text
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

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).

  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```bash
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение L7-балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer get <имя L7-балансировщика>
     ```

- API

  Воспользуйтесь методом REST API [removeListener](../api-ref/LoadBalancer/removeListener.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/RemoveListener](../api-ref/grpc/load_balancer_service.md#RemoveListener).

{% endlist %}
