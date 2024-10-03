---
title: Удалить обработчик
description: Следуя данной инструкции, вы сможете удалить обработчик.
---

# Удалить обработчик

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  Чтобы удалить [обработчик](../concepts/listener.md) сетевого балансировщика:
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить обработчик балансировщика.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Выберите сетевой балансировщик, у которого требуется удалить обработчик.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_listeners }}** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке обработчика, который нужно удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_delete-listener }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить обработчик сетевого балансировщика, выполните команду:

  ```bash
  yc load-balancer network-load-balancer remove-listener <имя_или_идентификатор_балансировщика> \
     --listener-name=<имя_обработчика>
  ```

  Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list), имя обработчика — с [детальной информацией о сетевом балансировщике](load-balancer-list.md#get).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить обработчик сетевого балансировщика, созданного с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием обработчика.

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
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

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Удалите сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}
  
  Чтобы удалить обработчик сетевого балансировщика, воспользуйтесь методом REST API [removeListener](../api-ref/NetworkLoadBalancer/removeListener.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/RemoveListener](../api-ref/grpc/network_load_balancer_service.md#RemoveListener) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
  * Имя обработчика в параметре `listenerName`.

  Идентификатор балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list), имя обработчика — с [детальной информацией о сетевом балансировщике](load-balancer-list.md#get).

{% endlist %}