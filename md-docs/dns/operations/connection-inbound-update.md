[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Пошаговые инструкции](index.md) > DNS-подключения > Изменить входящее DNS-подключение

# Изменить входящее DNS-подключение

Чтобы изменить [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужное входящее DNS-подключение.
  1. [Перейдите](https://console.yandex.cloud/link/dns) в сервис **Cloud DNS**.
  1. На панели слева выберите ![nodes-down](../../_assets/console-icons/nodes-down.svg) **Входящие подключения**.
  1. Нажмите на нужное DNS-подключение.
  1. Нажмите кнопку **Редактировать** и измените параметры подключения:

      1. (Опционально) В поле **Имя** измените [имя](*name) DNS-подключения.
      1. (Опционально) В поле **Описание** задайте произвольное описание DNS-подключения.
      1. (Опционально) В поле **Метки** задайте [метки](../../resource-manager/concepts/labels.md) для DNS-подключения.
      1. (Опционально) Включите или отключите опцию **Защита от удаления**, чтобы, соответственно, включить или отключить защиту DNS-подключения от случайного удаления.
      1. Нажмите кнопку **Сохранить**, чтобы сохранить изменения.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения входящего DNS-подключения:

      ```bash
      yc dns inbound-endpoint update --help
      ```
  1. Получите список входящих DNS-подключений в каталоге по умолчанию:
     
     ```bash
     yc dns inbound-endpoint list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+-------------+----------------------+----------------------+--------------------------------+---------------------+
     |          ID          |         NAME         | DESCRIPTION |      NETWORK ID      |      ADDRESS ID      |           CREATED AT           | DELETION PROTECTION |
     +----------------------+----------------------+-------------+----------------------+----------------------+--------------------------------+---------------------+
     | dns2n8fakpev******** | new-inbound-endpoint |             | enpg0adn0uv6******** | e2l8n7uup1j3******** | seconds:1783270956             | true                |
     |                      |                      |             |                      |                      | nanos:37000000                 |                     |
     | dns6h5q0h2ic******** | inbound-endpoint     |             | enpcfncr6uld******** | fl8not0e596n******** | seconds:1783270908             | false               |
     |                      |                      |             |                      |                      | nanos:107000000                |                     |
     +----------------------+----------------------+-------------+----------------------+----------------------+--------------------------------+---------------------+
     ```
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

          Если вы хотите отключить защиту от удаления, передайте в команде параметр `--deletion-protection=false`.

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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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
      * `network_id` — идентификатор [облачной сети](../../vpc/concepts/network.md#network) Virtual Private Cloud, в которой создано входящее DNS-подключение.
      * `address_id` — идентификатор [зарезервированного](../../vpc/operations/private-ip-reserve.md) [внутреннего](../../vpc/concepts/address.md#internal-addresses) IP-адреса, который будет использоваться для входящего DNS-подключения.
      * `deletion_protection` — параметр, включающий защиту входящего DNS-подключения от случайного удаления. Необязательный параметр.

  1. Примените изменения:

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

      Terraform применит изменения. Проверить обновление ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/get.md):

      ```bash
      yc dns inbound-endpoint get <имя_DNS-подключения>
      ```

- API {#api}

  Чтобы изменить входящее DNS-подключение, воспользуйтесь методом REST API [update](../api-ref/DnsInboundEndpoint/update.md) для ресурса [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) или вызовом gRPC API [DnsInboundEndpointService/Update](../api-ref/grpc/DnsInboundEndpoint/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [DNS-подключения](../concepts/dns-connection.md)
* [Разрешение облачных DNS-имен в корпоративной сети](../tutorials/dns-integration.md)

[*name]: Требования к имени:
         
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.