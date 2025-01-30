---
title: Как создать L7-балансировщик в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете создать L7-балансировщик.
---

# Создать L7-балансировщик

Чтобы создать [L7-балансировщик](../concepts/application-load-balancer.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}** и выберите **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
  1. Введите имя балансировщика.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите:
     1. [Сеть](../../vpc/concepts/network.md#network), в [подсетях](../../vpc/concepts/network.md#subnet) которой будут размещаться узлы балансировщика.
     1. Подходящие [группы безопасности](../concepts/application-load-balancer.md#security-groups):

        {% include [security-groups](../../_includes/application-load-balancer/security-groups.md) %}

        {% include [security-groups-note](../_includes_service/security-groups-note.md) %}

  1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите для узлов балансировщика подсети в разных [зонах доступности](../../overview/concepts/geo-scope.md) и включите прием трафика в этих подсетях.

      Чтобы не создавать узел балансировщика в определенной зоне доступности, нажмите ![xmark](../../_assets/console-icons/xmark.svg) в соответствующей строке.


  1. (Опционально) В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** включите или отключите входящий трафик для каждой зоны в отдельности с помощью опции **{{ ui-key.yacloud.alb.label_disable-traffic }}**.

  1. (Опционально) В блоке **{{ ui-key.yacloud.alb.section_autoscale-settings }}** укажите ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling).

     Количество единиц будет меняться автоматически с учетом нагрузки на балансировщик и установленных ограничений. От количества единиц зависит [тарификация балансировщика](../pricing.md).
  1. (Опционально) В блоке **{{ ui-key.yacloud.alb.section_logs-settings }}**:
     1. Включите опцию **{{ ui-key.yacloud.alb.label_log-requests }}**.
     1. Выберите [лог-группу](../../logging/concepts/log-group.md) [{{ cloud-logging-full-name }}](../../logging/), в которую будут записываться логи балансировщика.
     1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-discard-rule }}** и настройте его [параметры](../concepts/application-load-balancer.md#discard-logs-rules):
        * **{{ ui-key.yacloud.alb.label_discard-http-codes }}** — добавьте HTTP-коды.
        * **{{ ui-key.yacloud.alb.label_discard-http-code-intervals }}** — добавьте классы HTTP-кодов.
        * **{{ ui-key.yacloud.alb.label_discard-grpc-codes }}** — добавьте gRPC-коды.
        * **{{ ui-key.yacloud.alb.label_discard-percent }}** — добавьте процент отбрасываемых логов.

        Вы можете задать больше одного правила.

  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**. Задайте настройки обработчика:
     1. Введите имя обработчика.
     1. (Опционально) Включите опцию **{{ ui-key.yacloud.alb.section_external-address-specs }}**. Укажите **{{ ui-key.yacloud.alb.label_port }}**: `80` и выберите **{{ ui-key.yacloud.common.type }}**:
        * `{{ ui-key.yacloud.alb.label_address-auto }}`.
        * `{{ ui-key.yacloud.alb.label_address-list }}` — в появившемся поле справа выберите адрес в выпадающем списке.
     1. (Опционально) Включите опцию **{{ ui-key.yacloud.alb.section_internal-address-specs }}**. Укажите **{{ ui-key.yacloud.alb.label_port }}** и выберите **{{ ui-key.yacloud.common.label_subnet }}** в выпадающем списке.
     1. В блоке **{{ ui-key.yacloud.alb.section_common-address-specs }}** выберите тип обработчика: `{{ ui-key.yacloud.alb.label_listener-type-http }}` или `{{ ui-key.yacloud.alb.label_listener-type-stream }}`.

        Для `{{ ui-key.yacloud.alb.label_listener-type-http }}` выберите:
        * Протокол: `{{ ui-key.yacloud.alb.label_proto-http-plain }}`,`{{ ui-key.yacloud.alb.label_proto-http-tls }}` или `{{ ui-key.yacloud.alb.label_redirect-to-https }}`.
        * [HTTP-роутер](http-router-create.md) в выпадающем списке.

        Для `{{ ui-key.yacloud.alb.label_listener-type-stream }}` выберите протокол:
        * `{{ ui-key.yacloud.alb.label_proto-stream-plain }}`: выберите **{{ ui-key.yacloud.alb.label_backend-groups }}** в выпадающем списке.
        * `{{ ui-key.yacloud.alb.label_proto-stream-tls }}`: в блоке **{{ ui-key.yacloud.alb.section_default-sni-match }}** выберите **{{ ui-key.yacloud.alb.label_certificate }}** и **{{ ui-key.yacloud.alb.label_backend-groups }}** в выпадающих списках.
  1. При необходимости добавьте дополнительные обработчики.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для создания L7-балансировщика:

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
     region_id: {{ region-id }}
     network_id: c64l1c06d151********
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-a
         subnet_id: buc4gsmpj8hv********
     log_group_id: eolul9ap0bv0********
     security_group_ids:
       - enpulh2tbrep********
       - enpg05a3ck35********
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

  1. (Опционально) Установите ограничения на количество [ресурсных единиц](../concepts/application-load-balancer.md#lcu-scaling):

     {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

  1. (Опционально) Установите параметры записи [логов](../logs-ref.md) в [{{ cloud-logging-full-name }}](../../logging/):
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
       - zone_id: {{ region-id }}-a
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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

     * `network_id` — идентификатор сети, в которой создается балансировщик.
     * `security_group_ids` (опционально) — список от одного до пяти разделенных запятыми идентификаторов [групп безопасности](../concepts/application-load-balancer.md#security-groups).
         Если не указать этот параметр, то для балансировщика будет разрешен любой трафик.
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

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).
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

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

        ```bash
        yc alb load-balancer list
        ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Create](../api-ref/grpc/LoadBalancer/create.md).

{% endlist %}