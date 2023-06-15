# Загрузка состояний {{ TF }} в {{ objstorage-name }}

В инструкции описываются шаги загрузки состояния {{ TF }} в [{{ objstorage-full-name }}](../../storage/).

Состояние {{ TF }} описывает текущую развернутую инфраструктуру и хранится в файлах с расширением `.tfstate`. Файл состояния создается после развертывания инфраструктуры и может быть сразу загружен в {{ objstorage-name }}. Загруженный файл состояния будет обновляться после изменений созданной инфраструктуры.
 
В этом примере сохраненное состояние позволит другим пользователям получить идентификатор одной из созданных [подсетей](../../vpc/concepts/network.md#subnet), чтобы подключить к ней новую [виртуальную машину](../../compute/concepts/vm.md). 

Чтобы настроить хранение состояний {{ TF }} в {{ objstorage-name }} и использовать его для создания новых ресурсов:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Необходимые платные ресурсы](#paid-resources).
1. [Установите {{ TF }}](#install-terraform).
1. [Создайте файл конфигурации {{ TF }}](#configure-terraform).
1. [Настройте провайдер](#configure-provider).
1. [Создайте сервисный аккаунт и статический ключ доступа](#create-service-account).
1. [Создайте бакет](#create-service-account).
1. [Настройте бэкенд](#set-up-backend).
1. [Разверните конфигурацию](#deploy).
1. [Проверьте сохраненное состояние](#check-condition).
1. [Получите состояние из бэкенда](#retrieve-state).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{{ TF }} и его провайдеры распространяются под лицензией [Mozilla Public License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% note alert %}

Все созданные с помощью {{ TF }} ресурсы тарифицируются, внимательно проверьте конфигурации, которые будут использоваться далее.

{% endnote %}

В этом сценарии будут созданы три ВМ с публичными IP-адресами, виртуальная сеть и две подсети.

В стоимость поддержки этой инфраструктуры входят:
* Плата за хранение данных (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage)).
* Плата за диски и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Установите {{ TF }} {#install-terraform}

{% include [terraform-install](../../_tutorials/terraform-install.md) %}

## Создайте файл конфигурации {{ TF }} {#configure-terraform}

{% include [configure-terraform](../_tutorials_includes/configure-terraform.md) %}

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Создайте сервисный аккаунт и статический ключ доступа {#create-service-account}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) [editor](../../iam/concepts/access-control/roles.md#editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), указанный в настройках провайдера.
1. [Получите статический ключ доступа](../../iam/operations/sa/create-access-key.md). Сохраните идентификатор ключа и секретный ключ — они понадобятся в следующих разделах инструкции.

## Создайте бакет {#create-service-account}

[Создайте бакет](../../storage/operations/buckets/create.md) с любым именем, например `terraform-object-storage-tutorial`. В нем будет храниться файл состояния {{ TF }}.

## Настройте бэкенд {#set-up-backend}

1. Добавьте в переменные окружения идентификатор ключа и секретный ключ, [полученные ранее](#create-service-account):

    {% list tabs %}

    - Bash

      ```bash
      export ACCESS_KEY="<идентификатор_ключа>"
      export SECRET_KEY="<секретный_ключ>"
      ```
    
    - PowerShell

      ```powershell
      $Env:ACCESS_KEY="<идентификатор_ключа>"
      $Env:SECRET_KEY="<секретный_ключ>"
      ```

    {% endlist %}

1. Добавьте настройки провайдера и бэкенда в конфигурационный файл:

    
    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }

      backend "s3" {
        endpoint   = "{{ s3-storage-host }}"
        bucket     = "<имя_бакета>"
        region     = "{{ region-id }}"
        key        = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

        skip_region_validation      = true
        skip_credentials_validation = true
      }
    }

    provider "yandex" {
      token     = "<OAuth_или_статический_ключ_сервисного_аккаунта>"
      cloud_id  = "<идентификатор_облака>"
      folder_id = "<идентификатор_каталога>"
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
     token     = "<OAuth_или_статический_ключ_сервисного_аккаунта>"
     cloud_id  = "<идентификатор_облака>"
     folder_id = "<идентификатор_каталога>"
     zone      = "{{ region-id }}-a"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3"
     config = {
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<имя_бакета>"
       region     = "{{ region-id }}"
       key        = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = "fd87va5cc00gaq2f5qfb"
       }
     }

     network_interface {
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }
   ```



1. Выполните команду `terraform init`.
1. Выполните команду `terraform plan`. В терминале должен отобразиться план создания одной ВМ.
1. Выполните команду `terraform apply`.
1. Перейдите в консоль управления и убедитесь, что в разделе {{ compute-name }} появилась ВМ `terraform3`.

## Удалите созданные ресурсы {#clear-out}

Чтобы удалить созданные ресурсы, выполните команду `terraform destroy` сначала во второй конфигурации, а затем в первой.

## См. также {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-state-lock.md).
