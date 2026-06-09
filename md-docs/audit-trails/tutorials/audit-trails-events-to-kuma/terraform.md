# Загрузка аудитных логов в SIEM KUMA с помощью Terraform

# Загрузка аудитных логов Yandex Audit Trails в SIEM KUMA с помощью Terraform


Чтобы настроить доставку файлов аудитных логов в [KUMA](https://www.kaspersky.ru/enterprise-security/unified-monitoring-and-analysis-platform):

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Смонтируйте бакет на сервере](#mount-bucket).
1. [Настройте коллектор KUMA](#setup-collector).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры Yandex Cloud входят:

* плата за хранение данных, операции с данными, а также исходящий трафик (см. [тарифы Yandex Object Storage](../../../storage/pricing.md));
* плата за использование симметричного ключа шифрования и выполнение криптографических операций (см. [тарифы Yandex Key Management Service](../../../kms/pricing.md));
* (опционально) плата за постоянно запущенную виртуальную машину (см. [тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* (опционально) плата за использование динамического или статического внешнего IP-адреса (см. [тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).

Кроме этого, для прохождения руководства вы должны иметь [лицензию](https://kb.kuma-community.ru/books/kuma-how-to/page/model-licenzirovaniia-kuma) на использование KUMA (не поставляется Yandex Cloud).


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Чтобы создайть инфраструктуру с помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Склонируйте репозиторий с конфигурационными файлами:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-audit-trails-kuma-integration
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `at-events-to-kuma.tf` — конфигурация создаваемой инфраструктуры.
          * `at-events-to-kuma.auto.tfvars` — пользовательские данные.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `at-events-to-kuma.tf`:

          {% cut "at-events-to-kuma.tf" %}

          ```hcl
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
          
          # Объявление переменных для пользовательских параметров
          
          variable "folder_id" {
            type = string
          }
          
          variable "vm_user" {
            type = string
          }
          
          variable "ssh_key_path" {
            type = string
          }
          
          variable "bucket_name" {
            type = string
          }
          
          variable "object_prefix" {
            type = string
          }
          
          # Добавление прочих переменных
          
          locals {
            sa_bucket_name = "kuma-bucket-sa"
            sa_trail_name  = "kuma-trail-sa"
            sym_key_name   = "kuma-key"
            trail_name     = "kuma-trail"
            zone           = "ru-central1-b"
            network_name   = "kuma-network"
            subnet_name    = "kuma-network-ru-central1-b"
            vm_name        = "kuma-server"
            image_id       = "fd8ulbhv5dpakf3io1mf"
          }
          
          # Создание сервисных аккаунтов
          
          resource "yandex_iam_service_account" "sa-bucket" {
            name        = local.sa_bucket_name
            folder_id   = "${var.folder_id}"
          }
          
          resource "yandex_iam_service_account" "sa-trail" {
            name        = local.sa_trail_name
            folder_id   = "${var.folder_id}"
          }
          
          # Создание статического ключа доступа
          
          resource "yandex_iam_service_account_static_access_key" "sa-bucket-static-key" {
            service_account_id = yandex_iam_service_account.sa-bucket.id
          }
          
          output "access_key" {
            value = yandex_iam_service_account_static_access_key.sa-bucket-static-key.access_key
            sensitive = true
          }
          
          output "secret_key" {
            value = yandex_iam_service_account_static_access_key.sa-bucket-static-key.secret_key
            sensitive = true
          }
          
          # Создание симметричного ключа шифрования
          
          resource "yandex_kms_symmetric_key" "sym_key" {
            name              = local.sym_key_name
            default_algorithm = "AES_256"
          }
          
          # Назначение ролей сервисным аккаунтам
          
          resource "yandex_resourcemanager_folder_iam_member" "sa-bucket-storage-viewer" {
            folder_id   = "${var.folder_id}"
            role        = "storage.admin"
            member      = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "sa-trail-storage-uploader" {
            folder_id   = "${var.folder_id}"
            role        = "storage.uploader"
            member      = "serviceAccount:${yandex_iam_service_account.sa-trail.id}"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "sa-trail-at-viewer" {
            folder_id   = "${var.folder_id}"
            role        = "audit-trails.admin"
            member      = "serviceAccount:${yandex_iam_service_account.sa-trail.id}"
          }
          
          resource "yandex_kms_symmetric_key_iam_binding" "encrypter-decrypter" {
            symmetric_key_id = "${yandex_kms_symmetric_key.sym_key.id}"
            role             = "kms.keys.encrypterDecrypter"
            members          = [
              "serviceAccount:${yandex_iam_service_account.sa-bucket.id}","serviceAccount:${yandex_iam_service_account.sa-trail.id}"
            ]
          }
          
          # Создание бакета
          
          resource "yandex_storage_bucket" "kuma-bucket" {
            folder_id = "${var.folder_id}"
            bucket                = "${var.bucket_name}"
            default_storage_class = "standard"
            anonymous_access_flags {
              read        = false
              list        = false
              config_read = false
            }
          
            server_side_encryption_configuration {
              rule {
                apply_server_side_encryption_by_default {
                  kms_master_key_id = "${yandex_kms_symmetric_key.sym_key.id}"
                  sse_algorithm     = "aws:kms"
                }
              }
            }
          }
          
          # Создание трейла
          
          resource "yandex_audit_trails_trail" "kuma-trail" {
            depends_on         = [yandex_storage_bucket.kuma-bucket, yandex_resourcemanager_folder_iam_member.sa-trail-at-viewer, yandex_resourcemanager_folder_iam_member.sa-trail-storage-uploader]
            name               = local.trail_name
            folder_id          = "${var.folder_id}"
            service_account_id = "${yandex_iam_service_account.sa-trail.id}"
            storage_destination {
              bucket_name   = "${var.bucket_name}"
              object_prefix = "${var.object_prefix}"
            }
            filtering_policy {
              management_events_filter {
                resource_scope {
                  resource_id   = "${var.folder_id}"
                  resource_type = "resource-manager.folder"
                }
              }
            }
          }
          
          # Создание облачной сети и подсети
          
          resource "yandex_vpc_network" "kuma-network" {
            name = local.network_name
          }
          
          resource "yandex_vpc_subnet" "kuma-network-subnet-b" {
            name           = local.subnet_name
            zone           = local.zone
            v4_cidr_blocks = ["10.1.0.0/24"]
            network_id     = yandex_vpc_network.kuma-network.id
          }
          
          # Создание ВМ
          
          resource "yandex_compute_disk" "boot-disk" {
            name     = "bootvmdisk"
            type     = "network-hdd"
            zone     = local.zone
            size     = "20"
            image_id = local.image_id
          }
          
          resource "yandex_compute_instance" "kuma-vm" {
            name               = local.vm_name
            platform_id        = "standard-v3"
            zone               = local.zone
          
            resources {
              cores         = 2
              memory        = 2
              core_fraction = 20
            }
          
            boot_disk {
              disk_id = yandex_compute_disk.boot-disk.id
            }
          
            network_interface {
              subnet_id          = yandex_vpc_subnet.kuma-network-subnet-b.id
              nat                = true
            }
          
            metadata = {
              user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
            }
          }
          ```

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `at-events-to-kuma.auto.tfvars`:

          {% cut "at-events-to-kuma.auto.tfvars" %}

          ```hcl
          folder_id          = "<идентификатор_каталога>"
          vm_user            = "<имя_пользователя_ВМ>"
          ssh_key_path       = "<путь_к_публичному_SSH-ключу>"
          bucket_name        = "<имя_бакета>"
          object_prefix      = "<префикс>"
          ```

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md)
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key](../../../terraform/resources/iam_service_account_static_access_key.md)
    * [Симметричный ключ шифрования](../../../kms/concepts/key.md) — [yandex_kms_symmetric_key](../../../terraform/resources/kms_symmetric_key.md)
    * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md)
    * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md)
    * [Трейл](../../concepts/trail.md) — [yandex_audit_trails_trail](../../../terraform/resources/audit_trails_trail.md)
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md)
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md)
    * [Диск](../../../compute/concepts/disk.md) — [yandex_compute_disk](../../../terraform/resources/compute_disk.md)
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md)

