---
title: Как создать трейл для загрузки аудитных логов
description: Следуя данной инструкции, вы сможете создать трейл {{ at-full-name }} для регистрации и сохранения аудитных логов.
---

# Создание трейла для загрузки аудитных логов


Вы можете создать трейл, который будет загружать аудитные логи [уровня конфигурации](../concepts/format.md) и [уровня сервисов](../concepts/format-data-plane.md) в один из [объектов назначения](../concepts/trail.md#target):

* бакет [{{ objstorage-full-name }}](../../storage/index.yaml);
* лог-группу [{{ cloud-logging-full-name }}](../../logging/index.yaml);
* поток данных [{{ yds-full-name }}](../../data-streams/index.yaml).

При создании трейла через CLI, {{ TF }} или API в фильтрах событий уровня сервисов можно задать [условия по значениям полей](../concepts/trail.md#field-filters). Это позволяет уменьшить поток событий и объем хранимых логов.

## Перед началом работы {#before-you-begin}

Подготовьте [объект назначения](../concepts/trail.md#target) и сервисный аккаунт для трейла:

{% list tabs group=trail-target %}

- Бакет {{ objstorage-name }} {#bucket}

  1. [Создайте бакет](../../storage/operations/buckets/create.md) с ограниченным доступом, в который будут загружаться аудитные логи.
  1. (Опционально) Включите шифрование для бакета.

      [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у аккаунта, от имени которого вы собираетесь создавать ключ шифрования для бакета, есть [роль](../../kms/security/index.md#kms-editor) `kms.editor` на каталог.
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [storage.uploader](../../storage/security/index.md#storage-uploader) на [бакет](../../storage/concepts/bucket.md).
      * [kms.keys.encrypter](../../kms/security/index.md#kms-keys-encrypter) на [ключ шифрования](../../kms/concepts/key.md) для бакета.

          Эта роль необходима, только если для бакета было включено шифрование.

      {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

  1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- Лог-группа {{ cloud-logging-name }} {#logging}

  1. [Создайте лог-группу](../../logging/operations/create-group.md), в которую будут загружаться аудитные логи.
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [logging.writer](../../logging/security/index.md#logging-writer) на [лог-группу](../../logging/concepts/log-group.md).

      {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

  1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- Поток данных {{ yds-name }} {#data-streams}

  1. [Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream), в который будут загружаться аудитные логи.

      {% note tip %}

      Рекомендуем включить [автопартиционирование](../../data-streams/concepts/glossary.md#autopartitioning) на принимающем потоке данных.

      Часть событий может потеряться при перегрузке отдельных [сегментов](../../data-streams/concepts/glossary.md#shard) или всего [потока](../../data-streams/concepts/glossary.md#stream-concepts). Автопартиционирование автоматически добавляет сегменты и распределяет нагрузку, что помогает избежать потерь. Если автопартиционирование отключено, самостоятельно проверяйте и увеличивайте количество сегментов при необходимости.

      {% endnote %}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [yds.writer](../../data-streams/security/index.md#yds-writer) на [поток данных](../../data-streams/concepts/glossary.md#stream-concepts).

      {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

  1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

{% endlist %}

## Создать трейл {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** выберите один из объектов назначения и укажите его настройки:

      * **{{ ui-key.yacloud.audit-trails.label_objectStorage }}** — загружать аудитные логи в бакет {{ objstorage-name }}. Рекомендуется для долгосрочного хранения данных. Задайте настройки хранения логов:

          * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — бакет, который [был создан ранее](#before-you-begin).
          * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — [префикс](../concepts/format.md#log-file-name), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

              {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — ключ шифрования для бакета. Выбирать его необходимо, только если для бакета было включено шифрование.
      
      * **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}** — лог-группа, которая [была создана ранее](#before-you-begin). В нее будут загружаться аудитные логи. Рекомендуется для быстрого сбора и анализа логов.
      * **{{ ui-key.yacloud.audit-trails.label_dataStream }}** — поток данных, который [был создан ранее](#before-you-begin). В этот поток будут загружаться аудитные логи. Рекомендуется для потоковой передачи логов в другие сервисы или системы.

  1. {% include [control-plane-on-console](../../_includes/audit-trails/control-plane-on-console.md) %}
  1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

      Чтобы ограничить сбор событий по значениям полей, задайте [условия фильтрации](../concepts/trail.md#field-filters) через CLI, API или {{ TF }}.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите [созданный ранее](#before-you-begin) сервисный аккаунт, от имени которого будет работать трейл.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого трейла. Оно должно быть уникальным в рамках каталога.
  1. (Опционально) Укажите описание трейла.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды CLI для создания трейла:

  ```bash
  yc audit-trails trail create --help
  ```

  Для сбора [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) используйте YAML-спецификацию. Если нужны только события уровня конфигурации, параметры можно передать непосредственно в команде.

  {% cut "В YAML-спецификации" %}

  1. Создайте YAML-файл с конфигурацией трейла. В шаблоне логи загружаются в бакет:

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      За основу также можно взять [спецификацию существующего трейла](prepare-spec.md#spec-for-create).

      Параметры конфигурации:

      * `name` — имя трейла. Оно должно быть уникальным в рамках каталога.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором будет размещен трейл.
      * `destination` — настройки объекта назначения для аудитных логов.

          Укажите только один объект назначения: `object_storage`, `cloud_logging` или `data_stream`.

          * `object_storage` — загружать логи в [бакет](../../storage/concepts/bucket.md#naming) {{ objstorage-full-name }}:

              * `bucket_id` — [имя](../../storage/concepts/bucket.md#naming) созданного [ранее](#before-you-begin) бакета.

                  Чтобы посмотреть имена бакетов в каталоге по умолчанию, выполните команду:

                  ```bash
                  yc storage bucket list
                  ```
              
              * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

                  {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * `cloud_logging` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

              Замените блок `destination` в шаблоне:

              ```yaml
              destination:
                cloud_logging:
                  log_group_id: <идентификатор_лог_группы>
              ```

              В параметре `log_group_id` укажите идентификатор [созданной ранее](#before-you-begin) лог-группы. Идентификатор можно запросить со [списком лог-групп в каталоге](../../logging/operations/list.md).
          
          * `data_stream` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}:

              Замените блок `destination` в шаблоне:

              ```yaml
              destination:
                data_stream:
                  stream_name: <имя_потока_данных>
                  database_id: <идентификатор_базы_данных>
                  codec: RAW
              ```

              * `stream_name` — имя [созданного ранее](#before-you-begin) потока данных. Имя можно запросить со [списком потоков данных в каталоге](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id` — идентификатор базы данных {{ ydb-short-name }}, которая используется потоком данных {{ yds-name }}. Идентификатор можно запросить со [списком баз данных {{ ydb-short-name }} в каталоге](../../ydb/operations/manage-databases.md#list-db).
              * `codec` — метод сжатия событий при записи в поток данных {{ yds-name }}. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.
          
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) созданного [ранее](#before-you-begin) сервисного аккаунта.

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

  1. {% include [field-filter-cli](../../_includes/audit-trails/field-filter-cli.md) %}

  1. Выполните команду:

      ```bash
      yc audit-trails trail create --file <путь_к_файлу>
      ```

  {% endcut %}

  {% cut "В параметрах команды" %}

  Чтобы собирать события уровня конфигурации из каталога и загружать их в бакет, выполните команду:

  ```bash
  yc audit-trails trail create \
    --name <имя_трейла> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --destination-bucket <имя_бакета> \
    --filter-all-folder-id <идентификатор_каталога>
  ```

  Для другого объекта назначения замените `--destination-bucket` одним из вариантов:

  * Лог-группа:

      ```bash
      --destination-log-group-id <идентификатор_лог_группы>
      ```

  * Поток данных:

      ```bash
      --destination-yds-stream <имя_потока_данных> \
      --destination-yds-database-id <идентификатор_базы_данных>
      ```

  Параметры команды:

  * `--name` — имя создаваемого трейла.

  {% include [trail-cli-flag-desc](../../_includes/audit-trails/trail-cli-flag-desc.md) %}

  {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры трейла. В шаблоне логи загружаются в бакет:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

      Где:

      {% include [trail-create-tf-descs_part1](../../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs_logging](../../_includes/audit-trails/trail-create-tf-descs-logging.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      Подробнее о параметрах ресурса `yandex_audit_trails_trail` в [документации провайдера]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. {% include [field-filter-tf](../../_includes/audit-trails/field-filter-tf.md) %}

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc audit-trails trail get <имя_трейла>
     ```

- API {#api}

    1. [Аутентифицируйтесь](../api-ref/authentication.md) в API.
    1. Подготовьте параметры трейла: каталог, объект назначения, сервисный аккаунт и политику фильтрации с нужными сервисами и областями сбора.

        Чтобы взять за основу настройки существующего трейла, получите их методом REST API [get](../api-ref/Trail/get.md) или вызовом gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).

    1. {% include [field-filter-api](../../_includes/audit-trails/field-filter-api.md) %}
    1. Создайте трейл методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../api-ref/grpc/Trail/create.md).

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в выбранный объект назначения.

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}

## Примеры {#examples}

### Создание трейла с фильтрацией событий {#example-control-data-planes}

В примере трейл `sample-trail-all-planes` создается в каталоге `folder0***` и записывает логи в бакет `sample-logs-bucket` с помощью сервисного аккаунта `service0***`.

Фильтры определяют, какие события попадают в логи:

* События уровня конфигурации — из всех облаков организации `org1***`.
* События уровня сервисов:
  * [{{ mpg-name }}](../../managed-postgresql/) — из облака `cloud1***` и каталога `folder1***`: все события, кроме `CreateDatabase` и `UpdateDatabase`.
  * [{{ iam-name }}](../../iam/) — из каталога `folder2***`: только события `CreateIamToken`. Из них исключаются события, в которых одновременно тип учетных данных равен `iam.session`, а имя субъекта — `user@example.com`.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте YAML-файл `sample-trail-all-planes.yaml` с конфигурацией трейла:

      ```yaml
      name: sample-trail-all-planes
      folder_id: folder0***
      destination:
        object_storage:
          bucket_id: sample-logs-bucket
      service_account_id: service0***
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: org1***
              type: organization-manager.organization
        data_events_filters:
          - service: mdb.postgresql
            resource_scopes:
              - id: cloud1***
                type: resource-manager.cloud
              - id: folder1***
                type: resource-manager.folder
            excluded_events:
              event_types:
                - yandex.cloud.audit.mdb.postgresql.CreateDatabase
                - yandex.cloud.audit.mdb.postgresql.UpdateDatabase
          - service: iam
            resource_scopes:
              - id: folder2***
                type: resource-manager.folder
            included_events:
              event_types:
                - yandex.cloud.audit.iam.CreateIamToken
            exclude_rules:
              - conditions:
                  - field: $.details.credential.type
                    operator: IN
                    values:
                      - iam.session
                  - field: $.details.subject_name
                    operator: IN
                    values:
                      - user@example.com
      ```

  1. Выполните команду:

      ```bash
      yc audit-trails trail create --file sample-trail-all-planes.yaml
      ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле {{ TF }} параметры трейла:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name               = "sample-trail-all-planes"
        folder_id          = "folder0***"
        service_account_id = "service0***"

        storage_destination {
          bucket_name = "sample-logs-bucket"
        }

        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "org1***"
              resource_type = "organization-manager.organization"
            }
          }

          data_events_filter {
            service = "mdb.postgresql"
            excluded_events = [
              "yandex.cloud.audit.mdb.postgresql.CreateDatabase",
              "yandex.cloud.audit.mdb.postgresql.UpdateDatabase",
            ]

            resource_scope {
              resource_id   = "cloud1***"
              resource_type = "resource-manager.cloud"
            }

            resource_scope {
              resource_id   = "folder1***"
              resource_type = "resource-manager.folder"
            }
          }

          data_events_filter {
            service         = "iam"
            included_events = ["yandex.cloud.audit.iam.CreateIamToken"]

            resource_scope {
              resource_id   = "folder2***"
              resource_type = "resource-manager.folder"
            }

            exclude_rule {
              condition {
                field    = "$.details.credential.type"
                operator = "IN"
                values   = ["iam.session"]
              }

              condition {
                field    = "$.details.subject_name"
                operator = "IN"
                values   = ["user@example.com"]
              }
            }
          }
        }
      }
      ```

  1. Примените конфигурацию:

      ```bash
      terraform apply
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md).

  {% include [curl](../../_includes/curl.md) %}

  {% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и запишите его в переменную окружения:

      ```bash
      export IAM_TOKEN=<iam-токен>
      ```

  1. Подготовьте файл `body.json` с телом запроса:

      ```json
      {
        "folderId": "folder0***",
        "name": "sample-trail-all-planes",
        "destination": {
          "objectStorage": {
            "bucketId": "sample-logs-bucket"
          }
        },
        "serviceAccountId": "service0***",
        "filteringPolicy": {
          "managementEventsFilter": {
            "resourceScopes": [
              {
                "id": "org1***",
                "type": "organization-manager.organization"
              }
            ]
          },
          "dataEventsFilters": [
            {
              "service": "mdb.postgresql",
              "resourceScopes": [
                {
                  "id": "cloud1***",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "folder1***",
                  "type": "resource-manager.folder"
                }
              ],
              "excludedEvents": {
                "eventTypes": [
                  "yandex.cloud.audit.mdb.postgresql.CreateDatabase",
                  "yandex.cloud.audit.mdb.postgresql.UpdateDatabase"
                ]
              }
            },
            {
              "service": "iam",
              "resourceScopes": [
                {
                  "id": "folder2***",
                  "type": "resource-manager.folder"
                }
              ],
              "includedEvents": {
                "eventTypes": [
                  "yandex.cloud.audit.iam.CreateIamToken"
                ]
              },
              "excludeRules": [
                {
                  "conditions": [
                    {
                      "field": "$.details.credential.type",
                      "operator": "IN",
                      "values": ["iam.session"]
                    },
                    {
                      "field": "$.details.subject_name",
                      "operator": "IN",
                      "values": ["user@example.com"]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
      ```

  1. Выполните запрос:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "Content-Type: application/json" \
        --data "@body.json" \
        https://audittrails.api.cloud.yandex.net/audit-trails/v1/trails
      ```

{% endlist %}

### Фильтрация по значениям полей {#filter-examples}

Примеры подходят для создания и изменения трейла. Добавьте фрагмент в фильтр нужного сервиса: в CLI — в элемент списка `filtering_policy.data_events_filters`, в {{ TF }} — в блок `filtering_policy.data_events_filter`.

{% cut "Исключение событий по типу учетных данных и пользователю" %}

Фильтр для `iam` исключает события с типом учетных данных `iam.session` и именем субъекта `user@example.com`, например [CreateIamToken](../audit/iam/events-ref/CreateIamToken.md).

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  exclude_rules:
    - conditions:
        - field: $.details.credential.type
          operator: IN
          values:
            - iam.session
        - field: $.details.subject_name
          operator: IN
          values:
            - user@example.com
  ```

- {{ TF }} {#tf}

  ```hcl
  exclude_rule {
    condition {
      field    = "$.details.credential.type"
      operator = "IN"
      values   = ["iam.session"]
    }

    condition {
      field    = "$.details.subject_name"
      operator = "IN"
      values   = ["user@example.com"]
    }
  }
  ```

{% endlist %}

{% endcut %}

{% cut "Исключение событий по IP-адресу" %}

Фильтр для `mdb.mongodb` исключает события [GenericAuditEvent](../audit/mdb/mongodb/events-ref/GenericAuditEvent.md) с адресом `details.remote_address` из подсети `192.0.2.0/24`.

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  exclude_rules:
    - conditions:
        - field: $.event_type
          operator: IN
          values:
            - yandex.cloud.audit.mdb.mongodb.GenericAuditEvent
        - field: $.details.remote_address
          operator: IP_IN
          values:
            - 192.0.2.0/24
  ```

- {{ TF }} {#tf}

  ```hcl
  exclude_rule {
    condition {
      field    = "$.event_type"
      operator = "IN"
      values   = ["yandex.cloud.audit.mdb.mongodb.GenericAuditEvent"]
    }

    condition {
      field    = "$.details.remote_address"
      operator = "IP_IN"
      values   = ["192.0.2.0/24"]
    }
  }
  ```

{% endlist %}

{% endcut %}

{% cut "Исключение сетевых событий по адресам источника и назначения" %}

Фильтр для `network` исключает события [ExternalFlow](../audit/vpc/events-ref/ExternalFlow.md) с адресами источника и назначения из подсети `198.51.100.0/24`.

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  exclude_rules:
    - conditions:
        - field: $.event_type
          operator: IN
          values:
            - yandex.cloud.audit.network.flowlogs.ExternalFlow
        - field: $.details.dst_addr
          operator: IP_IN
          values:
            - 198.51.100.0/24
        - field: $.details.src_addr
          operator: IP_IN
          values:
            - 198.51.100.0/24
  ```

- {{ TF }} {#tf}

  ```hcl
  exclude_rule {
    condition {
      field    = "$.event_type"
      operator = "IN"
      values   = ["yandex.cloud.audit.network.flowlogs.ExternalFlow"]
    }

    condition {
      field    = "$.details.dst_addr"
      operator = "IP_IN"
      values   = ["198.51.100.0/24"]
    }

    condition {
      field    = "$.details.src_addr"
      operator = "IP_IN"
      values   = ["198.51.100.0/24"]
    }
  }
  ```

{% endlist %}

{% endcut %}

{% cut "Сбор событий чтения секретов {{ k8s }}" %}

Фильтр для `k8s` оставляет только события [ApiServerWatch](../audit/k8s/apiserver/events-ref/ApiServerWatch.md), [ApiServerGet](../audit/k8s/apiserver/events-ref/ApiServerGet.md) и [ApiServerList](../audit/k8s/apiserver/events-ref/ApiServerList.md) для ресурсов типа `secrets`.

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  include_rules:
    - conditions:
        - field: $.event_type
          operator: IN
          values:
            - yandex.cloud.audit.k8s.apiserver.ApiServerWatch
            - yandex.cloud.audit.k8s.apiserver.ApiServerGet
            - yandex.cloud.audit.k8s.apiserver.ApiServerList
        - field: $.details.native_api_server_event.objectRef.resource
          operator: IN
          values:
            - secrets
  ```

- {{ TF }} {#tf}

  ```hcl
  include_rule {
    condition {
      field    = "$.event_type"
      operator = "IN"
      values = [
        "yandex.cloud.audit.k8s.apiserver.ApiServerWatch",
        "yandex.cloud.audit.k8s.apiserver.ApiServerGet",
        "yandex.cloud.audit.k8s.apiserver.ApiServerList",
      ]
    }

    condition {
      field    = "$.details.native_api_server_event.objectRef.resource"
      operator = "IN"
      values   = ["secrets"]
    }
  }
  ```

{% endlist %}

Регистр ключа `objectRef` соответствует исходному событию {{ k8s }}.

{% endcut %}

## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске событий в аудитных логах](../tutorials/search-events-audit-logs/index.md).
