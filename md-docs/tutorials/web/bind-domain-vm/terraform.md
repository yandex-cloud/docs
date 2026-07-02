[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Прикладные решения > Создание сайта > [Привязка доменного имени к ВМ с веб-сервером](index.md) > Terraform

# Привязка доменного имени к ВМ с веб-сервером с помощью Terraform

Чтобы создать инфраструктуру для [привязки доменного имени к ВМ с веб-сервером](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Делегируйте домен сервису Cloud DNS](#delegate-domain). 
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сайта](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемого решения входят:

* плата за использование [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование публичной [DNS-зоны](../../../dns/concepts/dns-zone.md) и публичные [DNS-запросы](../../../glossary/dns.md) ([тарифы Yandex Cloud DNS](../../../dns/pricing.md)).

## Делегируйте домен сервису Cloud DNS {#delegate-domain}

Чтобы делегировать домен сервису Cloud DNS, в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов:

* `ns1.yandexcloud.net`
* `ns2.yandexcloud.net`

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи в течение 24 часов (86400 секунд). Это обусловлено значением TTL, в течение которого кешируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

```
ns2.yandexcloud.net.
ns1.yandexcloud.net.
```

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:

1. [Установите Terraform](../../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-compute-dns-binding
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          * `bind-domain-to-vm.tf` — конфигурация создаваемой инфраструктуры.
          * `bind-domain-to-vm.auto.tfvars` — файл с пользовательскими данными.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке:
          1. Конфигурационный файл `bind-domain-to-vm.tf`:

              {% cut "bind-domain-to-vm.tf" %}

              ```hcl
              # Объявление переменных для пользовательских параметров
              
              variable "folder_id" {
                type = string
              }
              
              variable "domain_name" {
                type = string
              }
              
              variable "ssh_key_path" {
                type = string
              }
              
              # Добавление прочих переменных
              
              locals {
                zone             = "ru-central1-a"
                network_name     = "webserver-network"
                subnet_name      = "webserver-subnet-ru-central1-a"
                sg_name          = "webserver-sg"
                vm_name          = "mywebserver"
                domain_zone_name = "my-domain-zone"
              }
              
              # Настройка провайдера
              
              terraform {
                required_providers {
                  yandex = {
                    source  = "yandex-cloud/yandex"
                    version = ">= 0.47.0"
                  }
                }
              }
              
              provider "yandex" {
                zone      = local.zone
                folder_id = var.folder_id
              }
              
              # Создание облачной сети
              
              resource "yandex_vpc_network" "webserver-network" {
                name = local.network_name
              }
              
              # Создание подсети
              
              resource "yandex_vpc_subnet" "webserver-subnet-b" {
                name           = local.subnet_name
                zone           = local.zone
                network_id     = "${yandex_vpc_network.webserver-network.id}"
                v4_cidr_blocks = ["192.168.1.0/24"]
              }
              
              # Создание группы безопасности
              
              resource "yandex_vpc_security_group" "webserver-sg" {
                name        = local.sg_name
                network_id  = "${yandex_vpc_network.webserver-network.id}"
                ingress {
                  protocol       = "TCP"
                  description    = "http"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  port           = 80
                }
              
                ingress {
                  protocol       = "TCP"
                  description    = "https"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  port           = 443
                }
              
                ingress {
                  protocol       = "TCP"
                  description    = "ssh"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  port           = 22
                }
              
                egress {
                  protocol       = "ANY"
                  description    = "any"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  from_port      = 0
                  to_port        = 65535
                }
              }
              
              # Создание образа
              
              resource "yandex_compute_image" "osimage" {
                source_family = "lamp"
              }
              
              # Создание диска
              
              resource "yandex_compute_disk" "boot-disk" {
                name     = "web-server-boot"
                type     = "network-hdd"
                image_id = yandex_compute_image.osimage.id
              }
              
              # Создание ВМ
              
              resource "yandex_compute_instance" "mywebserver" {
                name        = local.vm_name
                platform_id = "standard-v2"
                zone        = local.zone
              
                resources {
                  cores  = "2"
                  memory = "2"
                }
              
                boot_disk {
                  disk_id = yandex_compute_disk.boot-disk.id
                }
              
                network_interface {
                  subnet_id          = "${yandex_vpc_subnet.webserver-subnet-b.id}"
                  nat                = true
                  security_group_ids = ["${yandex_vpc_security_group.webserver-sg.id}"]
                }
              
                metadata = {
                  user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
                }
              }
              
              # Создание зоны DNS
              
              resource "yandex_dns_zone" "my-domain-zone" {
                name    = local.domain_zone_name
                zone    = "${var.domain_name}."
                public  = true
              }
              
              # Создание ресурсной записи типа А
              
              resource "yandex_dns_recordset" "rsА1" {
                zone_id = yandex_dns_zone.my-domain-zone.id
                name    = "${yandex_dns_zone.my-domain-zone.zone}"
                type    = "A"
                ttl     = 600
                data    = ["${yandex_compute_instance.mywebserver.network_interface.0.nat_ip_address}"]
                # description - необязательный параметр, описание ресурсной записи
              }
              ```

              {% endcut %}

          1. Файл с пользовательскими данными `bind-domain-to-vm.auto.tfvars`:

              {% cut "bind-domain-to-vm.auto.tfvars" %}

              ```hcl
              folder_id    = "<идентификатор_каталога>"
              ssh_key_path = "<путь_к_SSH-ключу>"
              domain_name  = "<имя_домена>"
              ```

              {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:

    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md)
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md)
    * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md)
    * [Образ](../../../compute/concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md)
    * [Диск](../../../compute/concepts/disk.md) — [yandex_compute_disk](../../../terraform/resources/compute_disk.md)
    * [ВМ](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md)
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md)
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md)

1. В файле `bind-domain-to-vm.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ, например `~/.ssh/id_ed25519.pub`. Подробнее в разделе [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain_name` — имя вашего домена, например `example.com`.

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

1. [Получите публичный IP-адрес ВМ](../../../compute/operations/vm-info/get-info.md#outside-instance) — он потребуется далее, чтобы [проверить работу хостинга](#test).

После создания инфраструктуры, [проверьте работу сайта](#test).

## Проверьте работу сайта {#test}

Теперь сайт на вашем веб-сервере доступен по доменному имени. Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:

* `http://<публичный_IP-адрес_ВМ>`
* `http://example.com`

## Удалите созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `bind-domain-to-vm.tf` и удалите описание создаваемой инфраструктуры из файла.
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

#### Полезные ссылки {#see-also}

* [Привязка доменного имени к ВМ с веб-сервером с помощью консоли управления, CLI или API](console.md).