1. В файле `at-events-to-kuma.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя, который будет создан на ВМ, например `yc-user`.

        {% note alert %}
        
        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
        
        {% endnote %}

    * `ssh_key_path` — путь к файлу с открытым SSH-ключом и его имя, например: `~/.ssh/id_ed25519.pub`. Пару SSH-ключей для подключения к ВМ по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
    * `bucket_name` —  [имя бакета](../../../storage/concepts/bucket.md#naming), в который будут загружаться аудитные логи. Например `my-audit-logs-for-kuma`.

        {% note info %}
        
        Имя бакета должно быть уникальным для всего Object Storage. Нельзя создать два бакета с одинаковыми именами даже в разных каталогах разных облаков.
        
        {% endnote %}

    * `object_prefix` — [префикс](../../../storage/concepts/object.md#folder), который будет добавлен к именам объектов с аудитными логами в бакете. Например: `/`. Префикс участвует в [полном имени](../../concepts/format.md#log-file-name) файла аудитного лога. 

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

1. Получите [идентификатор ключа](../../../iam/concepts/authorization/access-key.md#key-id) и [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key), которые понадобятся позднее при монтировании бакета на сервере:

    ```hcl
    terraform output access_key
    terraform output secret_key
    ```

    Результат:

    ```text
    "YCAJE0tO1Q4zO7bW4********"
    "YCNpH34y9fzL6xEap3wkuxYfkc1PTNvr********"
    ```

После создания инфраструктуры [cмонтируйте бакет на сервере](#mount-bucket) и [настройте коллектор KUMA](#setup-collector).


## Смонтируйте бакет на сервере {#mount-bucket}

Это действие выполняется на сервере, на котором будет установлен коллектор KUMA. В качестве сервера вы можете использовать виртуальную машину в Compute Cloud или свое оборудование. В данном руководстве используется ВМ Compute Cloud, созданная ранее.

1. Подключитесь к серверу по [SSH](../../../compute/operations/vm-connect/ssh.md).
1. Создайте нового пользователя `kuma`:

    ```bash
    sudo useradd kuma
    ```

1. Создайте домашнюю директорию пользователя `kuma`:

    ```bash
    sudo mkdir /home/kuma
    ```

1. Создайте файл со статическим ключом доступа и выдайте пользователю `kuma` права на него:

    ```bash
    sudo bash -c 'echo <идентификатор_ключа_доступа>:<секретный_ключ_доступа> > /home/kuma/.passwd-s3fs'
    sudo chmod 600 /home/kuma/.passwd-s3fs
    sudo chown -R kuma:kuma /home/kuma
    ```

    Где `<идентификатор_ключа_доступа>` и `<секретный_ключ_доступа>` — сохраненные ранее значения статического ключа доступа сервисного аккаунта `kuma-bucket-sa`.

1. Установите пакет [s3fs](https://github.com/s3fs-fuse/s3fs-fuse):

    ```bash
    sudo apt install s3fs
    ````

