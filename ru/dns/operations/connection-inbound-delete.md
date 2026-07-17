---
title: Как удалить входящее DNS-подключение в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете удалить входящее DNS-подключение.
---

# Удалить входящее DNS-подключение

Чтобы удалить [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором находится нужное входящее DNS-подключение.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. На панели слева выберите ![nodes-down](../../_assets/console-icons/nodes-down.svg) **{{ ui-key.yacloud.dns.label_inbound-endpoints }}**.
  1. В строке с нужным DNS-подключением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления входящего DNS-подключения:

      ```bash
      yc dns inbound-endpoint delete --help
      ```   
  1. {% include [list-inbound-endpoints-cli](../../_includes/dns/list-inbound-endpoints-cli.md) %}
  1. Удалите входящее DNS-подключение, указав его имя или идентификатор:

      ```bash
      yc dns inbound-endpoint delete <имя_или_идентификатор_DNS-подключения>
      ```

      Подробнее о команде `yc dns inbound-endpoint delete` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/delete.md).

      {% note info %}

      Если для удаляемого входящего DNS-подключения активирована опция защиты от удаления, перед удалением отключите эту опцию. Подробнее читайте в инструкции [{#T}](./connection-inbound-update.md).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Чтобы удалить входящее DNS-подключение, созданное с помощью {{ TF }}, откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием нужного входящего DNS-подключения.

      {% cut "Пример описания входящего DNS-подключения в конфигурации {{ TF }}" %}

      ```hcl
      ...
      resource "yandex_dns_inbound_endpoint" "dns_connection" {
        name        = "my-inbound-endpoint"
        description = "DNS Inbound Endpoint"

        network_id  = yandex_vpc_network.my_net.id
        address_id  = yandex_vpc_address.dns_address.id

        deletion_protection = false
      }
      ...
      ```

      {% endcut %}

  1. Примените изменения, чтобы удалить входящее DNS-подключение:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} удалит входящее DNS-подключение. Убедиться в удалении ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/list.md):

      ```bash
      yc dns inbound-endpoint list
      ```

- API {#api}

  Чтобы удалить входящее DNS-подключение, воспользуйтесь методом REST API [delete](../api-ref/DnsInboundEndpoint/delete.md) для ресурса [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) или вызовом gRPC API [DnsInboundEndpointService/Delete](../api-ref/grpc/DnsInboundEndpoint/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/dns-connection.md)
* [{#T}](../tutorials/dns-integration.md)