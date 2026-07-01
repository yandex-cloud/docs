# Сайт на LAMP- или LEMP-стеке с помощью Terraform

Чтобы создать инфраструктуру для [сайта на LAMP- или LEMP-стеке](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы сайта](#upload-files).
1. [Проверьте работу сайта](#test-site).

В качестве примера используется доменное имя `example.com`.

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для сайта входят:
* плата за постоянно запущенную [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md));
* плата за публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md), если вы используете [Yandex Cloud DNS](../../../dns/index.md) ([тарифы Cloud DNS](../../dns/pricing.md)).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:
1. [Установите Terraform](../../infrastructure-management/terraform-quickstart.md#install-terraform) и [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials).
1. Укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовый архив {#ready}

      1. Создайте папку для файлов.
      1. Скачайте [архив](https://storage.yandexcloud.net/doc-files/lamp-lemp.zip) (1 КБ).
      1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `lamp-lemp.tf` и файл с пользовательскими данными `lamp-lemp.auto.tfvars`.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `lamp-lemp.tf`:

          {% cut "lamp-lemp.tf" %}

          ```hcl
          # Объявление переменных для пользовательских параметров
          
          variable "zone" {
            type = string
          }
          
          variable "folder_id" {
            type = string
          }
          
          variable "vm_image_family" {
            type = string
          }
          
          variable "vm_user" {
            type = string
          }
          
          variable "ssh_key_path" {
            type = string
          }
          
          variable "dns_zone" {
            type = string
          }
          
          # Добавление прочих переменных
          
          locals {
            network_name       = "web-network"
            subnet_name        = "subnet1"
            sg_vm_name         = "sg-web"
            vm_name            = "lamp-vm"
            dns_zone_name      = "example-zone"
          }
          
          # Настройка провайдера
          
          terraform {
            required_providers {
              yandex    = {
                source  = "yandex-cloud/yandex"
                version = ">= 0.47.0"
              }
            }
          }
          
          provider "yandex" {
            folder_id = var.folder_id
          }
          
          # Создание облачной сети
          
          resource "yandex_vpc_network" "network-1" {
            name = local.network_name
          }
          
          # Создание подсети
          
          resource "yandex_vpc_subnet" "subnet-1" {
            name           = local.subnet_name
            v4_cidr_blocks = ["192.168.1.0/24"]
            zone           = var.zone
            network_id     = yandex_vpc_network.network-1.id
          }
          
          # Создание группы безопасности
          
          resource "yandex_vpc_security_group" "sg-1" {
            name        = local.sg_vm_name
            network_id  = yandex_vpc_network.network-1.id
            egress {
              protocol       = "ANY"
              description    = "any"
              v4_cidr_blocks = ["0.0.0.0/0"]
            }
            ingress {
              protocol       = "TCP"
              description    = "ext-http"
              v4_cidr_blocks = ["0.0.0.0/0"]
              port           = 80
            }
            ingress {
              protocol       = "TCP"
              description    = "ext-https"
              v4_cidr_blocks = ["0.0.0.0/0"]
              port           = 443
            }
          }
          
          # Добавление готового образа ВМ
          
          resource "yandex_compute_image" "lamp-vm-image" {
            source_family = var.vm_image_family
          }
          
          resource "yandex_compute_disk" "boot-disk" {
            name     = "bootvmdisk"
            type     = "network-hdd"
            zone     = "ru-central1-a"
            size     = "20"
            image_id = yandex_compute_image.lamp-vm-image.id
          }
          
          # Создание ВМ
          
          resource "yandex_compute_instance" "vm-lamp" {
            name        = local.vm_name
            platform_id = "standard-v3"
            zone        = var.zone
            resources {
              core_fraction = 20
              cores         = 2
              memory        = 1
            }
            boot_disk {
              disk_id = yandex_compute_disk.boot-disk.id
            }
            network_interface {
              subnet_id          = yandex_vpc_subnet.subnet-1.id
              nat                = true
              security_group_ids = [yandex_vpc_security_group.sg-1.id]
            }
            metadata = {
              user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
            }
          }
          
          # Создание зоны DNS
          
          resource "yandex_dns_zone" "zone1" {
            name    = local.dns_zone_name
            zone    = var.dns_zone
            public  = true
          }
          
          # Создание ресурсной записи типа А
          
          resource "yandex_dns_recordset" "rs-a" {
            zone_id = yandex_dns_zone.zone1.id
            name    = var.dns_zone
            type    = "A"
            ttl     = 600
            data    = [ yandex_compute_instance.vm-lamp.network_interface.0.nat_ip_address ]
          }
          
          # Создание ресурсной записи типа CNAME
          
          resource "yandex_dns_recordset" "rs-cname" {
            zone_id = yandex_dns_zone.zone1.id
            name    = "www"
            type    = "CNAME"
            ttl     = 600
            data    = [ var.dns_zone ]
          }
          ```

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `lamp-lemp.auto.tfvars`:

          {% cut "lamp-lemp.auto.tfvars" %}

          ```hcl
          zone               = "<зона_доступности>"
          folder_id          = "<идентификатор_каталога>"
          vm_image_family    = "<семейство_образа_ВМ>"
          vm_user            = "<имя_пользователя_ВМ>"
          ssh_key_path       = "<путь_к_публичному_SSH-ключу>"
          dns_zone           = "<зона_DNS>"
          ```

          {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md)
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md)
    * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md)
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md)
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md)
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md)

  1. В файле `lamp-lemp.auto.tfvars` задайте пользовательские параметры:
      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
      * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
      * `family_id` — укажите семейство одного из [образов](../../../compute/concepts/image.md) ВМ с нужным набором компонентов:
        * `lamp` — [LAMP](https://yandex.cloud/ru/marketplace/products/yc/lamp) (Linux, Apache, MySQL®, PHP).
        * `lemp` — [LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp) (Linux, Nginx, MySQL®, PHP).
      * `vm_user` — имя пользователя ВМ.
      * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее в разделе [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
      * `dns_zone` — [зона DNS](../../../dns/concepts/dns-zone.md). Укажите ваш зарегистрированный домен с точкой в конце, например `example.com.`.
          Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net` в личном кабинете вашего регистратора.

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

1. [Получите публичный IP-адрес ВМ](../../../compute/operations/vm-info/get-info.md) — он потребуется далее, чтобы [загрузить файлы сайта](#upload-files).

После создания инфраструктуры, [загрузите файлы сайта](#upload-files).

## Загрузите файлы сайта {#upload-files}

Чтобы проверить работу веб-сервера, загрузите на ВМ файл `index.html`. Можно использовать [тестовый файл](https://storage.yandexcloud.net/doc-files/index.html.zip), скачайте и распакуйте архив.
1. В блоке **Сеть** на странице ВМ в [консоли управления](https://console.yandex.cloud) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`: 

    ```bash
    sudo chown -R "$USER":www-data /var/www/html
    ```

1. Загрузите на ВМ файлы сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux-macos}

      Используйте утилиту командной строки `scp`:

      ```bash
      scp -r <путь_до_директории_с_файлами> <имя_пользователя_ВМ>@<IP-адрес_ВМ>:/var/www/html
      ```

    - Windows {#windows}

      С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

    {% endlist %}

После загрузки файлов, [проверьте работу сайта](#test-files).

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:
* `http://<публичный_IP-адрес_ВМ>`.
* `http://www.example.com`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `lamp-lemp.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Сайт на LAMP- или LEMP-стеке с помощью консоли управления](console.md).