1. Создайте директорию, которая будет служить точкой монтирования для бакета, и выдайте пользователю `kuma` права на эту директорию:

    ```bash
    sudo mkdir /var/log/yandex-cloud/
    sudo chown kuma:kuma /var/log/yandex-cloud/
    ```

1. Смонтируйте созданный ранее бакет, указав его имя:

    ```bash
    sudo s3fs <имя_бакета> /var/log/yandex-cloud \
      -o passwd_file=/home/kuma/.passwd-s3fs \
      -o url=https://storage.yandexcloud.net \
      -o use_path_request_style \
      -o uid=$(id -u kuma) \
      -o gid=$(id -g kuma)
    ```

    Вы можете настроить автоматическое монтирование бакета при запуске операционной системы, для этого откройте файл `/etc/fstab` (команда `sudo nano /etc/fstab`) и добавьте в него строку:

    ```text
    s3fs#<имя_бакета> /var/log/yandex-cloud fuse _netdev,uid=<kuma_uid>,gid=<kuma_gid>,use_path_request_style,url=https://storage.yandexcloud.net,passwd_file=/home/kuma/.passwd-s3fs 0 0
    ```

    Где:

    * `<имя_бакета>` — имя созданного ранее бакета, например: `my-audit-logs-for-kuma`.
    * `<kuma_uid>` — идентификатор пользователя `kuma` в операционной системе ВМ.
    * `<kuma_gid>` — идентификатор группы пользователей `kuma` в операционной системе ВМ.

        Чтобы узнать значения `<kuma_uid>` и `<kuma_gid>`, в терминале выполните команду `id kuma`.

1. Убедитесь, что бакет смонтирован:

    ```bash
    sudo ls /var/log/yandex-cloud/
    ```

    Если все настроено верно, команда вернет текущее содержимое бакета с аудитными событиями.

Настройка передачи событий Yandex Cloud завершена. События будут располагаться в следующих директориях в [JSON](https://ru.wikipedia.org/wiki/JSON)-файлах:

```text
/var/log/yandex-cloud/{audit_trail_id}/{year}/{month}/{day}/*.json
```


## Настройте коллектор KUMA {#setup-collector}

На этом шаге вам понадобятся файлы дистрибутива и лицензии, входящие в комплект поставки KUMA. Используйте их, чтобы установить и настроить коллектор в сетевой инфраструктуре KUMA. Подробнее см. в [инструкции](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/220708.htm).

После успешного завершения настройки аудитные события начнут поставляться в KUMA. Веб-интерфейс KUMA позволяет выполнять [поиск связанных событий](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/217989.htm).


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `at-events-to-kuma.tf` и удалите описание создаваемой инфраструктуры из файла.
1. [Удалите](../../../storage/operations/objects/delete-all.md) все объекты из созданного ранее бакета. Если этого не сделать, бакет и часть инфраструктуры не будут удалены, а команда `terraform apply` завершится ошибкой.
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

#### См. также {#see-also}

* [Загрузка аудитных логов в SIEM KUMA с помощью консоли управления, CLI или API](console.md)