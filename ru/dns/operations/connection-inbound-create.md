---
title: Как создать входящее DNS-подключение в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете создать входящее DNS-подключение.
---

# Создать входящее DNS-подключение

{% include [inb-endpoint-1-per-netw-notice](../../_includes/dns/inb-endpoint-1-per-netw-notice.md) %}

Чтобы создать [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать входящее DNS-подключение.
  1. [Перейдите]({{ link-console-main }}/link/dns) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. На панели слева выберите ![nodes-down](../../_assets/console-icons/nodes-down.svg) **{{ ui-key.yacloud.dns.label_inbound-endpoints }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.DnsInboundEndpointsListScreen.create_button }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** задайте [имя](*name) создаваемого DNS-подключения.
      1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** задайте произвольное описание DNS-подключения.
      1. (Опционально) В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** задайте [метки](../../resource-manager/concepts/labels.md) для создаваемого ресурса.
      1. (Опционально) Включите опцию **{{ ui-key.yacloud.common.deletion-protection }}**, чтобы защитить создаваемое DNS-подключение от случайного удаления.
      1. В блоке **{{ ui-key.yacloud.dns.DnsInboundEndpointForm.network_settings_title }}** в поле **{{ ui-key.yacloud.vpc.label_network }}** выберите [облачную сеть](../../vpc/concepts/network.md#network) {{ vpc-full-name }}, в которой будет создано входящее DNS-подключение.
      1. В поле **{{ ui-key.yacloud.entity.ipAddress }}** выберите зарезервированный [внутренний](../../vpc/concepts/address.md#internal-addresses) IP-адрес, который будет использоваться для входящего DNS-подключения.

          IP-адрес может относиться к любой из подсетей в облачной сети, выбранной на предыдущем шаге.

          Если у вас нет зарезервированного внутреннего IP-адреса или вы хотите зарезервировать новый адрес, нажмите кнопку **{{ ui-key.yacloud.component.internal-v4-address-field.button_internal-address-reserve }}** и в открывшемся окне:

          1. В поле **{{ ui-key.yacloud.common.name }}** задайте [имя](*name) резервируемого IP-адреса.
          1. В поле **{{ ui-key.yacloud.common.label_subnet }}** выберите [подсеть](../../vpc/concepts/network.md#subnet), в которой будет зарезервирован адрес.
          1. В поле **{{ ui-key.yacloud.vpc.addresses.popup-create_field_internal-v4-address }}** укажите IP-адрес, который будет зарезервирован.

              IP-адрес должен относиться к диапазону IP-адресов выбранной подсети. Указывать IP-адреса, уже используемые ресурсами {{ yandex-cloud }}, нельзя.
          1. (Опционально) Включите опцию **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**, чтобы защитить адрес от случайного удаления.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы зарезервировать адрес.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать входящее DNS-подключение.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания входящего DNS-подключения:

      ```bash
      yc dns inbound-endpoint create --help
      ```
  1. Зарезервируйте IP-адрес для входящего DNS-подключения в нужной подсети:

      ```bash
      yc vpc address create \
        --name <имя_резервируемого_адреса> \
        --description '<описание_адреса>' \
        --internal-ipv4 subnet=<идентификатор_подсети>,address=<IP-адрес>
      ```

      Где:

      * `--name` — [имя](*name) резервируемого [внутреннего](../../vpc/concepts/address.md#internal-addresses) IP-адреса.
      * `--description` — описание резервируемого IP-адреса. Необязательный параметр.
      * `--internal-ipv4` — блок атрибутов резервирования внутреннего IP-адреса:

          * `subnet` — идентификатор [подсети](../../vpc/concepts/network.md#subnet), в которой будет зарезервирован IP-адрес.
          * `address` — IPv4-адрес, который будет зарезервирован. IP-адрес должен относиться к диапазону IP-адресов выбранной подсети. Указывать IP-адреса, уже используемые ресурсами {{ yandex-cloud }}, нельзя.

      Результат:

      ```text
      id: fl8not0e596n********
      folder_id: b1gt6g8ht345********
      created_at: "2026-07-05T13:21:12Z"
      name: my-address
      description: inbound endpoint address
      internal_ipv4_address:
        address: 192.168.3.3
        subnet_id: fl8dmq91iruu********
      reserved: true
      type: INTERNAL
      ip_version: IPV4
      ```

      Сохраните идентификатор (значение поля `id`) зарезервированного адреса, он понадобится при создании DNS-подключения.

      Подробнее о команде `yc vpc address create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/address/create.md).
  1. Создайте входящее DNS-подключение:

      ```bash
      yc dns inbound-endpoint create \
        --name <имя_входящего_подключения> \
        --description '<описание_подключения>' \
        --labels <ключ>=<значение>[,<ключ>=<значение>] \
        --network-id <идентификатор_сети> \
        --address-id <идентификатор_адреса> \
        --deletion-protection
      ```

      Где:

      * `--name` — [имя](*name) создаваемого DNS-подключения.
      * `--description` — описание подключения. Необязательный параметр.
      * `--labels` — список [меток](../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
      * `--network-id` — идентификатор [облачной сети](../../vpc/concepts/network.md#network) {{ vpc-full-name }}, в которой будет создано входящее DNS-подключение.
      * `--address-id` — сохраненный ранее идентификатор зарезервированного IP-адреса, который будет использоваться для входящего DNS-подключения.
      * `--deletion-protection` — параметр, включающий защиту создаваемого входящего DNS-подключения от случайного удаления. Необязательный параметр.

      Результат:

      ```text
      id: dns80efu32ve********
      folder_id: b1gt6g8ht345********
      created_at: "2026-07-05T13:32:36.880Z"
      name: my-inbound-endpoint
      network_id: enpcfncr6uld********
      address: 192.168.3.3
      address_id: fl8not0e596n********
      status: AVAILABLE
      ```

      Подробнее о команде `yc dns inbound-endpoint create` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/create.md).

  1. (Опционально) После создания входящего DNS-подключения проверьте разрешение FQDN-имен через это подключение. Для этого выполните команду `dig`, указав IP-адрес входящего DNS-подключения и FQDN ресурса в {{ yandex-cloud }}.

      Например:

      ```bash
      dig @192.168.3.3 my-sample-vm.{{ region-id }}.internal
      ```

      Результат:

      ```text
      ; <<>> DiG 9.18.39-0ubuntu0.24.04.5-Ubuntu <<>> @192.168.3.3 my-sample-vm.{{ region-id }}.internal
      ; (1 server found)
      ;; global options: +cmd
      ;; Got answer:
      ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 26971
      ;; flags: qr aa rd ra; MBZ: 0x4; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

      ;; OPT PSEUDOSECTION:
      ; EDNS: version: 0, flags:; udp: 1232
      ; COOKIE: 5628ffd26cc7ebc0 (echoed)
      ;; QUESTION SECTION:
      ;my-sample-vm.{{ region-id }}.internal. IN A

      ;; ANSWER SECTION:
      my-sample-vm.{{ region-id }}.internal. 600 IN A 192.168.2.22

      ;; Query time: 2 msec
      ;; SERVER: 192.168.3.3#53(192.168.3.3) (UDP)
      ;; WHEN: Sun Jul 05 13:39:52 UTC 2026
      ;; MSG SIZE  rcvd: 153
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

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

      * `name` — [имя](*name) создаваемого DNS-подключения.
      * `description` — описание подключения. Необязательный параметр.
      * `network_id` — идентификатор [облачной сети](../../vpc/concepts/network.md#network) {{ vpc-name }}, в которой будет создано входящее DNS-подключение.
      * `address_id` — идентификатор [зарезервированного](../../vpc/operations/private-ip-reserve.md) [внутреннего](../../vpc/concepts/address.md#internal-addresses) IP-адреса, который будет использоваться для входящего DNS-подключения.
      * `deletion_protection` — параметр, включающий защиту создаваемого входящего DNS-подключения от случайного удаления. Необязательный параметр.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/get.md):

      ```bash
      yc dns inbound-endpoint get <имя_DNS-подключения>
      ```

- API {#api}

  Чтобы зарезервировать внутренний IP-адрес, воспользуйтесь методом REST API [create](../../vpc/api-ref/Address/create.md) для ресурса [Address](../../vpc/api-ref/Address/index.md) или вызовом gRPC API [AddressService/Create](../../vpc/api-ref/grpc/Address/create.md).

  Чтобы создать входящее DNS-подключение, воспользуйтесь методом REST API [create](../api-ref/DnsInboundEndpoint/create.md) для ресурса [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) или вызовом gRPC API [DnsInboundEndpointService/Create](../api-ref/grpc/DnsInboundEndpoint/create.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/dns-connection.md)
* [{#T}](../tutorials/dns-integration.md)

[*name]: {% include [name-format](../../_popups/name-format-general.md) %}