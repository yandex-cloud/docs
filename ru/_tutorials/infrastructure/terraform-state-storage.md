# Загрузка состояний {{ TF }} в {{ objstorage-full-name }}


В инструкции описываются шаги загрузки состояния {{ TF }} в [{{ objstorage-name }}](../../storage/).

Состояние {{ TF }} описывает текущую развернутую инфраструктуру и хранится в файлах с расширением `.tfstate`. Файл состояния создается после развертывания инфраструктуры и может быть сразу загружен в {{ objstorage-name }}. Загруженный файл состояния будет обновляться после изменений созданной инфраструктуры.
 
В этом примере сохраненное состояние позволит другим пользователям получить идентификатор одной из созданных [подсетей](../../vpc/concepts/network.md#subnet), чтобы подключить к ней новую [виртуальную машину](../../compute/concepts/vm.md).

Чтобы настроить хранение состояний {{ TF }} в {{ objstorage-name }} и использовать его для создания новых ресурсов:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Необходимые платные ресурсы](#paid-resources).
1. [Установите и настройте {{ TF }}](#install-terraform).
1. [Настройте бэкенд](#set-up-backend).
1. [Разверните конфигурацию](#deploy).
1. [Проверьте сохраненное состояние](#check-condition).
1. [Получите состояние из бэкенда](#retrieve-state).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% note alert %}

Все созданные с помощью {{ TF }} ресурсы тарифицируются, внимательно проверьте конфигурации, которые будут использоваться далее.

{% endnote %}

В этом сценарии будут созданы три ВМ с [публичными IP-адресами](../../vpc/concepts/address.md#public-addresses), виртуальная [сеть](../../vpc/concepts/network.md#network) и две подсети.

В стоимость поддержки этой инфраструктуры входят:
* Плата за хранение данных (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage)).
* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте сервисный аккаунт и статический ключ доступа {#create-service-account}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) [editor](../../iam/roles-reference.md#editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), указанный в настройках провайдера.
1. [Получите статический ключ доступа](../../iam/operations/sa/create-access-key.md). Сохраните идентификатор ключа и секретный ключ — они понадобятся в следующих разделах инструкции.

### Создайте бакет {#create-service-account}

[Создайте бакет](../../storage/operations/buckets/create.md) с ограниченным доступом. В нем будет храниться файл состояния {{ TF }}.

## Установите и настройте {{ TF }} {#prepare-terraform}

{% include notitle [terraform-prepare.md](../../_tutorials/infrastructure/terraform-prepare.md) %}

## Настройте бэкенд {#set-up-backend}

{% note info %}

Настройки бэкенда применимы для {{ TF }} `1.6.3` и более поздних версий.

{% endnote %}

1. Добавьте в переменные окружения идентификатор ключа и секретный ключ, [полученные ранее](#create-service-account):

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     export ACCESS_KEY="<идентификатор_ключа>"
     export SECRET_KEY="<секретный_ключ>"
     ```

   - PowerShell {#powershell}

     ```powershell
     $ACCESS_KEY="<идентификатор_ключа>"
     $SECRET_KEY="<секретный_ключ>"
     ```

   {% endlist %}

1. Добавьте в конфигурационный файл настройки провайдера и бэкенда:

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoints = {
         s3 = "https://{{ s3-storage-host }}"
       }
       bucket = "<имя_бакета>"
       region = "{{ region-id }}"
       key    = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # Необходимая опция {{ TF }} для версии 1.6.1 и старше.
       skip_s3_checksum            = true # Необходимая опция при описании бэкенда для {{ TF }} версии 1.6.3 и старше.

     }
   }

   provider "yandex" {
     zone      = "<зона_доступности_по_умолчанию>"
   }
   ```

   Подробнее о бэкенде для хранения состояний читайте на [сайте {{ TF }}](https://www.terraform.io/docs/backends/types/s3.html).
1. В папке с конфигурационным файлом выполните команду:

   ```bash
   terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
   ```

{% include [deploy-infrastructure-step](../_tutorials_includes/deploy-infrastructure-step.md) %}

{% include [check-condition-step](../_tutorials_includes/check-condition-step.md) %}

## Получите состояние из бэкенда {#retrieve-state}

Сохраненное в {{ objstorage-name }} состояние {{ TF }} можно запросить из другой конфигурации и дополнить уже созданную инфраструктуру.

Создайте еще одну конфигурацию и используйте сохраненное состояние, чтобы создать еще одну ВМ в одной из заранее созданных подсетей:
1. Создайте директорию `remote-state`.
1. Перейдите в созданную директорию и создайте конфигурацию `remote-state.tf`:

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     zone      = "{{ region-id }}-a"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3" 
     config  = {
       endpoints = {
         s3 = "https://{{ s3-storage-host }}"
       }
       bucket = "<имя_бакета>"
       region = "{{ region-id }}"
       key    = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # Необходимая опция при описании бэкенда для Terraform версии старше 1.6.1.

       access_key = "<идентификатор_ключа>"
       secret_key = "<секретный_ключ>"

      }
    }

   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_disk" "boot-disk-vm3" {
     name     = "boot-disk-3"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm3.id
     }

     network_interface {
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<путь_к_публичному_SSH-ключу>")}"
     }
   }
   ```

   Где:
   * `bucket` — имя бакета.
   * `key` — ключ объекта в бакете: путь и имя к файлу состояния {{ TF }} в бакете.
   * `access_key` — [идентификатор секретного ключа](#create-service-account) [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), для доступа к бакету.
   * `secret_key` — значение секретного ключа сервисного аккаунта.
1. Выполните команду `terraform init`.
1. Выполните команду `terraform plan`. В терминале должен отобразиться план создания одной ВМ.
1. Выполните команду `terraform apply`.
1. Перейдите в консоль управления и убедитесь, что в разделе {{ compute-name }} появилась ВМ `terraform3`.

## Удалите созданные ресурсы {#clear-out}

Чтобы удалить созданные ресурсы, выполните команду `terraform destroy` сначала во второй конфигурации, а затем в первой.

## См. также {#see-also}

* [Начало работы с {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Блокировка состояний {{ TF }} с помощью {{ ydb-name }}](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [Использование модулей {{ yandex-cloud }} в {{ TF }}](../../tutorials/infrastructure-management/terraform-modules.md).
* [Источники данных {{ TF }}](../../tutorials/infrastructure-management/terraform-data-sources.md).
