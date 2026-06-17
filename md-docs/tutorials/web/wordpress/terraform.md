# Создание сайта на WordPress с помощью Terraform

Чтобы создать и настроить [сайт на WordPress](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Получите данные для аутентификации в веб-интерфейсе](#get-auth-data).
1. [Подключитесь к веб-интерфейсу WordPress](#connect-wordpress-interface).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

Убедитесь, что в выбранном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) есть [облачная сеть](../../../vpc/concepts/network.md#network) с [подсетью](../../../vpc/concepts/network.md#subnet) хотя бы в одной [зоне доступности](../../../overview/concepts/geo-scope.md). Для этого на странице каталога выберите сервис **VPC**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../../vpc/quickstart.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сайта на WordPress входит:
* плата за постоянно запущенную ВМ ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование динамического или статического [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md), если вы используете [Yandex Cloud DNS](../../../dns/index.md) ([тарифы Cloud DNS](../../../dns/pricing.md)).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры.

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://storage.yandexcloud.net/doc-files/wordpress.zip) (1 КБ).
     1. Разархивируйте архив в папку. В результате в ней должен появиться конфигурационный файл `wordpress.tf`.

   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `wordpress.tf`:

        {% cut "wordpress.tf" %}

        ```hcl
        terraform {
          required_providers {
            yandex = {
              source  = "yandex-cloud/yandex"
              version = ">= 0.47.0"
            }
          }
        }
        
        provider "yandex" {
          zone = "ru-central1-a"
        }
        
        resource "yandex_compute_image" "wordpress" {
          source_family = "wordpress"
        }
        
        resource "yandex_compute_disk" "boot-disk" {
          name     = "bootvmdisk"
          type     = "network-hdd"
          zone     = "ru-central1-a"
          size     = "20"
          image_id = yandex_compute_image.wordpress.id
        }
        
        resource "yandex_compute_instance" "vm-wordpress" {
          name        = "wordpress"
          platform_id = "standard-v3"
        
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
            security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
          }
        
          metadata = {
            ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
          }
        }
        
        resource "yandex_vpc_security_group" "sg-1" {
          name        = "wordpress"
          description = "Description for security group"
          network_id  = yandex_vpc_network.network-1.id
        
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
        
          egress {
            protocol       = "ANY"
            description    = "any"
            v4_cidr_blocks = ["0.0.0.0/0"]
          }
        }
        
        resource "yandex_vpc_network" "network-1" {
          name = "network1"
        }
        
        resource "yandex_vpc_subnet" "subnet-1" {
          name           = "subnet1"
          zone           = "ru-central1-a"
          network_id     = yandex_vpc_network.network-1.id
          v4_cidr_blocks = ["192.168.1.0/24"]
        }
        
        resource "yandex_dns_zone" "zone-1" {
          name        = "example-zone-1"
          description = "Public zone"
          zone        = "example.com."
          public      = true
        }
        
        resource "yandex_dns_recordset" "rs-1" {
          zone_id = yandex_dns_zone.zone-1.id
          name    = "example.com."
          ttl     = 600
          type    = "A"
          data    = ["${yandex_compute_instance.vm-wordpress.network_interface.0.nat_ip_address}"]
        }
        
        resource "yandex_dns_recordset" "rs-2" {
          zone_id = yandex_dns_zone.zone-1.id
          name    = "www"
          ttl     = 600
          type    = "CNAME"
          data    = ["example.com"]
        }
        ```

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md)
    * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md)
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md)
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md)
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md)
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md)
1. В блоке `metadata` укажите метаданные для создания ВМ `<имя_пользователя>:<содержимое_SSH-ключа>`. Указанное имя пользователя не играет роли, ключ будет присвоен пользователю, который задан в конфигурации образа WordPress. В разных образах это разные пользователи. Подробнее см. в разделе [Ключи, обрабатываемые в публичных образах Yandex Cloud](../../../compute/concepts/metadata/public-image-keys.md).
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

## Получите данные для аутентификации в веб-интерфейсе {#get-auth-data}

При создании ВМ автоматически создается учетная запись администратора для веб-интерфейса. Чтобы получить данные для аутентификации:

1. Подключитесь по протоколу SSH к созданной ВМ:

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

1. Переключитесь в режим root, чтобы получить привилегии суперпользователя:

   ```bash
   sudo su
   ```

1. Откройте файл для чтения:

   ```bash
   cat root/default_passwords.txt
   ```

1. Скопируйте имя пользователя и пароль из строк `WP_ADMIN_USER` и `WP_ADMIN_PASSWORD`.

## Подключитесь к веб-интерфейсу WordPress {#connect-wordpress-interface}

Чтобы подключиться к веб-интерфейсу WordPress:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу ВМ, в блоке **Сеть** найдите публичный IP-адрес ВМ и внесите в [ресурсную запись](../../../dns/concepts/dns-zone.md) [типа А](../../../dns/concepts/resource-record.md#a), созданную ранее.
  
     ![add-ssh](../../../_assets/tutorials/wordpress/vm-create-5.png)
  
  1. В браузере перейдите по доменному имени, которое вы настроили, или по адресу ВМ в панель администратора WordPress: `http://<доменное_имя_или_публичный_адрес_ВМ>/wp-admin`.
  1. Введите имя пользователя и пароль, сохраненные ранее.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `wordpress.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Создание сайта на WordPress с помощью консоли управления](console.md).