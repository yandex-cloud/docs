---
title: "Добавить обработчик к сетевому балансировщику"
description: "Следуя данной инструкции, вы сможете добавить обработчик к сетевому балансировщику."
---

# Добавить обработчик к сетевому балансировщику

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  Чтобы добавить [обработчик](../concepts/listener.md) к сетевому балансировщику:
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется добавить обработчик к балансировщику.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. В строке балансировщика, к которому нужно добавить обработчик, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
  1. В открывшемся окне задайте параметры обработчика:

     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}` или `{{ ui-key.yacloud.common.label_udp }}`.

        {% note info %}

        По умолчанию обработчик работает по протоколу TCP. Чтобы использовать протокол UDP, [запросите в технической поддержке]({{ link-console-support }}/create-ticket) эту возможность.

        {% endnote %}

     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**, на котором обработчик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.
     * Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы добавить [обработчик](../concepts/listener.md) к сетевому балансировщику, выполните команду:

  ```bash
  yc load-balancer network-load-balancer add-listener <имя_или_идентификатор_балансировщика> \
     --listener name=<имя_обработчика>,`
               `port=<порт>,`
               `target-port=<целевой_порт>,`
               `protocol=<протокол>,`
               `external-address=<внешний_IP-адрес>,`
               `external-ip-version=<версия_IP-адреса>
  ```

  Где:

  {% include [listener-cli-description](../../_includes/network-load-balancer/listener-cli-description.md) %}

  Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `listener` в описании сетевого балансировщика:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_балансировщика>"
       ...
       listener {
         name = "<имя_обработчика>"
         port = <номер_порта>
         external_address_spec {
           ip_version = "<версия_IP-адреса>"
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

     Более подробную информацию о параметрах ресурса `yandex_lb_network_load_balancer` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Добавьте обработчик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы добавить обработчик к сетевому балансировщику, воспользуйтесь методом REST API [addListener](../api-ref/NetworkLoadBalancer/addListener.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/AddListener](../api-ref/grpc/network_load_balancer_service.md#AddListener).

{% endlist %}

## Примеры {#examples}

### Добавление обработчика сетевому балансировщику {#add-listener}

Добавьте сетевому балансировщику `test-load-balancer` обработчик с тестовыми характеристиками:

* Имя `test-listener`.
* Порт `80`.
* Целевой порт `81`.
* Протокол `TCP`.
* Версия IP-адреса `ipv4`.

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc load-balancer network-load-balancer add-listener test-load-balancer \
     --listener name=test-listener,`
               `port=80,`
               `target-port=81,`
               `protocol=tcp,`
               `external-ip-version=ipv4
  ```

- {{ TF }} {#tf}

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

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

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
