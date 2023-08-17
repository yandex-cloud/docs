# Создать внутренний сетевой балансировщик

{% note info %}

Для создания внутреннего сетевого балансировщика необходима роль `load-balancer.privateAdmin`.

{% endnote %}

{% note info %}

Обработчику внутреннего сетевого балансировщика назначается случайный IP-адрес из диапазона адресов выбранной [подсети](../../vpc/concepts/network.md#subnet).

{% endnote %}

{% list tabs %}

- Консоль управления
  
  Чтобы создать [внутренний сетевой балансировщик](../concepts/nlb-types.md):
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где нужно создать балансировщик.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. Нажмите кнопку **Создать сетевой балансировщик**.
  1. Задайте имя балансировщика.
  
      {% include [name-format](../../_includes/name-format.md) %}

  1. Выберите тип балансировщика — **Внутренний**. 
  1. В блоке **Обработчики** добавьте [обработчик](../concepts/listener.md):
      1. Нажмите кнопку **Добавить обработчик**.
      1. В открывшемся окне задайте параметры обработчика:
          * **Имя**.
          * **Подсеть**, в которой балансировщик будет перенаправлять трафик.
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
          * Добавьте в целевую группу [виртуальные машины](../../glossary/vm.md).
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
  
  1. Перед созданием балансировщика [создайте целевую группу](target-group-create.md), чтобы подключить ее к балансировщику.

  1. Посмотрите описание команды CLI для создания сетевого балансировщика:
  
     ```bash
     yc load-balancer network-load-balancer create --help
     ```
  
  1. Чтобы создать внутренний балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md), выполните команду:
  
     ```bash
     yc load-balancer network-load-balancer create <имя_балансировщика> \
        --type=internal \
        --listener name=<имя_обработчика>,`
                  `port=<порт>,`
                  `target-port=<целевой_порт>,`
                  `protocol=<протокол:_tcp_или_udp>,`
                  `internal-subnet-id=<идентификатор_подсети>,`
                  `internal-ip-version=<версия_IP-адреса:_ipv4_или_ipv6> \
        --target-group target-group-id=<идентификатор_целевой_группы>,`
                      `healthcheck-name=<имя_проверки_состояния>,`
                      `healthcheck-interval=<интервал_между_проверками>s,`
                      `healthcheck-timeout=<таймаут_проверки_состояния>s,`
                      `healthcheck-unhealthythreshold=<количество_проваленных_проверок_для_статуса_Unhealthy>,`
                      `healthcheck-healthythreshold=<количество_успешных_проверок_для_статуса_Healthy>,`
                      `healthcheck-tcp-port=<TCP-порт>,`
                      `healthcheck-http-port=<HTTP-порт>,`
                      `healthcheck-http-path=<адрес_URL,_по_которому_будут_выполняться_проверки>
     ```

     Где:

     * `type` — тип балансировщика.
     * `listener` — параметры обработчика:
         * `name` — имя обработчика.
         * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
         * `target-port` — целевой порт, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.
         * `protocol` — протокол, по которому будет работать обработчик: `tcp` или `udp`.
         * `internal-subnet-id` — идентификатор подсети.
         * `internal-ip-version` — версия внутреннего IP-адреса: `ipv4` или `ipv6`.

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать внутренний сетевой балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md):

  1. Опишите в конфигурационном файле параметры ресурса сетевого балансировщика:

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_сетевого_балансировщика>"
       type = "internal"
       deletion_protection = "<защита_от_удаления:_true_или_false>"
       listener {
         name = "<имя_обработчика>"
         port = <номер_порта>
         internal_address_spec {
           subnet_id = "<идентификатор_подсети>"
           ip_version = "<версия_IP-адреса:_ipv4_или_ipv6>"
         }
       attached_target_group {
         target_group_id = "<идентификатор_целевой_группы>"
         healthcheck {
           name = "<имя_проверки_состояния>"
             http_options {
               port = <номер_порта>
               path = "<адрес_URL,_по_которому_будут_выполняться_проверки>"
             }
         }
       }
     }
     ```

     Где:

     * `name` — имя сетевого балансировщика.
     * `type` — тип сетевого балансировщика. Используйте `internal`, чтобы создать внутренний балансировщик.
     * `deletion_protection` — защита внутреннего сетевого балансировщика от удаления. Пока опция включена, удалить балансировщик невозможно. Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика. Значение по умолчанию `false`.
     * `listener` — параметры обработчика:
       * `name` — имя обработчика.
       * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик, из диапазона от `1` до `32767`.
       * `internal_address_spec` — спецификация обработчика для внешнего балансировщика:
         * `subnet_id` — идентификатор подсети.
         * `ip_version` — описание внешнего IP-адреса. Укажите версию IP-адреса: `ipv4` или `ipv6`. По умолчанию `ipv4`.
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.
        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Создайте сетевой балансировщик:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором должен быть размещен сетевой балансировщик, в параметре `folderId`.
  * Имя сетевого балансировщика в параметре `name`.
  * Тип сетевого балансировщика в параметре `type`. Используйте `INTERNAL`, чтобы создать внутренний балансировщик.
  * Описание [обработчиков](../concepts/listener.md) в параметре `listenerSpecs`.
  * Идентификаторы [целевых групп](../concepts/target-resources.md) и настройки [проверки состояния их ресурсов](../concepts/health-check.md) в параметре `attachedTargetGroups`.

  Идентификаторы целевых групп можно получить со [списком целевых групп в каталоге](target-group-list.md#list).

- API

  Чтобы создать внутренний сетевой балансировщик, воспользуйтесь методом REST API [create](../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Create](../api-ref/grpc/network_load_balancer_service.md#Create).

{% endlist %}

## Примеры

### Создание внутреннего сетевого балансировщика без обработчика {#without-listener}

Создайте внутренний сетевой балансировщик без обработчика и целевой группы с именем `internal-lb-test-1`.

{% list tabs %}

- CLI
  
  Чтобы создать внутренний балансировщик без обработчика, выполните команду:
  
  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-1 \
     --type=internal
  ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры ресурса без блока `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "internal-lb-test-1"
       type = "internal"
       deletion_protection = "true"
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

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
* Идентификатор целевой группы `enpu2l7q9kth********`.
* Параметры проверки состояния целевой группы:
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
  yc load-balancer network-load-balancer create internal-lb-test-2 \
     --type=internal \
     --listener name=test-listener,`
               `port=80,`
               `target-port=81,`
               `protocol=tcp,`
               `internal-subnet-id=b0cp4drld130********,`
               `internal-ip-version=ipv4 \
     --target-group target-group-id=enpu2l7q9kth********,`
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

- API

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
          "ipVersion": "IPV4"
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
