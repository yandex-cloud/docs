[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Пошаговые инструкции](index.md) > DNS-подключения > Создать входящее DNS-подключение

# Создать входящее DNS-подключение

{% note info %}

В каждой облачной сети Virtual Private Cloud можно создать только одно входящее DNS-подключение.

{% endnote %}

Чтобы создать [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать входящее DNS-подключение.
  1. [Перейдите](https://console.yandex.cloud/link/dns) в сервис **Cloud DNS**.
  1. На панели слева выберите ![nodes-down](../../_assets/console-icons/nodes-down.svg) **Входящие подключения**.
  1. Нажмите кнопку **Создать подключение**. В открывшемся окне:

      1. В поле **Имя** задайте [имя](*name) создаваемого DNS-подключения.
      1. (Опционально) В поле **Описание** задайте произвольное описание DNS-подключения.
      1. (Опционально) В поле **Метки** задайте [метки](../../resource-manager/concepts/labels.md) для создаваемого ресурса.
      1. (Опционально) Включите опцию **Защита от удаления**, чтобы защитить создаваемое DNS-подключение от случайного удаления.
      1. В блоке **Сетевые настройки** в поле **Сеть** выберите [облачную сеть](../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud, в которой будет создано входящее DNS-подключение.
      1. В поле **IP-адрес** выберите зарезервированный [внутренний](../../vpc/concepts/address.md#internal-addresses) IP-адрес, который будет использоваться для входящего DNS-подключения.

          IP-адрес может относиться к любой из подсетей в облачной сети, выбранной на предыдущем шаге.

          Если у вас нет зарезервированного внутреннего IP-адреса или вы хотите зарезервировать новый адрес, нажмите кнопку **Зарезервировать** и в открывшемся окне:

          1. В поле **Имя** задайте [имя](*name) резервируемого IP-адреса.
          1. В поле **Подсеть** выберите [подсеть](../../vpc/concepts/network.md#subnet), в которой будет зарезервирован адрес.
          1. В поле **Внутренний IPv4 адрес** укажите IP-адрес, который будет зарезервирован.

              IP-адрес должен относиться к диапазону IP-адресов выбранной подсети. Указывать IP-адреса, уже используемые ресурсами Yandex Cloud, нельзя.
          1. (Опционально) Включите опцию **Защита от удаления**, чтобы защитить адрес от случайного удаления.
          1. Нажмите кнопку **Создать**, чтобы зарезервировать адрес.
      1. Нажмите кнопку **Создать**, чтобы создать входящее DNS-подключение.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
          * `address` — IPv4-адрес, который будет зарезервирован. IP-адрес должен относиться к диапазону IP-адресов выбранной подсети. Указывать IP-адреса, уже используемые ресурсами Yandex Cloud, нельзя.

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
      * `--network-id` — идентификатор [облачной сети](../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud, в которой будет создано входящее DNS-подключение.
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

  1. (Опционально) После создания входящего DNS-подключения проверьте разрешение FQDN-имен через это подключение. Для этого выполните команду `dig`, указав IP-адрес входящего DNS-подключения и FQDN ресурса в Yandex Cloud.

      Например:

      ```bash
      dig @192.168.3.3 my-sample-vm.ru-central1.internal
      ```

      Результат:

      ```text
      ; <<>> DiG 9.18.39-0ubuntu0.24.04.5-Ubuntu <<>> @192.168.3.3 my-sample-vm.ru-central1.internal
      ; (1 server found)
      ;; global options: +cmd
      ;; Got answer:
      ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 26971
      ;; flags: qr aa rd ra; MBZ: 0x4; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

      ;; OPT PSEUDOSECTION:
      ; EDNS: version: 0, flags:; udp: 1232
      ; COOKIE: 5628ffd26cc7ebc0 (echoed)
      ;; QUESTION SECTION:
      ;my-sample-vm.ru-central1.internal. IN A

      ;; ANSWER SECTION:
      my-sample-vm.ru-central1.internal. 600 IN A 192.168.2.22

      ;; Query time: 2 msec
      ;; SERVER: 192.168.3.3#53(192.168.3.3) (UDP)
      ;; WHEN: Sun Jul 05 13:39:52 UTC 2026
      ;; MSG SIZE  rcvd: 153
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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
      * `network_id` — идентификатор [облачной сети](../../vpc/concepts/network.md#network) Virtual Private Cloud, в которой будет создано входящее DNS-подключение.
      * `address_id` — идентификатор [зарезервированного](../../vpc/operations/private-ip-reserve.md) [внутреннего](../../vpc/concepts/address.md#internal-addresses) IP-адреса, который будет использоваться для входящего DNS-подключения.
      * `deletion_protection` — параметр, включающий защиту создаваемого входящего DNS-подключения от случайного удаления. Необязательный параметр.

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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/get.md):

      ```bash
      yc dns inbound-endpoint get <имя_DNS-подключения>
      ```

- API {#api}

  Чтобы зарезервировать внутренний IP-адрес, воспользуйтесь методом REST API [create](../../vpc/api-ref/Address/create.md) для ресурса [Address](../../vpc/api-ref/Address/index.md) или вызовом gRPC API [AddressService/Create](../../vpc/api-ref/grpc/Address/create.md).

  Чтобы создать входящее DNS-подключение, воспользуйтесь методом REST API [create](../api-ref/DnsInboundEndpoint/create.md) для ресурса [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) или вызовом gRPC API [DnsInboundEndpointService/Create](../api-ref/grpc/DnsInboundEndpoint/create.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [DNS-подключения](../concepts/dns-connection.md)
* [Разрешение облачных DNS-имен в корпоративной сети](../tutorials/dns-integration.md)

[*name]: Требования к имени:
         
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.