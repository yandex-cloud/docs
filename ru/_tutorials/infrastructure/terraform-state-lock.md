---
title: "Блокировка состояний {{ TF }}"
description: "При работе с {{ TF }} в облаке важно исключить возможность одновременного изменения инфраструктуры разными пользователями. Для этого применяется блокировка состояний {{ TF }} (state locking)."
---

# Блокировка состояний {{ TF }} с помощью {{ ydb-name }}

В {{ yandex-cloud }} поддерживается [управление инфраструктурой с помощью {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md). Чтобы управлять инфраструктурой могли несколько пользователей одновременно, состояния {{ TF }} можно [автоматически загружать и хранить в {{ objstorage-full-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).

Когда несколько пользователей одновременно работают с одним состоянием из {{ objstorage-name }}, возможны конфликты. Чтобы предотвратить их, вы можете развернуть базу данных в [{{ ydb-full-name }}](../../ydb/) и использовать ее для механизма блокировок, встроенного в {{ TF }} (state locking). При каждом изменении инфраструктуры через {{ TF }} состояние будет автоматически блокироваться, пока изменение не применится.

Чтобы настроить хранение состояний {{ TF }} в {{ objstorage-name }} и их блокировку с помощью {{ ydb-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт и статический ключ доступа](#create-service-account).
1. [Создайте бакет](#create-service-account).
1. [Создайте БД {{ ydb-name }}](#db-create).
1. [Установите и настройте {{ TF }}](#prepare-terraform).
1. [Настройте бэкенд](#set-up-backend).
1. [Разверните конфигурацию](#deploy).
1. [Проверьте сохраненное состояние](#check-condition).
1. [Проверьте блокировку состояния](#check-state-lock).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для работы с состояниями {{ TF }} входят:
* Плата за хранение данных (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage)).
* Плата за выполнение запросов к базе данных (см. [тарифы {{ ydb-name }}](../../ydb/pricing/serverless.md)).

В стоимость поддержки инфраструктуры, разворачиваемой через {{ TF }} в этом сценарии в качестве примера, входят:
* Плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

Если вы разворачиваете ресурсы других сервисов {{ yandex-cloud }}, стоимость изменится в соответствии с [тарифами](/prices) этих сервисов.

## Создайте сервисный аккаунт и статический ключ доступа {#create-service-account}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) [storage.editor](../../storage/security/index.md#storage-editor) и [ydb.admin](../../ydb/security/index.md#ydbadmin) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), указанный в настройках провайдера.
1. [Получите статический ключ доступа](../../iam/operations/sa/create-access-key.md). Сохраните идентификатор ключа и секретный ключ — они понадобятся в следующих разделах инструкции.

## Создайте бакет {#create-service-account}

[Создайте бакет](../../storage/operations/buckets/create.md) с ограниченным доступом. В нем будет храниться файл состояния {{ TF }}.

## Создайте базу данных {{ ydb-name }} {#db-create}

[Создайте](../../ydb/operations/manage-databases.md#create-db-serverless) [Serverless](../../ydb/concepts/resources.md#serverless) [БД](../../ydb/concepts/resources.md#database) с именем `state-lock-db`.

### Создайте таблицу {#table-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ваша БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. В списке БД выберите `state-lock-db`.
  1. Перейдите на вкладку **Навигация**.
  1. В правом верхнем углу нажмите **Создать** и выберите **Таблица**.
  1. Укажите имя таблицы `state-lock-table`.
  1. В параметрах таблицы укажите **Тип таблицы** — документная таблица.
  1. В графе **Колонки** укажите:
     * **Имя** — `LockID`.
     * **Тип** — `String`.
     * **Ключ партицирования** — поставьте галочку.

     Остальные колонки удалите.
  1. Нажмите **Создать таблицу**.

- AWS CLI {#cli}

  Чтобы создать таблицу с помощью [AWS CLI](../../storage/tools/aws-cli.md):
  1. Выполните команду:

     ```bash
     aws dynamodb create-table \
       --table-name <имя_таблицы> \
       --attribute-definitions \
         AttributeName=LockID,AttributeType=S \
       --key-schema \
         AttributeName=LockID,KeyType=HASH \
       --endpoint <document-api-endpoint_БД>
     ```

     Где:
     * `--table-name` — имя [таблицы](../../ydb/concepts/dynamodb-tables.md).
     * `--attribute-definitions` — параметры колонок:
       * `AttributeName` — имя колонки.
       * `AttributeType` — тип данных. В примере используется строковые данные (`S`).
     * `--key-schema` — схема ключей для колонки:
       * `AttributeName` — имя колонки.
       * `KeyType` — тип ключа. В примере используется ключ партицирования (`HASH`).
     * `--endpoint` — эндпоинт Document API БД. Найти его можно на главной странице БД, в графе **Document API эндпоинт**.

{% endlist %}

## Установите и настройте {{ TF }} {#prepare-terraform}

### Установите {{ TF }} {#install-terraform}


#### Из зеркала {#from-yc-mirror}

Вы можете скачать дистрибутив {{ TF }} для вашей платформы из [зеркала]({{ terraform-mirror }}). После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`:

```bash
export PATH=$PATH:/path/to/terraform
```

#### С сайта Hashicorp {#from-hashicorp-site}


{% list tabs group=operating_system %}

- Windows {#windows}

  Используйте один из способов:

  * [Скачайте дистрибутив {{ TF }}](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите {{ TF }} с помощью пакетного менеджера [Chocolatey](https://chocolatey.org/install), используя команду:

     ```
     choco install terraform
     ```

- Linux {#linux}

  [Скачайте дистрибутив {{ TF }}](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS {#macos}

  Используйте один из способов:

    * [Скачайте дистрибутив {{ TF }}](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
    * Установите {{ TF }} с помощью пакетного менеджера [Homebrew](https://brew.sh), используя команду:

      ```
      brew install terraform
      ```

{% endlist %}

### Получите данные для аутентификации {#get-credentials}

Чтобы управлять инфраструктурой {{ yandex-cloud }} с помощью {{ TF }}, используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Это позволит гибко настраивать права доступа к ресурсам.

Также вы можете использовать {{ TF }} от имени [аккаунта на Яндексе](../../iam/concepts/index.md#passport) или [федеративного аккаунта](../../iam/concepts/index.md#saml-federation), однако этот способ является менее безопасным. Подробности см. в конце раздела.

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите](../../cli/quickstart.md#install) его.

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта и запишите его файл:

          ```bash
          yc iam key create \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --folder-name <имя_каталога_с_сервисным_аккаунтом> \
            --output key.json
          ```

          Где:
          * `service-account-id` — идентификатор сервисного аккаунта.
          * `folder-name` — имя каталога, в котором создан сервисный аккаунт.
          * `output` — имя файла с авторизованным ключом.

          Результат:

          ```yaml
          id: aje8nn871qo4********
          service_account_id: ajehr0to1g8b********
          created_at: "2022-09-14T09:11:43.479156798Z"
          key_algorithm: RSA_2048
          ```

      1. Создайте профиль CLI для выполнения операций от имени сервисного аккаунта. Укажите имя профиля:

          ```bash
          yc config profile create <имя_профиля>
          ```

          Результат:

          ```text
          Profile 'sa-terraform' created and activated
          ```

      1. Задайте конфигурацию профиля:

          ```bash
          yc config set service-account-key key.json
          yc config set cloud-id <идентификатор_облака>
          yc config set folder-id <идентификатор_каталога>
          ```

          Где:
          * `service-account-key` — файл с авторизованным ключом сервисного аккаунта.
          * `cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
          * `folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

    {% endlist %}

1. Добавьте аутентификационные данные в переменные окружения:

    {% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}


{% cut "Управление ресурсами от имени аккаунта на Яндексе или федеративного аккаунта" %}

{% include [terraform-credentials-user](../../_tutorials/terraform-credentials-user.md) %}

{% endcut %}



### Создайте файл конфигурации {{ TF }} {#configure-terraform}

{% include [configure-terraform](../_tutorials_includes/configure-terraform.md) %}

### Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Настройте бэкенд {#set-up-backend}

{% note info %}

Настройки бэкенда применимы для {{ TF }} `1.6.3` и более поздних версий.

{% endnote %}

Чтобы сохранить состояние {{ TF }} в {{ objstorage-name }} и активировать блокировку состояний:

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

1. Добавьте настройки провайдера и бэкенда в конфигурационный файл:

    
    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = ">= 0.13"

      backend "s3" {
        endpoints = {
          s3       = "https://{{ s3-storage-host }}"
          dynamodb = "<эндпоинт_Document_API_БД>"

        bucket            = "<имя_бакета>"
        region            = "{{ region-id }}"
        key               = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

        dynamodb_table = "<имя_таблицы>"

        skip_region_validation      = true
        skip_credentials_validation = true
        skip_requesting_account_id  = true # необходимая опция {{ TF }} для версии 1.6.1 и старше.
        skip_s3_checksum            = true # необходимая опция при описании бэкенда для {{ TF }} версии 1.6.3 и старше.
      }
    }

    provider "yandex" {
      zone = "<зона_доступности_по_умолчанию>"
    }
    ```



    Где:

   * `bucket` — имя бакета.
   * `dynamodb` — Document API базы данных, в формате `https://docapi.serverless.yandexcloud.net/{{ region-id }}/b1gia87mbaom********`:
   * `key` — ключ объекта в бакете: путь и имя к файлу состояния {{ TF }} в бакете.
   * `dynamodb_table` — имя таблицы.

    Подробнее о бэкенде для хранения состояний читайте на [сайте {{ TF }}](https://www.terraform.io/docs/backends/types/s3.html).

1. В папке с конфигурационным файлом выполните команду:

    ```bash
    terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
    ```

## Разверните конфигурацию {#deploy}

В этом примере будет создана [виртуальная машина](../../compute/concepts/vm.md) `terraform-vm`, которая будет подключена к [подсети](../../vpc/concepts/network.md#subnet) `subnet-1` в [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`. Подсеть будет принадлежать облачной [сети](../../vpc/concepts/network.md#network) `network-1`.

У ВМ будет: 2 ядра и 4 ГБ оперативной памяти и она автоматически получит [публичный](../../vpc/concepts/address.md#public-addresses) и [приватный IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24` в подсети `subnet-1`. На ВМ будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа по [SSH](../../glossary/ssh-keygen.md).
1. Сохраните следующую конфигурацию в отдельном файле `example-vm.tf` в папке с файлом конфигурации бэкенда:

   
   ```hcl
   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_disk" "boot-disk" {
     name     = "boot-disk"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform-vm"

     resources {
       cores  = 2
       memory = 4
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.network-1.id
     v4_cidr_blocks = ["192.168.10.0/24"]
   }

   output "internal_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.ip_address
   }

   output "external_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
   }

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```



   Где:
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Проверьте конфигурацию с помощью команды `terraform plan`.
1. Разверните конфигурацию с помощью команды `terraform apply`.

{% include [check-condition-step](../_tutorials_includes/check-condition-step.md) %}

## Проверьте блокировку состояния {#check-state-lock}

Попробуйте изменить инфраструктуру одновременно с другим пользователем. Если все работает, {{ TF }} вернет следующее сообщение после выполнения команды `terraform apply`:

```text
member Error: Error acquiring the state lock

member Error message: ConditionalCheckFailedException: Condition not satisfied
member Lock Info:
member   ID:        <...>
member   Path:      terraform-object-storage-tutorial/TF/cloud-storage.tfstate
member   Operation: OperationTypeApply
member   Who:       LD\user@i7293
member   Version:   1.4.2
member   Created:   <...>
member   Info:

member {{ TF }} acquires a state lock to protect the state from being written
member by multiple users at the same time. Please resolve the issue above and try
member again. For most commands, you can disable locking with the "-lock=false"
member flag, but this is not recommended.
```

## Как удалить созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите](../../ydb/operations/schema.md#drop-table) таблицу из БД.
1. [Удалите](../../ydb/operations/manage-databases.md#delete-db) БД `state-lock-db`.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.

## См. также {#see-also}

* [Начало работы с {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
