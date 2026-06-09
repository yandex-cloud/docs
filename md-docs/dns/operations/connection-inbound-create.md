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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc dns inbound-endpoint get <имя-подключения>
     ```

{% endlist %}