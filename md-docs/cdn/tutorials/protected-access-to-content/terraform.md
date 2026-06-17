# Организация защищенного доступа к контенту в Cloud CDN с помощью Terraform

Чтобы настроить защищенный доступ к контенту в Cloud CDN:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Делегируйте домен сервису Cloud DNS](#delegate-domain).
1. [Создайте инфраструктуру](#deploy).
1. [Опубликуйте сайт на веб-сервере](#publish-website).
1. [Проверьте работу защищенного доступа к файлам](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для организации защищенного доступа к контенту в Cloud CDN входят:

* плата за использование [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [публичной DNS-зоны](../../../dns/concepts/dns-zone.md#public-zones) и публичные DNS-запросы ([тарифы Yandex Cloud DNS](../../../dns/pricing.md));
* плата за [хранение данных](../../../storage/concepts/bucket.md) в Object Storage, [операции](../../../storage/operations/index.md) с ними и исходящий трафик ([тарифы Object Storage](../../../storage/pricing.md));
* плата за исходящий трафик с [CDN-серверов](../../concepts/index.md) ([тарифы Cloud CDN](../../pricing.md)).


## Делегируйте домен сервису Cloud DNS {#delegate-domain}

Делегируйте ваш домен сервису Cloud DNS. Для этого в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net`.


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-cdn-protected-access
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `yc-cdn-secure-token.tf` — конфигурация создаваемой инфраструктуры.
          * `yc-cdn-secure-token.auto.tfvars` — файл c пользовательскими данными.

    - Вручную {#manual}

      1. Подготовьте файлы для загрузки в бакет:

          1. Сохраните любое изображение в формате JPEG в файл `content.jpg`.
          1. Создайте файл `index.html`:
          
              ```html
              <html>
                  <body>
                  </body>
              </html>
              ```

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке:

          1. Конфигурационный файл `yc-cdn-secure-token.tf`:

              {% cut "yc-cdn-secure-token.tf" %}

              ```hcl
              # Объявление переменных
              
              variable "folder_id" {
                type = string
              }
              
              variable "domain_name" {
                type = string
              }
              
              variable "subdomain_name" {
                type = string
              }
              
              variable "bucket_name" {
                type = string
              }
              
              variable "secure_key" {
                type = string
              }
              
              variable "ssh_key_path" {
                type = string
              }
              
              variable "index_file_path" {
                type = string
              }
              
              variable "content_file_path" {
                type = string
              }
              
              locals {
                sa_name          = "my-service-account"
                network_name     = "webserver-network"
                subnet_name      = "webserver-subnet-ru-central1-b"
                sg_name          = "webserver-sg"
                vm_name          = "mywebserver"
                domain_zone_name = "my-domain-zone"
                cert_name        = "mymanagedcert"
                origin_gp_name   = "my-origin-group"
              }
              
              # Настройка провайдера
              
              terraform {
                required_providers {
                  yandex = {
                    source = "yandex-cloud/yandex"
                  }
                }
                required_version = ">= 0.13"
              }
              
              provider "yandex" {
                folder_id = var.folder_id
              }
              
              # Создание сервисного аккаунта
              
              resource "yandex_iam_service_account" "ig-sa" {
                name = local.sa_name
              }
              
              # Назначение роли сервисному аккаунту
              
              resource "yandex_resourcemanager_folder_iam_member" "storage-editor" {
                folder_id = var.folder_id
                role      = "storage.editor"
                member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
              }
              
              # Создание статического ключа доступа для СА
              
              resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
                service_account_id = "${yandex_iam_service_account.ig-sa.id}"
              }
              
              # Создание сети
              
              resource "yandex_vpc_network" "webserver-network" {
                name = local.network_name
              }
              
              # Создание подсети
              
              resource "yandex_vpc_subnet" "webserver-subnet-b" {
                name           = local.subnet_name
                zone           = "ru-central1-b"
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
              
              # Создание загрузочного диска для ВМ
              
              resource "yandex_compute_disk" "boot-disk" {
                type     = "network-ssd"
                zone     = "ru-central1-b"
                size     = "20"
                image_id = "fd8jtn9i7e9ha5q25niu"
              }
              
              # Создание ВМ
              
              resource "yandex_compute_instance" "mywebserver" {
                name        = local.vm_name
                platform_id = "standard-v2"
                zone        = "ru-central1-b"
              
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
                  user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
                }
              }
              
              # Создание публичной DNS-зоны
              
              resource "yandex_dns_zone" "my-domain-zone" {
                name    = local.domain_zone_name
                zone    = "${var.domain_name}."
                public  = true
              }
              
              # Создание ресурсной A-записи для веб-сервера
              
              resource "yandex_dns_recordset" "rsА1" {
                zone_id = yandex_dns_zone.my-domain-zone.id
                name    = "${yandex_dns_zone.my-domain-zone.zone}"
                type    = "A"
                ttl     = 600
                data    = ["${yandex_compute_instance.mywebserver.network_interface.0.nat_ip_address}"]
              }
              
              # Добавление сертификата Let's Encrypt
              
              resource "yandex_cm_certificate" "le-certificate" {
                name    = local.cert_name
                domains = [var.domain_name,"${var.subdomain_name}.${var.domain_name}"]
              
                managed {
                challenge_type = "DNS_CNAME"
                challenge_count = 2
                }
              }
              
              # Создание CNAME-записей для валидации доменов при выпуске сертификата
              
              resource "yandex_dns_recordset" "validation-record" {
                count   = yandex_cm_certificate.le-certificate.managed[0].challenge_count
                zone_id = yandex_dns_zone.my-domain-zone.id
                name    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_name
                type    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_type
                ttl     = 600
                data    = [yandex_cm_certificate.le-certificate.challenges[count.index].dns_value]
              }
              
              # Ожидание валидации доменов и выпуска сертификата Let's Encrypt
              
              data "yandex_cm_certificate" "example-com" {
                depends_on      = [yandex_dns_recordset.validation-record]
                certificate_id  = yandex_cm_certificate.le-certificate.id
                wait_validation = true
              }
              
              # Создание бакета
              
              resource "yandex_storage_bucket" "cdn-source" {
                access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
                secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
                bucket     = var.bucket_name
                max_size   = 1073741824
              
                anonymous_access_flags {
                  read = true
                  list = true
                }
              
                website {
                  index_document = "index.html"
                }
              }
              
              # Загрузка в бакет главной страницы веб-сайта
              
              resource "yandex_storage_object" "index-object" {
                access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
                secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
                bucket     = "${yandex_storage_bucket.cdn-source.bucket}"
                key        = var.index_file_path
                source     = var.index_file_path
              }
              
              # Загрузка в бакет файла с тестовым контентом
              
              resource "yandex_storage_object" "content-object" {
                access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
                secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
                bucket     = "${yandex_storage_bucket.cdn-source.bucket}"
                key        = var.content_file_path
                source     = var.content_file_path
              }
              
              # Создание группы источников CDN
              
              resource "yandex_cdn_origin_group" "my-origin-group" {
                name = local.origin_gp_name
                origin {
                  source = "${var.bucket_name}.website.yandexcloud.net"
                }
              }
              
              # Создание CDN-ресурса
              
              resource "yandex_cdn_resource" "my-resource" {
                cname               = "${var.subdomain_name}.${var.domain_name}"
                active              = true
                origin_protocol     = "match"
                origin_group_id     = "${yandex_cdn_origin_group.my-origin-group.id}"
                ssl_certificate {
                  type = "certificate_manager"
                  certificate_manager_id = "${data.yandex_cm_certificate.example-com.id}"
                }
                options {
                  custom_host_header    = "${var.bucket_name}.website.yandexcloud.net"
                  secure_key            = "${var.secure_key}"
                  enable_ip_url_signing = true
                }
              }
              
              # Создание CNAME-записи для CDN-ресурса
              
              resource "yandex_dns_recordset" "cdn-cname" {
                zone_id = yandex_dns_zone.my-domain-zone.id
                name    = "${yandex_cdn_resource.my-resource.cname}."
                type    = "CNAME"
                ttl     = 600
                data    = [yandex_cdn_resource.my-resource.provider_cname]
              }
              ```

              {% endcut %}

          1. Файл c пользовательскими данными `yc-cdn-secure-token.auto.tfvars`:

              {% cut "yc-cdn-secure-token.auto.tfvars" %}

              ```hcl
              folder_id         = "<идентификатор_каталога>"
              ssh_key_path      = "<путь_к_файлу_с_публичным_SSH-ключом>"
              index_file_path   = "<имя_файла_с_главной_страницей_сайта>"
              content_file_path = "<имя_файла_с_контентом_для_загрузки_в_бакет>"
              domain_name       = "<имя_домена>"
              subdomain_name    = "<префикс_поддомена_для_CDN-ресурса>"
              bucket_name       = "<имя_бакета>"
              secure_key        = "<секретный_ключ>"
              ```

              {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
    * [Роль](../../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key](../../../terraform/resources/iam_service_account_static_access_key.md).
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
    * [Группа безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
    * [Диск](../../../compute/concepts/disk.md) виртуальной машины — [yandex_compute_disk](../../../terraform/resources/compute_disk.md).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md).
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md).
    * [TLS-Сертификат](../../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate](../../../terraform/resources/cm_certificate.md).
    * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md).
    * [Объект](../../../storage/concepts/object.md) — [yandex_storage_object](../../../terraform/resources/storage_object.md).
    * [Группа источников](../../concepts/origins.md#groups) — [yandex_cdn_origin_group](../../../terraform/resources/cdn_origin_group.md).
    * [CDN-ресурс](../../concepts/resource.md) — [yandex_cdn_resource](../../../terraform/resources/cdn_resource.md).

1. В файле `yc-cdn-secure-token.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее см. [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `index_file_path` — путь к файлу с главной страницей сайта.
    * `content_file_path` — путь к файлу с контентом для загрузки в бакет.
    * `domain_name` — имя вашего домена, например `example.com`.
    * `subdomain_name` — префикс поддомена для CDN-ресурса, например `cdn`.
    * `bucket_name` — имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming).
    * `secure_key` — секретный ключ. Произвольная строка длиной от 6 до 32 символов. Необходим, чтобы ограничить доступ к ресурсу с помощью [защищенных токенов](../../concepts/secure-tokens.md).

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

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](../../operations/resources/purge-cache.md).

Контент на созданном CDN-ресурсе будет доступен только по [подписанным ссылкам](../../concepts/secure-tokens.md#protected-link).


## Опубликуйте сайт на веб-сервере {#publish-website}

Далее вы создадите и опубликуете на вашем веб-сервере сайт, который будет генерировать подписанные ссылки на контент, расположенный на защищенном CDN-ресурсе. Чтобы обеспечить безопасность передаваемых данных, вы скопируете на веб-сервер созданный ранее TLS-сертификат и включите SSL-шифрование.


### Выгрузите сертификат из Certificate Manager {#export-certificate}

Чтобы использовать созданный в Certificate Manager TLS-сертификат в конфигурации вашего веб-сервера, выгрузите цепочку сертификатов и закрытый ключ в текущую директорию:

{% list tabs group=instructions %}

- Yandex Cloud CLI {#cli}

  1. Узнайте идентификатор созданного ранее TLS-сертификата:

      ```bash
      yc certificate-manager certificate list
      ```

      Результат:

      ```text
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      |          ID          |     NAME      |           DOMAINS           |      NOT AFTER      |  TYPE   | STATUS |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      | fpq90lobsh0l******** | mymanagedcert | cdn.example.com,example.com | 2024-03-22 16:42:53 | MANAGED | ISSUED |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      ```

      Подробнее о команде `yc certificate-manager certificate list` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/list.md).

  1. Выгрузите ключ и сертификат, указав полученный на предыдущем шаге идентификатор:

      ```bash
      yc certificate-manager certificate content \
        --id <идентификатор_сертификата> \
        --chain ./certificate_full_chain.pem \
        --key ./private_key.pem
      ```

      Подробнее о команде `yc certificate-manager certificate content` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/content.md).

{% endlist %}


### Настройте веб-сервер {#setup-web-server}

1. Скопируйте на ВМ с веб-сервером полученные сертификаты и закрытый ключ:

    ```bash
    scp ./certificate_full_chain.pem yc-user@<IP-адрес_ВМ>:certificate_full_chain.pem \
      && scp ./private_key.pem yc-user@<IP-адрес_ВМ>:private_key.pem
    ```

    Где `<IP-адрес_ВМ>` — публичный IP-адрес созданной ранее ВМ с веб-сервером.

    Узнать IP-адрес ВМ можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть** или с помощью команды CLI `yc compute instance get mywebserver`.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ с веб-сервером:

    ```bash
    ssh yc-user@<IP-адрес_ВМ>
    ```

1. Создайте директорию для сертификата и перенесите в нее скопированные файлы:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate_full_chain.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```

1. Создайте директорию для файлов вашего сайта и предоставьте необходимые права на нее пользователю `www-data`:

    ```bash
    sudo mkdir -p /var/www/<имя_домена>/public_html
    sudo chown www-data:www-data /var/www/<имя_домена>/public_html
    ```

    Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

1. Настройте виртуальный хост для вашего сайта:

    1. Создайте файл конфигурации виртуального хоста:

        ```bash
        sudo nano /etc/apache2/sites-available/mywebsite.conf
        ```

    1. Поместите в созданный файл следующую конфигурацию:

        ```text
        <VirtualHost *:443>
        ServerName <имя_домена>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/<имя_домена>/public_html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        SSLEngine on
        SSLCertificateFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateChainFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

    1. Активируйте созданный виртуальный хост:

        ```bash
        sudo a2ensite mywebsite
        ```

        Результат:

        ```text
        Enabling site mywebsite.
        To activate the new configuration, you need to run:
          systemctl reload apache2
        ```

    1. Включите для веб-сервера поддержку `ssl`:

        ```bash
        sudo a2enmod ssl
        ```

        Результат:

        ```text
        Considering dependency setenvif for ssl:
        Module setenvif already enabled
        Considering dependency mime for ssl:
        Module mime already enabled
        Considering dependency socache_shmcb for ssl:
        Enabling module socache_shmcb.
        Enabling module ssl.
        See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
        To activate the new configuration, you need to run:
          systemctl restart apache2
        ```

    1. Перезапустите веб-сервер:

        ```bash
        sudo systemctl reload apache2
        ```


### Создайте сайт {#create-website}

1. Создайте файл главной страницы сайта:

    ```bash
    sudo nano /var/www/<имя_домена>/public_html/index.php
    ```

    Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

1. Поместите в созданный файл `index.php` следующий код:

    ```php
    <!DOCTYPE html>
    <html>
    <head>
      <title>Secure token generator website</title>
      <meta charset="utf-8" />
    </head>
    <body>

      <h2>Генератор защищенных ссылок</h2>
      <p>Ниже сгенерирована подписанная ссылка на защищенный CDN-ресурс. Срок жизни ссылки — 5 минут. Контент по ссылке доступен лишь тому пользователю, для которого сайт эту ссылку сгенерировал (проверяется по IP-адресу).</p>
      <br>

      <?php

        $secret = '<секретный_ключ>';
        $ip = trim(getUserIpAddr());
        $domain_name = '<доменное_имя>';
        $path = '<ключ_объекта>';
        $expires = time() + 300;
        $link = "$expires$path$ip $secret";
        $md5 = md5($link, true);
        $md5 = base64_encode($md5);
        $md5 = strtr($md5, '+/', '-_');
        $md5 = str_replace('=', '', $md5);
        $url = '<a href="https://'.$domain_name.$path.'?md5='.$md5.'&expires='.$expires.'" target="_blank">Подписанная ссылка на файл</a>';
    
        echo "<p>Ваш IP-адрес: <b>".$ip."</b></p><p>Если вы используете VPN, ссылка может не сработать. Для корректной работы генератора подписанных ссылок отключите VPN.</p>";
        echo "<br><br>";
        echo $url;
    
        function getUserIpAddr() {

            if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
               $addr = $_SERVER['HTTP_CLIENT_IP'];
            } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
               $addr = $_SERVER['HTTP_X_FORWARDED_FOR'];
            } else {
               $addr = $_SERVER['REMOTE_ADDR'];
            }
            return $addr;
        }
      ?>

    </body>
    </html>
    ```

    Где:
    * `$secret` — созданный при настройке CDN-ресурса секретный ключ.
    * `$domain_name` — доменное имя созданного CDN-ресурса. Например: `cdn.example.com`.
    * `$path` — [ключ объекта](../../../storage/concepts/object.md#key) в бакете-[источнике](../../concepts/origins.md), например `/content.jpg`. Обязательно со знаком `/`.
       Сайт будет генерировать подписанную ссылку для доступа к этому объекту через CDN-ресурс.


## Проверьте работу защищенного доступа к файлам {#check}

Чтобы проверить работу генератора подписанных ссылок на защищенный CDN-ресурс:

1. Откройте в браузере созданный сайт, например `https://example.com`.
1. Пройдите по сгенерированной ссылке.

    Если все работает правильно, у вас должно открыться изображение на защищенном CDN-ресурсе.

    {% note info %}

    Подключенный VPN может мешать правильной работе генератора подписанных ссылок. Для корректной работы сайта отключите VPN.

    {% endnote %}

1. Откройте полученную ссылку на другом устройстве, выходящем в интернет с другого IP-адреса. Например, на смартфоне.

    Доступ к контенту окажется запрещен.

1. Попробуйте открыть полученную ссылку на исходном устройстве по истечении пяти минут.

    Доступ к контенту окажется запрещен.

Вы настроили защищенный доступ к контенту.

При формировании ссылок также можно [задать](../../operations/resources/enable-secure-token.md) определенный доверенный IP-адрес, например IP-адрес компании, который используется в корпоративной сети для доступа к интернету. Так вы сможете запретить доступ к вашему контенту за пределами сетевой инфраструктуры вашей компании.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `yc-cdn-secure-token.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Организация защищенного доступа к контенту в Cloud CDN с помощью консоли управления, CLI или API](console.md)