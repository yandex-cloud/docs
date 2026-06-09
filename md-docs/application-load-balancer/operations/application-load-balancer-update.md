# Изменить L7-балансировщик

Чтобы изменить параметры L7-балансировщика:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан балансировщик.
  1. Перейдите в сервис **Application Load Balancer**.
  1. Нажмите на имя нужного балансировщика.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Измените необходимые параметры балансировщика:

      1. В блоке **Сетевые настройки** измените [группы безопасности](../concepts/application-load-balancer.md#security-groups):

          * `Без групп` — для балансировщика будет разрешен любой входящий и исходящий трафик. Это наименее безопасный вариант.
          * `Автоматически` — при создании балансировщика будет автоматически создана группа безопасности, разрешающая любой входящий трафик на порте `80` и TCP-трафик для проверки состояния узлов балансировщика на порте `30080`. При этом для балансировщика будет разрешен любой исходящий трафик.
          * `Из списка` — для более гибкого управления трафиком [создайте](../../vpc/operations/security-group-create.md) свои группы безопасности. Вы можете выбрать и привязать к балансировщику одновременно до пяти групп безопасности.

          {% note info %}
          
            Правила групп безопасности могут содержать только адреса в формате CIDR. Нельзя назначить группу, в которой используется другая группа безопасности.
          
            {% endnote %}

      1. В блоке **Размещение** включите или отключите входящий трафик для каждой [зоны доступности](../../overview/concepts/geo-scope.md) в отдельности с помощью опции **Прием трафика**.

      1. В блоке **Настройки автомасштабирования** укажите ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling).

      1. В блоке **Настройки логов**:

          1. Измените [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться логи балансировщика.
          1. Измените [правила отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):
    
              * **HTTP-коды** — измените HTTP-коды.
              * **Классы HTTP-кодов** — измените классы HTTP-кодов.
              * **gRPC-коды** — измените gRPC-коды.
              * **Доля отбрасываемых логов** — измените процент отбрасываемых логов.
    
              Чтобы добавить еще одно правило, нажмите кнопку **Добавить правило отбрасывания логов**.
    
      1. В блоке **Обработчики** измените параметры нужных обработчиков.

  1. Внизу страницы нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения параметров балансировщика:

     ```bash
     yc alb load-balancer update --help
     ```

  1. Выполните команду, указав новые параметры балансировщика. Например, привяжите к балансировщику [группы безопасности](../concepts/application-load-balancer.md#security-groups):

     ```bash
     yc alb load-balancer update <имя_балансировщика> \
       --security-group-id <список_идентификаторов_групп_безопасности>
     ```

     Где `--security-group-id` — новый список от одного до пяти разделенных запятыми идентификаторов [групп безопасности](../concepts/application-load-balancer.md#security-groups). Если не указать этот параметр, то для балансировщика будет разрешен любой трафик.

     Результат:

     ```bash
     id: a5d88ep483cm********
     name: test-balancer2-updated
     folder_id: aoe197919j8e********
     status: ACTIVE
     region_id: ru-central1
     network_id: c64l1c06d151********
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
           http_router_id: a5dv7tjdo9gt********
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: buc4gsmpj8hv********
     log_group_id: eolul9ap0bv0********
     security_group_ids:
       - enpulh2tbrep********
       - enpg05a3ck35********
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

  1. (Опционально) Измените параметры записи [логов](../logs-ref.md) в [Yandex Cloud Logging](../../logging/index.md):

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

          ```text
          done (42s)
          id: ds76g2zpgp3f********
          name: test-load-balancer
          folder_id: b1gug7dbelh********
          ...
          log_options:
            log_group_id: e23p9bcvh6gr********
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

     ```bash
     done (42s)
     id: ds76g8b2op3f********
     name: test-load-balancer
     folder_id: b1gu6g9ielh6********
     status: ACTIVE
     network_id: enp0uulja5s3********
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
           http_router_id: ds7d7b14b3fs********
     - name: teststreamlistener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 51.250.64.197
         ports:
         - "443"
       stream:
         handler:
           backend_group_id: ds77tero4f5h********
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: e9bs1hp7lgdl********
     log_group_id: ckgs4u5km3u8********
     security_group_ids:
     - enp49ot04g63********
     created_at: "2022-04-04T02:12:40.160629110Z"
     log_options:
       log_group_id: e23p9bfjvsgr********
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

     1. Посмотрите описание команды CLI для настройки ограничений:
     
        ```bash
        yc alb load-balancer autoscale --help
        ```
     
     1. Установите ограничения, выполнив команду:
     
        ```bash
        yc alb load-balancer autoscale <имя_или_идентификатор_балансировщика> \
          --min-zone-size <минимум_ресурсных_единиц_в_зоне> \
          --max-size <максимум_ресурсных_единиц_в_сумме>
        ```
     
        Где:
     
        * `--min-zone-size` — минимальное количество ресурсных единиц в каждой зоне доступности. По умолчанию минимум равен 2. Указать минимальное значение меньше 2 нельзя.
        * `--max-size` — максимальное суммарное количество ресурсных единиц. По умолчанию количество не ограничено. Значение должно быть не меньше, чем количество зон доступности балансировщика, умноженное на минимальное количество ресурсных единиц в каждой зоне.
     
        Вы можете указать в команде один из параметров или оба сразу.
     
        Пример:
     
        ```bash
        yc alb load-balancer autoscale test-balancer2 \
          --min-zone-size 3 \
          --max-size 10
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
        created_at: "2022-06-02T12:12:13.624832586Z"
        auto_scale_policy:
          min_zone_size: 3
          max_size: 10
        ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием L7-балансировщика:

     ```hcl
     ...
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "my-load-balancer"
       network_id  = yandex_vpc_network.test-network.id

       allocation_policy {
         location {
           zone_id   = "ru-central1-a"
           subnet_id = yandex_vpc_subnet.test-subnet.id
           security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
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

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в Terraform см. в [документации провайдера](../../terraform/resources/alb_load_balancer.md).

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение L7-балансировщика можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer get <имя_балансировщика>
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с балансировщиками Application Load Balancer 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию балансировщика блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}

## Удалить обработчик {#delete-listener}

Чтобы удалить обработчик L7-балансировщика:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан балансировщик.
  1. Перейдите в сервис **Application Load Balancer**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Обработчики** напротив имени нужного обработчика нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления обработчика:

     ```bash
     yc alb load-balancer remove-listener --help
     ```

  1. Выполните команду:

     ```bash
     yc alb load-balancer remove-listener <имя_или_идентификатор_балансировщика> \
       --listener-name=<имя_обработчика>
     ```

     Результат:

     ```text
     done (50s)
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и удалите блок `listener` в описании L7-балансировщика:

     ```hcl
     ...
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "my-load-balancer"
       network_id  = yandex_vpc_network.test-network.id

       allocation_policy {
         location {
           zone_id   = "ru-central1-a"
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

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в Terraform, см. в [документации провайдера](../../terraform/resources/alb_load_balancer.md).

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение L7-балансировщика можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer get <имя_L7-балансировщика>
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с балансировщиками Application Load Balancer 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию балансировщика блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [removeListener](../api-ref/LoadBalancer/removeListener.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/RemoveListener](../api-ref/grpc/LoadBalancer/removeListener.md).

{% endlist %}