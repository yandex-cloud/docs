# Загрузка аудитных логов в MaxPatrol SIEM с помощью Terraform


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) позволяет читать [аудитные логи](../../../../audit-trails/concepts/events.md) Yandex Cloud из потока данных [Yandex Data Streams](../../../../data-streams/index.md). Для полного прохождения руководства у вас должен быть доступ к экземпляру MaxPatrol SIEM.

Чтобы настроить экспорт аудитных логов с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните инфраструктуру, необходимую для загрузки аудитных логов в MaxPatrol SIEM](#deploy).
1. [Настройте в MaxPatrol SIEM задачу по сбору данных из потока Data Streams](#configure-maxpatrol).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../../billing/quickstart/index.md) и [привяжите](../../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:
* использование потока данных ([тарифы Data Streams](../../../../data-streams/pricing.md)).
* использование Yandex Managed Service for YDB в бессерверном режиме ([тарифы Managed Service for YDB](../../../../ydb/pricing/serverless.md)).

## Разверните инфраструктуру, необходимую для загрузки аудитных логов в MaxPatrol SIEM {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-export-audit-logs-maxpatrol
         ```

      1. Перейдите в папку с репозиторием. В ней должны появиться следующие файлы:
          * `audit-trails-maxpatrol-export.tf` — файл конфигурации создаваемой инфраструктуры.
          * `audit-trails-maxpatrol-export.auto.tfvars` — файл со значениями пользовательских переменных.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов и в этой папке:

          1. Создайте конфигурационный файл `audit-trails-maxpatrol-export.tf`:

              {% cut "**audit-trails-maxpatrol-export.tf**" %}

              ```hcl
              # Объявление переменных
              
              variable "folder_id" {
                type = string
              }
              
              variable "organization_id" {
                type = string
              }
              
              locals {
                sa_name        = "maxpatrol-sa"
                sa_reader_name = "maxpatrol-reader-sa"
                db_name        = "maxpatrol-db"
                yds_name       = "maxpatrol-stream"
                trail_name     = "maxpatrol-trail"
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
              
              # Создание сервисных аккаунтов
              
              resource "yandex_iam_service_account" "maxpatrol-sa" {
                name = local.sa_name
              }
              
              resource "yandex_iam_service_account" "maxpatrol-reader-sa" {
                name = local.sa_reader_name
              }
              
              # Назначение ролей сервисным аккаунтам
              
              resource "yandex_resourcemanager_folder_iam_member" "yds-writer" {
                folder_id = var.folder_id
                role      = "yds.writer"
                member    = "serviceAccount:${yandex_iam_service_account.maxpatrol-sa.id}"
              }
              
              resource "yandex_resourcemanager_folder_iam_member" "yds-viewer" {
                folder_id = var.folder_id
                role      = "yds.viewer"
                member    = "serviceAccount:${yandex_iam_service_account.maxpatrol-reader-sa.id}"
              }
              
              resource "yandex_organizationmanager_organization_iam_binding" "audit-trails-viewer" {
                organization_id   = var.organization_id
                role              = "audit-trails.viewer"
                members = [
                  "serviceAccount:${yandex_iam_service_account.maxpatrol-sa.id}",
                ]
              }
              
              # Создание статического ключа доступа для сервисного аккаунта
              
              resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
                service_account_id = yandex_iam_service_account.maxpatrol-reader-sa.id
              }
              
              # Создание бессерверной базы данных YDB
              
              resource "yandex_ydb_database_serverless" "maxpatrol-db" {
                name        = local.db_name
                folder_id   = var.folder_id
                sleep_after = 90
              }
              
              # Создание топика YDB — потока данных Data Streams
              
              resource "yandex_ydb_topic" "data-streams" {
                database_endpoint = yandex_ydb_database_serverless.maxpatrol-db.ydb_full_endpoint
                name              = local.yds_name
              }
              
              # Ожидание завершения создания топика перед запуском создания трейла
              
              resource "time_sleep" "wait-for-topic" {
                depends_on      = [yandex_ydb_topic.data-streams]
                create_duration = "20s"
              }
              
              # Создание трейла
              
              resource "yandex_audit_trails_trail" "maxpatrol-trail" {
                depends_on = [time_sleep.wait-for-topic]
                name                = local.trail_name
                folder_id           = var.folder_id
                service_account_id  = yandex_iam_service_account.maxpatrol-sa.id
              
                data_stream_destination {
                  database_id = yandex_ydb_database_serverless.maxpatrol-db.id
                  stream_name = local.yds_name
                }
              
                filtering_policy {
                  management_events_filter {
                    resource_scope {
                      resource_id   = var.organization_id
                      resource_type = "organization-manager.organization"
                    }
                  }
                }
              }
              
              output "static-access-key" {
                sensitive = true
                value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
              }
              
              output "static-secret-key" {
                sensitive = true
                value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
              }
              
              output "database-id" {
                sensitive = true
                value = yandex_ydb_database_serverless.maxpatrol-db.id
              }
              ```

              {% endcut %}

          1. Создайте файл с пользовательскими данными `audit-trails-maxpatrol-export.auto.tfvars`:

              **audit-trails-maxpatrol-export.auto.tfvars**

              ```hcl
              folder_id       = "<идентификатор_каталога>"
              organization_id = "<идентификатор_организации>"
              ```

    {% endlist %}

    Более подробную информацию о параметрах используемых в Terraform ресурсов см. в документации провайдера:

    * [Сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../../terraform/resources/iam_service_account.md).
    * [Роль](../../../../iam/concepts/access-control/roles.md), назначенная сервисному аккаунту на каталог — [yandex_resourcemanager_folder_iam_member](../../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * Роль, назначенная сервисному аккаунту на организацию — [yandex_organizationmanager_organization_iam_binding](../../../../terraform/resources/organizationmanager_organization_iam_binding.md).
    * [Статический ключ доступа](../../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key](../../../../terraform/resources/iam_service_account_static_access_key.md).
    * [Бессерверная база данных YDB](../../../../ydb/concepts/serverless-and-dedicated.md#serverless) — [yandex_ydb_database_serverless](../../../../terraform/resources/ydb_database_serverless.md).
    * [Поток данных Yandex Data Streams](../../../../data-streams/concepts/glossary.md#stream-concepts) — [yandex_ydb_topic](../../../../terraform/resources/ydb_topic.md).
    * [Трейл](../../../../audit-trails/concepts/trail.md) — [yandex_audit_trails_trail](../../../../terraform/resources/audit_trails_trail.md).

1. В файле `audit-trails-maxpatrol-export.auto.tfvars` задайте значения пользовательских переменных:
    * `folder_id` — [идентификатор каталога](../../../../resource-manager/operations/folder/get-id.md).
    * `organization_id` — [идентификатор организации](../../../../organization/operations/organization-get-id.md), в которой создается трейл и где будут собираться аудитные логи.

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

    В результате в выбранном каталоге будет создана и настроена вся необходимая инфраструктура.

1. Получите идентификатор и секретный ключ статического ключа доступа, а также идентификатор созданной базы данных — они понадобятся позднее при настройке MaxPatrol SIEM. Для этого выполните команды:

    ```bash
    echo "Static access key: $(terraform output static-access-key)"
    echo "Secret key: $(terraform output static-secret-key)"
    echo "YDB database ID: $(terraform output database-id)"
    ```

    Результат:

    ```text
    Static access key: "YCAJEnmnfsV8GpAMk********"
    Secret key: "YCMVxx-n0t8Y6s48zJDdKw9lWMB1iGU-********"
    YDB database ID: "etnvs692elpn********"
    ```

## Настройте MaxPatrol SIEM {#configure-maxpatrol}

### Создайте учетные записи {#static-key-account}

Учетные записи можно использовать как хранилища секретов. Создайте учетные записи `static-key-id` и `static-key-private`, чтобы сохранить в них полученные ранее идентификатор и секретный ключ статического ключа доступа, созданного для сервисного аккаунта `maxpatrol-reader-sa`:

1. Войдите в веб-интерфейс MaxPatrol SIEM.
1. В разделе **Сбор данных** нажмите **Учетные записи**.
1. Нажмите **Добавить учетную запись** → **Пароль** и укажите параметры:
    * **Название** — `static-key-id`;
    * **Пароль** — идентификатор статического ключа;
    * **Подтверждение пароля** — повторите идентификатор статического ключа.
1. Нажмите **Сохранить**.

Аналогично создайте учетную запись `static-key-private`, содержащую секретный ключ.


### Создайте задачу на сбор данных {#create-task}

Создайте и запустите задачу на сбор данных с профилем Yandex Data Streams:
1. Войдите в веб-интерфейс MaxPatrol SIEM.
1. В разделе **Сбор данных** нажмите **Задачи**.
1. На странице **Задачи по сбору данных**:
    1. На панели инструментов нажмите **Создать задачу**.
    1. Нажмите **Сбор данных**.
1. На странице **Создание задачи на сбор данных** укажите параметры:
    1. **Название** — `YDS-logs-task`.
    1. **Профиль** — `Yandex Data Streams`.
    1. В иерархическом списке выберите **Запуск сценария**.
    1. В блоке **Подключение** укажите:
        * **Учетная запись** — `static-key-id`;
        * **Учетная запись для повышения привилегий** — `static-key-private`.
    1. **Параметры запуска сценария**:
        * **database** — `<идентификатор_БД_maxpatrol-db>`;
        * **folder** — `<идентификатор_облака_для_каталога_example-folder>`;
        * **region_name** — `ru-central1`;
        * **stream_name** — `maxpatrol-stream`.
    1. На панели **Цели сбора данных**:
        1. Выберите вкладку **Включить**.
        1. В поле **Сетевые адреса** укажите `yandex-cloud`.
    1. Нажмите **Сохранить и запустить**.

Чтобы просмотреть логи, перейдите на страницу просмотра событий:
1. Перейдите на страницу **Задачи по сбору данных**.
1. Нажмите на задачу `YDS-logs-task`.
1. Нажмите **Собранные события** → **Перейти**.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `audit-trails-maxpatrol-export.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Загрузка аудитных логов в MaxPatrol SIEM с помощью консоли управления или Yandex Cloud CLI](console.md)