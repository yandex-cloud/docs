# Создать сетевой балансировщик

{% note info %}

Перед созданием сетевого балансировщика [создайте](target-group-create.md) целевую группу, чтобы подключить ее к балансировщику.

{% endnote %}

{% list tabs %}

- Консоль управления
  
  Чтобы создать [сетевой балансировщик](../concepts/index.md):
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать балансировщик.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. Нажмите кнопку **Создать сетевой балансировщик**.
  1. Задайте имя балансировщика.
  
      {% include [name-format](../../_includes/name-format.md) %}

  1. Назначьте балансировщику публичный IP-адрес. Адрес можно назначить автоматически или выбрать из списка зарезервированных адресов.
  1. В блоке **Обработчики** добавьте [обработчик](../concepts/listener.md):
      1. Нажмите кнопку **Добавить обработчик**.
      1. В открывшемся окне задайте параметры обработчика:

          * **Имя**.
          * **Протокол** — **TCP** или **UDP**.

            {% note info %}

            По умолчанию обработчик работает по протоколу TCP. Чтобы использовать протокол UDP, [запросите в технической поддержке]({{ link-console-support }}/create-ticket) эту возможность.

            {% endnote %}

          * **Порт**, на котором обработчик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
          * **Целевой порт**, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.

      1. Нажмите кнопку **Добавить**.

  1. В блоке **Целевые группы** добавьте [целевую группу](../concepts/target-resources.md):
      1. Нажмите кнопку **Добавить целевую группу**.
      1. Выберите целевую группу или [создайте новую](target-group-create.md):
          * В поле **Целевые группы** выберите ![image](../../_assets/plus-sign.svg) **Создать целевую группу**.
          * В открывшемся окне введите имя целевой группы.
          * Добавьте в целевую группу виртуальные машины.
          * Нажмите кнопку **Создать**.
      1. (Опционально) Под блоком **Проверка состояния** нажмите кнопку **Настроить**. В открывшемся окне задайте параметры [проверки состояния ресурсов](../concepts/health-check.md):
          * **Имя**.
          * **Тип** — **HTTP** или **TCP**. Для проверки по протоколу HTTP в поле **Путь** укажите адрес URL, по которому будут выполняться проверки.
          * **Порт** для проверок. Возможные значения: от `1` до `32767`.
          * **Время ожидания** — время ожидания ответа в секундах.
          * **Интервал** — интервал выполнения проверок состояния в секундах.
          * **Порог работоспособности** — количество успешных проверок, после которого виртуальная машина будет считаться готовой к приему трафика.
          * **Порог неработоспособности** — количество проваленных проверок, после которого на виртуальную машину перестанет подаваться трафик.

      1. Нажмите кнопку **Применить**.
  1. Нажмите кнопку **Создать**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания сетевого балансировщика:
  
     ```bash
     yc load-balancer network-load-balancer create --help
     ```
  
  1. Чтобы создать балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md), выполните команду:
  
     ```bash
     yc load-balancer network-load-balancer create <имя балансировщика> \
        --listener name=<имя обработчика>,`
                  `port=<порт>,`
                  `target-port=<целевой порт>,`
                  `protocol=<протокол: tcp или udp>,`
                  `external-ip-version=<версия IP-адреса: ipv4 или ipv6> \
        --target-group target-group-id=<идентификатор целевой группы>,`
                      `healthcheck-name=<имя проверки состояния>,`
                      `healthcheck-interval=<интервал между проверками>s,`
                      `healthcheck-timeout=<таймаут проверки состояния>s,`
                      `healthcheck-unhealthythreshold=<количество проваленных проверок для статуса Unhealthy>,`
                      `healthcheck-healthythreshold=<количество успешных проверок для статуса Healthy>,`
                      `healthcheck-tcp-port=<TCP-порт>,`
                      `healthcheck-http-port=<HTTP-порт>,`
                      `healthcheck-http-path=<адрес URL, по которому будут выполняться проверки>
     ```

     Где:

     {% include [listener-cli-description](../../_includes/network-load-balancer/listener-cli-description.md) %}

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса сетевого балансировщика.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя сетевого балансировщика>"
       listener {
         name = "<имя обработчика>"
         port = <номер порта>
         external_address_spec {
           ip_version = "<версия IP-адреса: ipv4 или ipv6>"
         }
       }
       attached_target_group {
         target_group_id = "<идентификатор целевой группы>"
         healthcheck {
           name = "<имя проверки состояния>"
           http_options {
             port = <номер порта>
             path = "<адрес URL, по которому будут выполняться проверки>"
           }
         }
       }
     }
     ```

     Где:

     * `name` — имя сетевого балансировщика.
     * `listener` — параметры обработчика:
       * `name` — имя обработчика.
       * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик, из диапазона от `1` до `32767`.
       * `external_address_spec` — спецификация обработчика для внешнего балансировщика:
         * `ip_version` — описание внешнего IP-адреса. Укажите версию IP-адреса: `ipv4` или `ipv6`. По умолчанию `ipv4`.
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.
        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

     Более подробную информацию о параметрах ресурса `yandex_lb_network_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором должен быть размещен сетевой балансировщик, в параметре `folderId`.
  * Имя сетевого балансировщика в параметре `name`.
  * Описание [обработчиков](../concepts/listener.md) в параметре `listenerSpecs`.
  * Идентификаторы [целевых групп](../concepts/target-resources.md) и настройки [проверки состояния их ресурсов](../concepts/health-check.md) в параметре `attachedTargetGroups`.

  Идентификаторы целевых групп можно получить со [списком целевых групп в каталоге](target-group-list.md#list).

{% endlist %}

## Примеры {#examples}

### Создание сетевого балансировщика без обработчика {without-listener}

Создайте сетевой балансировщик без обработчика и целевой группы с именем `test-load-balancer-1`.

{% list tabs %}

- CLI
  
  Выполните следующую команду:
  
  ```bash
  yc load-balancer network-load-balancer create test-load-balancer-1
  ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры ресурса без блока `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "test-load-balancer-1"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор каталога>",
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
* Идентификатор целевой группы `enpu2l7q9kth8906spjn`.
* Параметры проверки состояния ресурсов целевой группы:
    * Имя `http`.
    * Интервал выполнения проверок состояния `2` секунды.
    * Время ожидания ответа `1` секунда.
    * Порог неработоспособности `2`.
    * Порог работоспособности `2`.
    * Порт для проверок по протоколу HTTP `80`.
    * Адрес URL, по которому будут выполняться проверки `/`.

{% list tabs %}

- CLI

  Выполните следующую команду:

  ```bash
  yc load-balancer network-load-balancer create test-load-balancer-2 \
     --listener name=test-listener,`
               `port=80,`
               `target-port=81,`
               `protocol=tcp,`
               `external-ip-version=ipv4 \
     --target-group target-group-id=enpu2l7q9kth8906spjn,`
                   `healthcheck-name=http,`
                   `healthcheck-interval=2s,`
                   `healthcheck-timeout=1s,`
                   `healthcheck-unhealthythreshold=2,`
                   `healthcheck-healthythreshold=2,`
                   `healthcheck-http-port=80,`
                   `healthcheck-http-path=/
  ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры ресурса с блоками `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "test-load-balancer-2"
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
         target_group_id = "enpu2l7q9kth8906spjn"
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

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор каталога>",
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
        "targetGroupId": "b7rjtf12qdeehrj31hri",
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
