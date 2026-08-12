---
title: Как создать внутренний сетевой балансировщик
description: Следуя данной инструкции, вы сможете создать внутренний сетевой балансировщик.
---

# Создать внутренний сетевой балансировщик

{% note info %}

Чтобы создать [внутренний сетевой балансировщик](../concepts/nlb-types.md), необходима [роль](../security/index.md#load-balancer-private-admin) `load-balancer.privateAdmin`.

{% include [type-update](../../_includes/network-load-balancer/type-update.md) %}

{% endnote %}

Чтобы создать внутренний сетевой балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где нужно создать балансировщик.
  1. [Перейдите]({{ link-console-main }}/link/network-load-balancer/) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя балансировщика. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}** выберите `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_internal }}`.
  1. (Опционально) В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_advanced }}** включите защиту балансировщика от удаления.

      {% note warning %}

      Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика.

      {% endnote %}

  1. {% include [add-listener](../../_includes/network-load-balancer/add-listener.md) %}
  1. {% include [add-target-group](../../_includes/network-load-balancer/add-target-group.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Перед созданием балансировщика [создайте целевую группу](target-group-create.md), чтобы подключить ее к балансировщику.

  1. Посмотрите описание команды CLI для создания сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer create --help
     ```

  1. Чтобы создать внутренний балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md), выполните команду:

     ```bash
     yc load-balancer network-load-balancer create <имя_балансировщика> \
        --type=internal \
        --deletion-protection \
        --listener name=<имя_обработчика>,`
                   `port=<порт>,`
                   `target-port=<целевой_порт>,`
                   `protocol=<протокол>,`
                   `internal-subnet-id=<идентификатор_подсети>,`
                   `internal-ip-version=<версия_IP-адреса>,`
                   `internal-address=<IP-адрес_обработчика> \
        --target-group target-group-id=<идентификатор_целевой_группы>,`
                       `healthcheck-name=<имя_проверки_состояния>,`
                       `healthcheck-interval=<интервал_между_проверками>s,`
                       `healthcheck-timeout=<таймаут_проверки_состояния>s,`
                       `healthcheck-unhealthythreshold=<количество_проваленных_проверок_для_статуса_Unhealthy>,`
                       `healthcheck-healthythreshold=<количество_успешных_проверок_для_статуса_Healthy>,`
                       `healthcheck-tcp-port=<TCP-порт>,`
                       `healthcheck-http-port=<HTTP-порт>,`
                       `healthcheck-http-path=<адрес_URL>
     ```

     Где:

     * `--type` — тип балансировщика.
     * `--deletion-protection` — защита сетевого балансировщика от удаления. Пока опция включена, удалить балансировщик невозможно.

         {% note warning %}

         Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика. 

         {% endnote %}

     * `--listener` — параметры обработчика:
         * `name` — имя обработчика.
         * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
         * `target-port` — целевой порт, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.
         * `protocol` — протокол, по которому будет работать обработчик: `tcp` или `udp`.
         * `internal-subnet-id` — идентификатор подсети.
         * `internal-ip-version` — версия внутреннего IP-адреса: `ipv4` или `ipv6`.
         * `internal-address` — IP-адрес обработчика, не занятый другими ресурсами и относящийся к диапазону подсети, которая указана в свойстве `internal-subnet-id`.

             Если свойство `internal-address` не задано, обработчику внутреннего сетевого балансировщика назначается случайный IP-адрес из диапазона адресов выбранной [подсети](../../vpc/concepts/network.md#subnet).

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

     Подробнее о команде `yc load-balancer network-load-balancer create` читайте в [справочнике {{ yandex-cloud }} CLI](../../cli/cli-ref/load-balancer/cli-ref/network-load-balancer/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать внутренний сетевой балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md):

  1. Опишите в конфигурационном файле параметры ресурса сетевого балансировщика:

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_балансировщика>"
       type = "internal"
       deletion_protection = <защитить_балансировщик_от_удаления>
       listener {
         name = "<имя_обработчика>"
         port = <номер_порта>
         internal_address_spec {
           subnet_id  = "<идентификатор_подсети>"
           ip_version = "<версия_IP-адреса>"
           address    = "<IP-адрес_обработчика>"
         }
       }
       attached_target_group {
         target_group_id = "<идентификатор_целевой_группы>"
         healthcheck {
           name = "<имя_проверки_состояния>"
             http_options {
               port = <номер_порта>
               path = "<адрес_URL>"
             }
         }
       }
     }
     ```

     Где:

     * `name` — имя сетевого балансировщика.
     * `type` — тип сетевого балансировщика. Используйте `internal`, чтобы создать внутренний балансировщик.
     * `deletion_protection` — защита внутреннего сетевого балансировщика от удаления. Пока опция включена, удалить балансировщик невозможно. Значение по умолчанию `false`.

       {% note warning %}

       Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика. 

       {% endnote %}

     * `listener` — параметры обработчика:
       * `name` — имя обработчика.
       * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик, из диапазона от `1` до `32767`.
       * `internal_address_spec` — спецификация обработчика для внутреннего балансировщика:
         * `subnet_id` — идентификатор подсети.
         * `ip_version` — описание внешнего IP-адреса. Укажите версию IP-адреса: `ipv4` или `ipv6`. По умолчанию `ipv4`.
         * `address` — IP-адрес обработчика, не занятый другими ресурсами и относящийся к диапазону подсети, которая указана в поле `subnet_id`.

             Если значение поля `address` не задано, обработчику внутреннего сетевого балансировщика назначается случайный IP-адрес из диапазона адресов выбранной [подсети](../../vpc/concepts/network.md#subnet).
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.

          {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

     Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, в [документации провайдера]({{ tf-provider-link }}/resources/lb_network_load_balancer).

  1. Создайте сетевой балансировщик:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы создать внутренний сетевой балансировщик, воспользуйтесь методом REST API [create](../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Create](../api-ref/grpc/NetworkLoadBalancer/create.md).

{% endlist %}

## Примеры

### Создание внутреннего сетевого балансировщика без обработчика {#without-listener}

Создайте внутренний сетевой балансировщик без обработчика и целевой группы с именем `internal-lb-test-1`.

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать внутренний балансировщик без обработчика, выполните команду:

  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-1 \
     --type=internal
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры ресурса без блока `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "internal-lb-test-1"
       type = "internal"
       deletion_protection = "true"
     ```

     Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор_каталога>",
    "name": "internal-lb-test-1",
    "type": "INTERNAL"
  }
  ```

{% endlist %}

### Создание внутреннего сетевого балансировщика с обработчиком и подключенной целевой группой {#with-listener-and-target-group}

Создайте внутренний сетевой балансировщик с обработчиком и подключенной целевой группой с тестовыми характеристиками:

* Имя `internal-lb-test-2`.
* Параметры обработчика:
    * Имя `test-listener`.
    * Порт `80`.
    * Целевой порт `81`.
    * Протокол `TCP`.
    * Идентификатор подсети `b0cp4drld130********`.
    * Версия IP-адреса `ipv4`.
    * IP-адрес обработчика `192.168.1.25`.
* Идентификатор целевой группы `enpu2l7q9kth********`.
* Параметры проверки состояния целевой группы:
    * Имя `http`.
    * Интервал выполнения проверок состояния `2` секунды.
    * Время ожидания ответа `1` секунда.
    * Порог неработоспособности `2`.
    * Порог работоспособности `2`.
    * Порт для проверок по протоколу HTTP `80`.
    * Адрес URL, по которому будут выполняться проверки `/`.

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-2 \
     --type=internal \
     --listener name=test-listener,`
                `port=80,`
                `target-port=81,`
                `protocol=tcp,`
                `internal-subnet-id=b0cp4drld130********,`
                `internal-ip-version=ipv4,`
                `internal-address=192.168.1.25 \
     --target-group target-group-id=enpu2l7q9kth********,`
                    `healthcheck-name=http,`
                    `healthcheck-interval=2s,`
                    `healthcheck-timeout=1s,`
                    `healthcheck-unhealthythreshold=2,`
                    `healthcheck-healthythreshold=2,`
                    `healthcheck-http-port=80,`
                    `healthcheck-http-path=/
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры ресурса с блоками `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "internal-lb-test" {
       name = "internal-lb-test-2"
       type = "internal"
       deletion_protection = "true"
       listener {
         name        = "test-listener"
         port        = 80
         target_port = 81
         protocol    = "tcp"
         internal_address_spec {
           subnet_id  = "b0cp4drld130********"
           ip_version = "ipv4"
           address    = "192.168.1.25"
         }
       }
       attached_target_group {
         target_group_id = "enpu2l7q9kth********"
         healthcheck {
           name                = "http"
           interval            = 2
           timeout             = 1
           unhealthy_threshold = 2
           healthy_threshold   = 2
           http_options {
             port = 80
             path = "/"
           }
         }
       }
     }
     ```

     Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор_каталога>",
    "name": "internal-lb-test-2",
    "type": "INTERNAL",
    "listenerSpecs": [
      {
        "name": "test-listener",
        "port": "80",
        "protocol": "TCP",
        "targetPort": "81",
        "internalAddressSpec": {
          "subnetId": "b0cp4drld130********",
          "ipVersion": "IPV4",
          "address": "192.168.1.25"
        }
      }
    ],
    "attachedTargetGroups": [
      {
        "targetGroupId": "enpu2l7q9kth********",
        "healthChecks": [
          {
            "name": "http",
            "interval": "2s",
            "timeout": "1s",
            "unhealthyThreshold": "2",
            "healthyThreshold": "2",
            "httpOptions": {
              "port": "80",
              "path": "/"
            }
          }
        ]
      }
    ]
  }
  ```

{% endlist %}
