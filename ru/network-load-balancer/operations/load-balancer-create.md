---
title: "Как создать сетевой балансировщик"
description: "Следуя данной инструкции, вы сможете создать сетевой балансировщик."
---

# Создать сетевой балансировщик

{% note info %}

Перед созданием сетевого балансировщика [создайте](target-group-create.md) целевую группу, чтобы подключить ее к балансировщику.

{% include [type-update](../../_includes/network-load-balancer/type-update.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  Чтобы создать [сетевой балансировщик](../concepts/index.md):
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. Задайте имя балансировщика. Требования к имени:
  
      {% include [name-format](../../_includes/name-format.md) %}

  1. Назначьте балансировщику публичный IP-адрес. Адрес можно назначить автоматически или выбрать из списка зарезервированных адресов.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}** добавьте [обработчик](../concepts/listener.md):
      1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
      1. В открывшемся окне задайте параметры обработчика:

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}` или `{{ ui-key.yacloud.common.label_udp }}`.

            {% note info %}

            По умолчанию обработчик работает по протоколу TCP. Чтобы использовать протокол UDP, [запросите в технической поддержке]({{ link-console-support }}) эту возможность.

            {% endnote %}

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**, на котором обработчик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** добавьте [целевую группу](../concepts/target-resources.md):
      1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
      1. Выберите целевую группу или [создайте новую](target-group-create.md):
          * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** выберите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
          * В открывшемся окне введите имя целевой группы.
          * Добавьте в целевую группу виртуальные машины.
          * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. (Опционально) Под блоком **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}** нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. В открывшемся окне задайте параметры [проверки состояния ресурсов](../concepts/health-check.md):
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** — `{{ ui-key.yacloud.common.label_http }}` или `{{ ui-key.yacloud.common.label_tcp }}`. Для проверки по протоколу HTTP в поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** укажите адрес URL, по которому будут выполняться проверки.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** для проверок. Возможные значения: от `1` до `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** — время ожидания ответа в секундах. Возможные значения: от `1` до `60`. Интервал должен быть больше времени ожидания минимум на 1 секунду.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** — интервал выполнения проверок состояния в секундах. Возможные значения: от `1` до `60`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** — количество успешных проверок, после которого виртуальная машина будет считаться готовой к приему трафика.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** — количество проваленных проверок, после которого на виртуальную машину перестанет подаваться трафик.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания сетевого балансировщика:
  
     ```bash
     yc load-balancer network-load-balancer create --help
     ```

  1. Чтобы создать балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md), выполните команду:
  
     ```bash
     yc load-balancer network-load-balancer create <имя_балансировщика> \
        --listener name=<имя_обработчика>,`
                  `port=<порт>,`
                  `target-port=<целевой_порт>,`
                  `protocol=<протокол>,`
                  `external-ip-version=<версия_IP-адреса> \
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

     {% include [listener-cli-description](../../_includes/network-load-balancer/listener-cli-description.md) %}

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса сетевого балансировщика.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_балансировщика>"
       deletion_protection = "<защита_от_удаления>"
       listener {
         name = "<имя_обработчика>"
         port = <номер_порта>
         external_address_spec {
           ip_version = "<версия_IP-адреса>"
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
     * `deletion_protection` — защита сетевого балансировщика от удаления. Пока опция включена, балансировщик удалить невозможно. Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика. Значение по умолчанию `false`.
     * `listener` — параметры обработчика:
       * `name` — имя обработчика.
       * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик, из диапазона от `1` до `32767`.
       * `external_address_spec` — спецификация обработчика для внешнего балансировщика:
         * `ip_version` — описание внешнего IP-адреса. Укажите версию IP-адреса: `ipv4` или `ipv6`. По умолчанию `ipv4`.
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.

          {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

     Более подробную информацию о параметрах ресурса `yandex_lb_network_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы создать новый сетевой балансировщик, воспользуйтесь методом REST API [create](../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Create](../api-ref/grpc/network_load_balancer_service.md#Create).

{% endlist %}

## Примеры {#examples}

### Создание сетевого балансировщика без обработчика {without-listener}

Создайте сетевой балансировщик без обработчика и целевой группы с именем `test-load-balancer-1`.

{% list tabs group=instructions %}

- CLI {#cli}
  
  Выполните следующую команду:
  
  ```bash
  yc load-balancer network-load-balancer create test-load-balancer-1
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры ресурса без блока `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "test-load-balancer-1"
       deletion_protection = "true"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор_каталога>",
    "name": "test-load-balancer-1",
    "type": "EXTERNAL"
  }
  ```

{% endlist %}

### Создание сетевого балансировщика с обработчиком и подключенной целевой группой {with-listener-and-target-group}

Создайте сетевой балансировщик с обработчиком и подключенной целевой группой с тестовыми характеристиками:

* Имя `test-load-balancer-2`.
* Параметры обработчика:
    * Имя `test-listener`.
    * Порт `80`.
    * Целевой порт `81`.
    * Протокол `TCP`.
    * Версия IP-адреса `ipv4`.
* Идентификатор целевой группы `enpu2l7q9kth********`.
* Параметры проверки состояния ресурсов целевой группы:
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
  yc load-balancer network-load-balancer create test-load-balancer-2 \
     --listener name=test-listener,`
               `port=80,`
               `target-port=81,`
               `protocol=tcp,`
               `external-ip-version=ipv4 \
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
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "test-load-balancer-2"
       deletion_protection = "true"
       listener {
         name        = "test-listener"
         port        = 80
         target_port = 81
         protocol    = "tcp"
         external_address_spec {
           ip_version = "ipv4"
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

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор_каталога>",
    "name": "test-load-balancer-2",
    "type": "EXTERNAL",
    "listenerSpecs": [
      {
        "name": "test-listener",
        "port": "80",
        "protocol": "TCP",
        "targetPort": "81",
        "externalAddressSpec": {
          "ipVersion": "IPV4"
        }
      }
    ],
    "attachedTargetGroups": [
      {
        "targetGroupId": "b7rjtf12qdee********",
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
