# Создать L7-балансировщик

Чтобы создать [L7-балансировщик](../concepts/application-load-balancer.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан балансировщик.
  1. Перейдите в сервис **Application Load Balancer**.
  1. Нажмите кнопку **Создать L7-балансировщик** и выберите **Вручную**.
  1. Введите имя балансировщика.
  1. В блоке **Сетевые настройки** выберите:
     1. [Сеть](../../vpc/concepts/network.md#network), в [подсетях](../../vpc/concepts/network.md#subnet) которой будут размещаться узлы балансировщика.
     1. Подходящие [группы безопасности](../concepts/application-load-balancer.md#security-groups):

        * `Без групп` — для балансировщика будет разрешен любой входящий и исходящий трафик. Это наименее безопасный вариант.
        * `Автоматически` — при создании балансировщика будет автоматически создана группа безопасности, разрешающая любой входящий трафик на порте `80` и TCP-трафик для проверки состояния узлов балансировщика на порте `30080`. При этом для балансировщика будет разрешен любой исходящий трафик.
        * `Из списка` — для более гибкого управления трафиком [создайте](../../vpc/operations/security-group-create.md) свои группы безопасности. Вы можете выбрать и привязать к балансировщику одновременно до пяти групп безопасности.

        {% note info %}
        
          Правила групп безопасности могут содержать только адреса в формате CIDR. Нельзя назначить группу, в которой используется другая группа безопасности.
        
          {% endnote %}

  1. В блоке **Размещение** выберите для узлов балансировщика подсети в разных [зонах доступности](../../overview/concepts/geo-scope.md) и включите прием трафика в этих подсетях.

      Чтобы не создавать узел балансировщика в определенной зоне доступности, нажмите ![xmark](../../_assets/console-icons/xmark.svg) в соответствующей строке.


  1. (Опционально) В блоке **Размещение** включите или отключите входящий трафик для каждой зоны в отдельности с помощью опции **Прием трафика**.

  1. (Опционально) В блоке **Настройки автомасштабирования** укажите ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling).

     Количество единиц будет меняться автоматически с учетом нагрузки на балансировщик и установленных ограничений. От количества единиц зависит [тарификация балансировщика](../pricing.md).
  1. (Опционально) В блоке **Настройки логов**:
     1. Включите опцию **Запись логов**.
     1. Выберите [лог-группу](../../logging/concepts/log-group.md) [Yandex Cloud Logging](../../logging/index.md), в которую будут записываться логи балансировщика.
     1. Нажмите кнопку **Добавить правило отбрасывания логов** и настройте его [параметры](../concepts/application-load-balancer.md#discard-logs-rules):
        * **HTTP-коды** — добавьте HTTP-коды.
        * **Классы HTTP-кодов** — добавьте классы HTTP-кодов.
        * **gRPC-коды** — добавьте gRPC-коды.
        * **Доля отбрасываемых логов** — добавьте процент отбрасываемых логов.

        Вы можете задать больше одного правила.

  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:
     1. Введите имя обработчика.
     1. (Опционально) Включите опцию **Публичный IP-адрес**. Укажите **Порт**: `80` и выберите **Тип**:
        * `Автоматически`.
        * `Список` — в появившемся поле справа выберите адрес в выпадающем списке.
     1. (Опционально) Включите опцию **Внутренний IP-адрес**. Укажите **Порт** и выберите **Подсеть** в выпадающем списке.
     1. В блоке **Приём и обработка трафика** выберите тип обработчика: `HTTP` или `Stream`.

        Для `HTTP` выберите:
        * Протокол: `HTTP`,`HTTPS` или `Перенаправлять на HTTPS`.
        * [HTTP-роутер](http-router-create.md) в выпадающем списке.

        Для `Stream` выберите протокол:
        * `Открытый`: выберите **Группы бэкендов** в выпадающем списке.
        * `Зашифрованный`: в блоке **Основной обработчик** выберите **Сертификаты** и **Группы бэкендов** в выпадающих списках.
  1. При необходимости добавьте дополнительные обработчики.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для создания L7-балансировщика:

     ```bash
     yc alb load-balancer create --help
     ```

  1. Выполните команду:

     ```bash
     yc alb load-balancer create <имя_балансировщика> \
       --network-name <имя_сети> \
       --security-group-id <список_идентификаторов_групп_безопасности> \
       --location subnet-name=<имя_подсети>,zone=<зона_доступности>
     ```

     Где:
     * `<имя_балансировщика>` — имя создаваемого балансировщика.
     * `--network-name` — имя сети, в которой создается балансировщик.
     * `--security-group-id` (опционально) — список от одного до пяти разделенных запятыми идентификаторов [групп безопасности](../concepts/application-load-balancer.md#security-groups). Если не указать этот параметр, то для балансировщика будет разрешен любой трафик.
     * `--location` — подсеть и зона доступности. Опцию можно повторять несколько раз, чтобы указать разные зоны доступности и подсети.

     Результат:

     ```text
     done (1m40s)
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
     security_group_ids:
       - enpulh2tbrep********
       - enpg05a3ck35********
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

  1. (Опционально) Установите ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling):

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

  1. (Опционально) Установите параметры записи [логов](../logs-ref.md) в [Yandex Cloud Logging](../../logging/index.md):
     1. Посмотрите описание команды CLI для добавления логирования в балансировщик:

        ```bash
        yc alb load-balancer logging --help
        ```

     1. Привяжите лог-группу к балансировщику и настройте [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):

        ```bash
        yc alb load-balancer logging <имя_балансировщика> \
          --log-group-id <идентификатор_лог-группы> \
          --enable \
          --discard codes=[<HTTP-код>,<класс_HTTP-кодов>,<gRPC-код>],percent=<доля_отбрасываемых_логов>
        ```

        Где:
        * `--log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md).
        * `--discard` — правило отбрасывания логов. Параметры правила:
          * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
          * `percent` — доля отбрасываемых логов в процентах.

        Вы можете задать больше одного правила.

        Результат:

        ```text
        done (42s)
        id: ds76g83js9gf********
        name: test-load-balancer
        ...
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

  1. Добавьте обработчик для L7-балансировщика:
     * HTTP-обработчик.
       1. Посмотрите описание команды CLI для добавления HTTP-обработчика L7-балансировщика:

          ```bash
          yc alb load-balancer add-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```bash
          yc alb load-balancer add-listener <имя_балансировщика> \
            --listener-name <имя_обработчика> \
            --http-router-id <идентификатор_HTTP-роутера> \
            --external-ipv4-endpoint port=<порт_обработчика>
          ```

     * Stream-обработчик.
       1. Посмотрите описание команды CLI для добавления Stream-обработчика L7-балансировщика:

          ```bash
          yc alb load-balancer add-stream-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```bash
          yc alb load-balancer add-stream-listener <имя_балансировщика> \
            --listener-name=<имя_обработчика> \
            --backend-group-id=<идентификатор_группы_бэкендов> \
            --external-ipv4-endpoint port=<порт_обработчика>
          ```

     Результат после добавления двух обработчиков:
 
     ```text
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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_alb_load_balancer" "test-balancer" {
        name        = "<имя_L7-балансировщика>"
        network_id  = "<идентификатор_сети>"
        security_group_ids = ["<список_идентификаторов_групп_безопасности>"]

        allocation_policy {
          location {
            zone_id   = "<зона_доступности>"
            subnet_id = "<идентификатор_подсети>" 
          }
        }

        # HTTP-обработчик
        listener {
          name = "<имя_HTTP-обработчика>"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [<порт>]
          }
          http {
            handler {
              http_router_id = "<идентификатор_HTTP-роутера>"
            }
          }
        }

        # Stream-обработчик
        listener {
          name = "<имя_Stream-обработчика>"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [<порт>]
          }
          stream {
            handler {
              backend_group_id = "<идентификатор_группы_бэкендов>"
              idle_timeout     = "<время_ожидания>"
            }
          }
        }

        # TLS-обработчик
        listener {
          name = "<имя_TLS-обработчика>"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [<порт>]
          }
          tls {
            default_handler {
              certificate_ids = ["<идентификаторы_сертификатов>"]
              stream_handler {
                backend_group_id = "<идентификатор_группы_бэкендов>"
                idle_timeout     = "<время_ожидания>"
              }
            }
            sni_handler {
              name         = "имя_SNI-обработчика"
              server_names = ["имена_серверов"]
              handler {
                certificate_ids = ["<идентификаторы_сертификатов>"]
                stream_handler {
                  backend_group_id = "<идентификатор_группы_бэкендов>"
                  idle_timeout     = "<время_ожидания>"
                }
              }
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

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `network_id` — идентификатор сети, в которой создается балансировщик.
      * `security_group_ids` (опционально) — список от одного до пяти разделенных запятыми идентификаторов [групп безопасности](../concepts/application-load-balancer.md#security-groups).

          Если не указать этот параметр, то для балансировщика будет разрешен любой трафик.

      * `allocation_policy` — описание [расположения узлов](../concepts/application-load-balancer.md#lb-location) L7-балансировщика. Укажите идентификаторы зоны доступности и подсети.
      * `listener` (опционально) — описание параметров [обработчика](../concepts/application-load-balancer.md#listener) для L7-балансировщика. Вы можете указать один или несколько обработчиков.

          * `name` — имя обработчика. Формат имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

          * `endpoint` — описание адресов и портов обработчика. Укажите внешний IPv4-адрес и порт для приема трафика. Если параметр `external_ipv4_address` не задан, то публичный адрес будет выделен автоматически.
          * `ports` — один или несколько портов. Порты обработчиков не должны совпадать.
          * `http` — описание HTTP-приемника для обработчика:

              * `http_router_id` — идентификатор HTTP-роутера.

        * `stream` — описание Stream-приемника для обработчика.

            * `backend_group_id` — идентификатор группы бэкендов с типом `Stream`, на которую будут направляться входящие TCP-соединения.
            * `idle_timeout` (опционально) — время ожидания без активности, после которого соединение закрывается. Например: `"10s"`, `"5m"`, `"1h"`. Значение `"0"` отключает таймаут. По умолчанию — 1 час.

        * `tls` — описание TLS-обработчика:

            * `default_handler` — обработчик по умолчанию для TLS:

                * `certificate_ids` — список идентификаторов [сертификатов](../../certificate-manager/concepts/index.md#types) Yandex Certificate Manager.
                * `stream_handler` — параметры Stream-обработчика:

                    * `backend_group_id` — идентификатор группы бэкендов с типом `Stream`.
                    * `idle_timeout` (опционально) — время ожидания без активности, после которого соединение закрывается. Например: `"10s"`, `"5m"`, `"1h"`. Значение `"0"` отключает таймаут. По умолчанию — 1 час.

            * `sni_handler` — описание SNI-обработчика:

                * `name` — имя обработчика. Формат имени:

                  * длина — от 3 до 63 символов;
                  * может содержать строчные буквы латинского алфавита, цифры и дефисы;
                  * первый символ — буква, последний — не дефис.

                * `server_names` — имена серверов, которым соответствует SNI-обработчик.
                * `handler` — параметры SNI-обработчика:

                    * `certificate_ids` — список идентификаторов сертификатов Yandex Certificate Manager.
                    * `stream_handler` — параметры Stream-обработчика:

                        * `backend_group_id` — идентификатор группы бэкендов с типом `Stream`.
                        * `idle_timeout` (опционально) — время ожидания без активности, после которого соединение закрывается. Например: `"10s"`, `"5m"`, `"1h"`. Значение `"0"` отключает таймаут. По умолчанию — 1 час.

      * `log_options` — (опционально) параметры записи [логов](../logs-ref.md) в [Yandex Cloud Logging](../../logging/index.md):

          * `log_group_id` — идентификатор [лог-группы](../../logging/concepts/log-group.md).
          * `discard_rule` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):

            * `http_codes` — HTTP-коды.
            * `http_code_intervals` — классы HTTP-кодов.
            * `grpc_codes` — gRPC-коды.
            * `discard_percent` — доля отбрасываемых логов в процентах.

            Вы можете задать больше одного правила.

      Подробнее о параметрах ресурса `yandex_alb_load_balancer` в [документации провайдера](../../terraform/resources/alb_load_balancer.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

          После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

          ```bash
          yc alb load-balancer list
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

  Воспользуйтесь методом REST API [create](../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Create](../api-ref/grpc/LoadBalancer/create.md).

{% endlist %}