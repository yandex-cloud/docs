---
title: Как создать входящее DNS-подключение в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете создать входящее DNS-подключение.
---

# Создать входящее DNS-подключение

Чтобы создать [входящее DNS-подключение](../concepts/dns-connection.md):

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать новое входящее DNS-подключение:

  1. Зарезервируйте IP-адрес для входящего DNS-подключения в нужной подсети:

     ```bash
     yc vpc address create --name dns-ep \
       --description 'DNS Inbound IP' \
       --internal-ipv4 address=10.0.1.101,subnet=f5hqt..........3gj28
     ```

     Где:

     * `--name` — имя резервируемого внутреннего IP-адреса. Должно быть уникальным внутри каталога.
     * `--description` — описание резервируемого IP-адреса.
     * `--internal-ipv4` — блок атрибутов резервирования внутреннего IP-адреса:
       * `address` — IPv4-адрес, который будет зарезервирован. Нельзя задавать уже используемые в VPC IP-адреса.
       * `subnet` — идентификатор подсети, в которой будет резервироваться IP-адрес.

    Результат:

     ```text
      id: e3gck..........qd6j2
      folder_id: b1g42..........5ghp2
      name: dns-ep
      description: DNS Inbound IP
      internal_ipv4_address:
        address: 10.0.1.101
        subnet_id: f5hqt..........3gj28
      reserved: true
      type: INTERNAL
      ip_version: IPV4
     ```

  1. Посмотрите описание команды CLI для создания входящего DNS-подключения:

     ```bash
     yc dns inbound-endpoint create --help
     ```   

  1. Создайте входящее DNS-подключение:

     ```bash
     yc dns inbound-endpoint create --name dns-ep \
       --description 'DNS Inbound' \
       --network-id enpd3..........39qap \
       --address-id e3gck..........qd6j2
     ```

     Где:

     * `--name` — имя подключения. Должно быть уникальным внутри каталога.
     * `--description` — описание подключения.
     * `--network-id` — идентификатор сети VPC, в которой будет создано входящее DNS-подключение.
     * `--address-id` — идентификатор зарезервированного IP-адреса, который будет использоваться для входящего DNS-подключения.

     Результат:

     ```text
     id: dnses..........9nh78
     folder_id: b1g42..........5ghp2
     name: dns-ep
     description: DNS Inbound
     address: 10.0.1.101
     address_id: e3gck..........qd6j2
     status: AVAILABLE
     ```

     После создания можно проверить разрешение FQDN-имен через созданное DNS-подключение с помощью команды `dig`.

     Результат:

     ```text
     dig @10.0.1.101 test-vm.ru-central1.internal

     ; <<>> DiG 9.18.39-0ubuntu0.24.04.3-Ubuntu <<>> test-vm.ru-central1.internal
     ;; global options: +cmd
     ;; Got answer:
     ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 50976
     ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

     ;; OPT PSEUDOSECTION:
     ; EDNS: version: 0, flags:; udp: 65494
     ;; QUESTION SECTION:
     ;test-vm.ru-central1.internal.			IN	A

     ;; ANSWER SECTION:
     test-vm.ru-central1.internal. 600 IN A 10.0.1.15

     ;; Query time: 9 msec
     ;; SERVER: 10.0.1.101#53(10.0.1.101) (UDP)
     ;; WHEN: Tue Apr 28 13:44:20 UTC 2026
     ;; MSG SIZE  rcvd: 133
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

    ```hcl
    resource "yandex_vpc_network" "my_net" {}

    resource "yandex_vpc_subnet" "subnet1" {
      network_id     = yandex_vpc_network.my_net.id
      v4_cidr_blocks = ["10.0.1.0/24"]
    }

    resource "yandex_vpc_address" "dns_address" {
      name        = "dns-ep"
      description = "internal address for DNS inbound endpoint"

      internal_ipv4_address {
        subnet_id = yandex_vpc_subnet.subnet1.id
        address   = "10.0.1.101"
      }
      deletion_protection = false
    }

    resource "yandex_dns_inbound_endpoint" "dns_connection" {
      name        = "dns-ep"
      description = "DNS Inbound"

      network_id  = yandex_vpc_network.my_net.id
      address_id  = yandex_vpc_address.dns_address.id

      deletion_protection = false
    }
    ```

    Где:

     * `name` — имя подключения. Должно быть уникальным внутри каталога.
     * `description` — описание подключения.
     * `network_id` — идентификатор сети VPC, в которой будет создано входящее DNS-подключение.
     * `address_id` — идентификатор зарезервированного IP-адреса, который будет использоваться для входящего DNS-подключения.

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc dns inbound-endpoint get <имя-подключения>
     ```

{% endlist %}
