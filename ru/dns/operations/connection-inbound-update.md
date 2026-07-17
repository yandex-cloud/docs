---
title: Как изменить входящее DNS-подключение в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете изменить входящее DNS-подключение.
---

# Изменить входящее DNS-подключение

Чтобы изменить [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором находится нужное входящее DNS-подключение.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. На панели слева выберите ![nodes-down](../../_assets/console-icons/nodes-down.svg) **{{ ui-key.yacloud.dns.label_inbound-endpoints }}**.
  1. В строке с нужным DNS-подключением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

      1. (Опционально) В поле **{{ ui-key.yacloud.common.name }}** измените [имя](*name) DNS-подключения.
      1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** задайте произвольное описание DNS-подключения.
      1. (Опционально) В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** задайте [метки](../../resource-manager/concepts/labels.md) для DNS-подключения.
      1. (Опционально) Включите или отключите опцию **{{ ui-key.yacloud.common.deletion-protection }}**, чтобы, соответственно, включить или отключить защиту DNS-подключения от случайного удаления.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**, чтобы сохранить изменения.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения входящего DNS-подключения:

      ```bash
      yc dns inbound-endpoint update --help
      ```
  1. {% include [list-inbound-endpoints-cli](../../_includes/dns/list-inbound-endpoints-cli.md) %}
  1. Измените входящее DNS-подключение, указав его имя или идентификатор:

      ```bash
      yc dns inbound-endpoint update <имя_или_идентификатор_DNS-подключения> \
        --new-name <новое_имя_подключения> \
        --description '<описание_подключения>' \
        --labels <ключ>=<значение>[,<ключ>=<значение>] \
        --deletion-protection
      ```

      Где:

      * `--new-name` — новое [имя](*name) входящего DNS-подключения. Необязательный параметр.
      * `--description` — описание подключения. Необязательный параметр.
      * `--labels` — список [меток](../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
      * `--deletion-protection` — параметр, включающий защиту входящего DNS-подключения от случайного удаления. Необязательный параметр.

          Если вы хотите отключить защиту от удаления, передайте в команде параметр `--deletion-protection=false`

      Результат:

      ```text
      id: dns0uullmbcn********
      folder_id: b1gt6g8ht345********
      created_at: "2026-07-05T15:40:39.595Z"
      name: my-inbound-endpoint
      network_id: enpcfncr6uld********
      address: 192.168.3.3
      address_id: fl8not0e596n********
      status: AVAILABLE
      deletion_protection: true
      ```

      Подробнее о команде `yc dns inbound-endpoint update` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры входящего DNS-подключения:

      ```hcl
      resource "yandex_vpc_network" "my_net" {}

      resource "yandex_vpc_subnet" "subnet1" {
        network_id     = yandex_vpc_network.my_net.id
        v4_cidr_blocks = ["192.168.3.0/24"]
      }

      resource "yandex_vpc_address" "dns_address" {
        name        = "my-address"
        description = "inbound endpoint address"

        internal_ipv4_address {
          subnet_id = yandex_vpc_subnet.subnet1.id
          address   = "192.168.3.3"
        }
        deletion_protection = false
      }

      resource "yandex_dns_inbound_endpoint" "dns_connection" {
        name        = "my-inbound-endpoint"
        description = "DNS Inbound Endpoint"

        network_id  = yandex_vpc_network.my_net.id
        address_id  = yandex_vpc_address.dns_address.id

        deletion_protection = false
      }
      ```

      Где:

      * `name` — [имя](*name) DNS-подключения.
      * `description` — описание подключения. Необязательный параметр.
      * `network_id` — идентификатор [облачной сети](../../vpc/concepts/network.md#network) {{ vpc-name }}, в которой создано входящее DNS-подключение.
      * `address_id` — идентификатор [зарезервированного](../../vpc/operations/private-ip-reserve.md) [внутреннего](../../vpc/concepts/address.md#internal-addresses) IP-адреса, который будет использоваться для входящего DNS-подключения.
      * `deletion_protection` — параметр, включающий защиту входящего DNS-подключения от случайного удаления. Необязательный параметр.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/get.md):

      ```bash
      yc dns inbound-endpoint get <имя_DNS-подключения>
      ```

- API {#api}

  Чтобы изменить входящее DNS-подключение, воспользуйтесь методом REST API [update](../api-ref/DnsInboundEndpoint/update.md) для ресурса [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) или вызовом gRPC API [DnsInboundEndpointService/Update](../api-ref/grpc/DnsInboundEndpoint/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/dns-connection.md)
* [{#T}](../tutorials/dns-integration.md)

[*name]: {% include [name-format](../../_includes/_popups/name-format-general.md) %}