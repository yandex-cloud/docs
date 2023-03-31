# Добавить обработчик к сетевому балансировщику

{% list tabs %}

- Консоль управления
  
  Чтобы добавить [обработчик](../concepts/listener.md) к сетевому балансировщику:
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется добавить обработчик к балансировщику.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. В строке балансировщика, к которому нужно добавить обработчик, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Добавить обработчик**.
  1. В открывшемся окне задайте параметры обработчика:

     * **Имя**.
     * **Протокол** — **TCP** или **UDP**.

        {% note info %}

        По умолчанию обработчик работает по протоколу TCP. Чтобы использовать протокол UDP, [запросите в технической поддержке]({{ link-console-support }}/create-ticket) эту возможность.

        {% endnote %}

     * **Порт**, на котором обработчик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
     * **Целевой порт**, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.
     * Нажмите кнопку **Добавить**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы добавить [обработчик](../concepts/listener.md) к сетевому балансировщику, выполните команду:

  ```bash
  yc load-balancer network-load-balancer add-listener <идентификатор или имя балансировщика> \
     --listener name=<имя обработчика>,`
               `port=<порт>,`
               `target-port=<целевой порт>,`
               `protocol=<протокол: tcp или udp>,`
               `external-address=<внешний IP-адрес обработчика>,`
               `external-ip-version=<версия IP-адреса: ipv4 или ipv6>
  ```

  Где:

  {% include [listener-cli-description](../../_includes/network-load-balancer/listener-cli-description.md) %}

  Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `listener` в описании сетевого балансировщика:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя сетевого балансировщика>"
       ...
       listener {
         name = "<имя обработчика>"
         port = <номер порта>
         external_address_spec {
           ip_version = "<версия IP-адреса: ipv4 или ipv6>"
         }
       }
       ...
     }
     ```

     Где:

     * `name` — имя сетевого балансировщика.
     * `listener` — параметры обработчика:
       * `name` — имя обработчика.
       * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик, из диапазона от `1` до `32767`.
       * `external_address_spec` — спецификация обработчика для внешнего балансировщика:
         * `ip_version` — описание внешнего IP-адреса. Укажите версию IP-адреса: `ipv4` или `ipv6`. По умолчанию `ipv4`.

     Более подробную информацию о параметрах ресурса `yandex_lb_network_load_balancer` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Добавьте обработчик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Воспользуйтесь методом API [addListener](../api-ref/NetworkLoadBalancer/addListener.md) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
  * Имя обработчика в параметре `listenerSpec.name`.
  * Порт обработчика в параметре `listenerSpec.port`.
  * Протокол обработчика в параметре `listenerSpec.protocol`.
  * Целевой порт обработчика в параметре `listenerSpec.targetPort`.
  * Параметры внешнего адреса обработчика в параметре `listenerSpec.externalAddressSpec`.

  Идентификатор балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}

## Примеры {#examples}

### Добавление обработчика сетевому балансировщику {#add-listener}

Добавьте сетевому балансировщику `test-load-balancer` обработчик с тестовыми характеристиками:

* Имя `test-listener`.
* Порт `80`.
* Целевой порт `81`.
* Протокол `TCP`.
* Версия IP-адреса `ipv4`.

{% list tabs %}

- CLI

  Выполните следующую команду:

  ```bash
  yc load-balancer network-load-balancer add-listener test-load-balancer \
     --listener name=test-listener,`
               `port=80,`
               `target-port=81,`
               `protocol=tcp,`
               `external-ip-version=ipv4
  ```

- {{ TF }}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `listener` в описании сетевого балансировщика:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "test-load-balancer"
       listener {
         name        = "test-listener"
         port        = 80
         target_port = 81
         protocol    = "tcp"
         external_address_spec {
           ip_version = "ipv4"
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

  Воспользуйтесь методом API [addListener](../api-ref/NetworkLoadBalancer/addListener.md) и передайте в теле запроса:

  ```api
  {
    "listenerSpec": {
      "name": "test-listener",
      "port": "80",
      "protocol": "TCP",
      "targetPort": "81",
      "externalAddressSpec": {
        "ipVersion": "ipv4"
      }
    }
  }
  ```

{% endlist %}
