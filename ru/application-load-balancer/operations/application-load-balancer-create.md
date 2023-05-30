# Создать L7-балансировщик

Чтобы создать L7-балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан балансировщик.

  1. В списке сервисов выберите **{{ alb-name }}**.

  1. Нажмите кнопку **Создать балансировщик** и выберите **Вручную**.

  1. Введите имя балансировщика: `test-load-balancer`.

  1. В блоке **Сетевые настройки** выберите сеть, в подсетях которой будут размещаться узлы балансировщика, и [подходящие группы безопасности](../concepts/application-load-balancer.md#security-groups) (если соответствующего поля нет, для балансировщика будет разрешен любой входящий и исходящий трафик).

      {% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

  1. (опционально) В блоке **Настройки автомасштабирования** укажите ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling).

      Количество единиц будет меняться автоматически с учетом нагрузки на балансировщик и установленных ограничений. От количества единиц зависит [тарификация балансировщика](../pricing.md).

  1. (опционально) В блоке **Настройки логов**:
      1. Включите опцию **Запись логов**.
      1. Выберите [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи балансировщика.
      1. Нажмите кнопку **Добавить правило отбрасывания логов** и настройте его [параметры](../concepts/application-load-balancer.md#discard-logs-rules):

          * **HTTP-коды** — добавьте HTTP-коды.
          * **Классы HTTP-кодов** — добавьте классы HTTP-кодов.
          * **gRPC-коды** — добавьте gRPC-коды.
          * **Доля отбрасываемых логов** — добавьте процент отбрасываемых логов.
      
          Вы можете задать больше одного правила.


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

     ```bash
     yc alb load-balancer create --help
     ```

  1. Выполните команду, указав сеть и подсети, в которых будут размещаться узлы балансировщика, а также [подходящие группы безопасности](../concepts/application-load-balancer.md#security-groups):

     ```bash
     yc alb load-balancer create <имя_балансировщика> \
       --network-name <имя_сети> \
       --location subnet-name=<имя_подсети>,zone=<зона_доступности>
     ```
     
     Опцию `--location` можно повторять несколько раз, чтобы указать разные зоны доступности и подсети.

     Результат:
     
          
     ```yaml
     done (1m40s)
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
     ```
     

 
  1. (опционально) Установите ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling):
 
     {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

  1. (опционально) Установите параметры записи [логов](../logs-ref.md) в [{{ cloud-logging-full-name }}](../../logging/):

      1. Посмотрите описание команды CLI для добавления логирования в балансировщик:

          ```bash
          yc alb load-balancer logging --help
          ```

      1. Привяжите лог-группу к балансировщику и настройте [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):

          ```bash
          yc alb load-balancer logging <имя_балансировщика> \
            --log-group-id <идентификатор_лог-группы> \
            --enable \
            --discard codes=[<HTTP-код>,<Класс_HTTP-кодов>,<gRPC-код>],percent=<доля_отбрасываемых_логов>
          ```

          Где:

          * `--log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md).
          * `--discard` — правило отбрасывания логов. Параметры правила:
            * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
            * `percent` — доля отбрасываемых логов в процентах.
            
            Вы можете задать больше одного правила.

          Результат:

          ```yaml
          done (42s)
          id: ds76g83js9gfej12nab6
          name: test-load-balancer
          folder_id: b1gu33ev7lh690at5bm7
          ...
          log_options:
            log_group_id: e23p9bfjvsgra3tliktf
            discard_rules:
              - http_codes:
                  - "200"
                http_code_intervals:
                  - HTTP_3XX
                grpc_codes:
                  - OK
                discard_percent: "90"
          ```

  1. Добавьте обработчик для L7-балансировщика:

     * HTTP-обработчик:

       1. Посмотрите описание команды CLI для добавления HTTP-обработчика L7-балансировщика:

          ```bash
          yc alb load-balancer add-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```bash
          yc alb load-balancer add-listener <имя балансировщика> \
            --listener-name <имя обработчика> \
            --http-router-id <идентификатор HTTP-роутера> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     * Stream-обработчик:

       1. Посмотрите описание команды CLI для добавления Stream-обработчика L7-балансировщика:

          ```bash
          yc alb load-balancer add-stream-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```bash
          yc alb load-balancer add-stream-listener <имя балансировщика> \
            --listener-name=<имя обработчика> \
            --backend-group-id=<идентификатор группы бэкендов> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     Результат после добавления двух обработчиков:
 
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

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "<имя_L7-балансировщика>"
       network_id  = "<идентификатор_сети>"

       allocation_policy {
         location {
           zone_id   = "<зона_доступности>"
           subnet_id = "<идентификатор_подсети>" 
         }
       }

       listener {
         name = "<имя_обработчика>"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [ 9000 ]
         }
         http {
           handler {
             http_router_id = "<идентификатор_HTTP-роутера>"
           }
         }
       }

       log_options {
         log_group_id = "<идентификатор_лог-группы>"
         discard_rule {
           http_codes          = ["<HTTP-код>"]
           http_code_intervals = ["<класс_HTTP-кодов>"]
           grpc_codes          = ["<gRPC-код>"]
           discard_percent     = <доля_отбрасываемых_логов>
         }
       }
     }
     ```

     Где:

     * `name` — имя L7-балансировщика. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `network_id` — идентификатор сети.
     * `allocation_policy` — описание [расположения узлов](../../application-load-balancer/concepts/application-load-balancer.md#lb-location) L7-балансировщика. Укажите идентификаторы зоны доступности и подсети.
     * `listener` — описание параметров [обработчика](../../application-load-balancer/concepts/application-load-balancer.md#listener) для L7-балансировщика:
        * `name` — имя обработчика. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

        * `endpoint` — описание адресов и портов обработчика. Укажите внешний IPv4-адрес и порт для приема трафика. Если параметр `external_ipv4_address` не задан, то публичный адрес будет выделен автоматически.
        * `http` — описание HTTP-приемника для обработчика. Укажите идентификатор HTTP-роутера.
        * `log_options` — (опционально) параметры записи [логов](../logs-ref.md) в [{{ cloud-logging-full-name }}](../../logging/):
          * `log_group_id` — идентификатор [лог-группы](../../logging/concepts/log-group.md).
          * `discard_rule` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):
            * `http_codes` — HTTP-коды.
            * `http_code_intervals` — классы HTTP-кодов.
            * `grpc_codes` — gRPC-коды.
            * `discard_percent` — доля отбрасываемых логов в процентах.

            Вы можете задать больше одного правила.

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/alb_load_balancer).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc alb load-balancer list
        ```

- API

  Воспользуйтесь методом REST API [create](../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Create](../api-ref/grpc/load_balancer_service.md#Create).

{% endlist %}
