---
title: Как создать трейл для загрузки аудитных логов
description: Следуя данной инструкции, вы сможете создать трейл {{ at-full-name }} для регистрации и сохранения аудитных логов.
---

# Создание трейла для загрузки аудитных логов


Вы можете создать трейл, который будет загружать аудитные логи [уровня конфигурации](../concepts/format.md) и [уровня сервисов](../concepts/format-data-plane.md) в один из [объектов назначения](../concepts/trail.md#target):

* бакет [{{ objstorage-full-name }}](../../storage/);
* лог-группу [{{ cloud-logging-full-name }}](../../logging/);
* поток данных [{{ yds-full-name }}](../../data-streams/).

## Перед началом работы {#before-you-begin}

В зависимости от выбранного [объекта назначения](../concepts/trail.md#target) для логов, подготовьте необходимую инфраструктуру для создания трейла:

{% list tabs group=trail-target %}

- Бакет {{ objstorage-name }} {#bucket}

    1. [Создайте бакет](../../storage/operations/buckets/create.md) с ограниченным доступом, в который будут загружаться аудитные логи.

    1. (Опционально) Включите шифрование для бакета.

        [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у вашего аккаунта есть роль `kms.editor` на каталог, в котором будет создан ключ шифрования для бакета.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.

    1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

        * `storage.uploader` на бакет.
        * `kms.keys.encrypter` на ключ шифрования для бакета.

            Эта роль необходима, только если для бакета было включено шифрование.

        {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

    1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- Лог-группа {{ cloud-logging-name }} {#logging}

    1. [Создайте лог-группу](../../logging/operations/create-group.md), в которую будут загружаться аудитные логи.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.

    1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

        * `logging.writer` на лог-группу.

        {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

    1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- Поток данных {{ yds-name }} {#data-streams}

    1. [Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream), в который будут загружаться аудитные логи.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.

    1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

        * `yds.writer` на поток данных.

        {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

    1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

{% endlist %}

## Создать трейл {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
    1. Введите имя трейла. Оно должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание трейла.
    1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** выберите один из объектов назначения и укажите его настройки:

        * **{{ ui-key.yacloud.audit-trails.label_objectStorage }}** — загружать аудитные логи в бакет {{ objstorage-name }}:

            * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — имя бакета, который [был создан ранее](#before-you-begin).
            * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — [префикс](../concepts/format.md#log-file-name), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

                {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

            * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — ключ шифрования для бакета. Выбирать его необходимо, только если для бакета было включено шифрование.

        * **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}** — укажите имя лог-группы, которая [была создана ранее](#before-you-begin). В нее будут загружаться аудитные логи.

        * **{{ ui-key.yacloud.audit-trails.label_dataStream }}** — укажите имя потока данных, который [был создан ранее](#before-you-begin). В этот поток будут загружаться аудитные логи.

    1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите [созданный ранее](#before-you-begin) сервисный аккаунт, от имени которого будет работать трейл.

    1. Включите и настройте сбор событий с одного или двух уровней. Такие события попадут в аудитные логи.

        Чтобы настроить **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**:

        1. Выберите [область сбора логов](../concepts/trail.md) — `Организация`, `Облако` или `Каталог`. События, которые попадут в логи, будут собираться в указанной области.

            Права сервисного аккаунта, [созданного ранее](before-you-begin), должны позволять сбор логов из указанной области.

        1. В зависимости от выбранной области сбора логов, выберите конкретные облака или каталоги, с которых будут собираться события:

            * Для области сбора `Организация` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** одно или несколько облаков, с которых будут собираться события.

                Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех облаков в организации.

            * Для области сбора `Облако` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** один или несколько каталогов, с которых будут собираться события.

                Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех каталогов в облаке.

        Чтобы настроить **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**:

        1. Выберите один или несколько сервисов, с которых будут собираться события.

        1. Для каждого такого сервиса выберите [область сбора логов](../concepts/trail.md) — `Организация`, `Облако` или `Каталог`. События, которые попадут в логи, будут собираться в указанной области.

            Права сервисного аккаунта, [созданного ранее](before-you-begin), должны позволять сбор логов из указанной области.

        1. В зависимости от выбранной области сбора логов, выберите конкретные облака или каталоги, с которых будут собираться события:

            * Для области сбора `Организация` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** одно или несколько облаков, с которых будут собираться события.

                Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех облаков в организации.

            * Для области сбора `Облако` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** один или несколько каталогов, с которых будут собираться события.

                Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех каталогов в облаке.

        1. Для каждого такого сервиса выберите один из следующих фильтров по [событиям](../concepts/events-data-plane.md#dns):

            * `Получать все` — чтобы собирать все события сервиса.
            * `Выбранные` — чтобы собирать только выбранные события. Затем выберите события.
            * `Исключить` — чтобы собирать все события, кроме выбранных. Затем выберите события.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды [CLI](../../cli/) для создания трейла, чтобы получить подробную информацию о доступных аргументах:

  ```bash
  yc audit-trails trail create --help
  ```

  Трейл можно создать, указав его параметры одним из двух способов:

  {% cut "В YAML-спецификации:" %}

  Создайте YAML-спецификацию, содержащую параметры трейла, и укажите этот файл в команде для создания трейла.
  
  Этот способ упрощает работу с параметрами трейла и снижает вероятность ошибки. Кроме того, настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  1. Создайте YAML-файл с конфигурацией трейла:

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      Где:

      * `name` — имя трейла. Оно должно быть уникальным в рамках каталога.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором будет размещен трейл.
      * `destination` — настройки выбранного места назначения, куда будут загружаться аудитные логи.

          {% note warning %}

          Настройки мест назначения — взаимоисключающие. Использование одних настроек делает невозможным использование других.

          {% endnote %}

          * `object_storage` — загружать логи в [бакет](../../storage/concepts/bucket.md#naming) {{ objstorage-full-name }}:

              * `bucket_id` — [имя](../../storage/concepts/bucket.md#naming) созданного [ранее](#before-you-begin) бакета.

                  Имя бакета можно запросить со списком бакетов в каталоге (используется каталог по умолчанию):

                  ```bash
                  yc storage bucket list
                  ```

              * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

                  {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * `cloud_logging` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

              В параметре `log_group_id` укажите идентификатор [созданной ранее](#before-you-begin) лог-группы. Идентификатор можно запросить со [списком лог-групп в каталоге](../../logging/operations/list.md).
          * `data_stream` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}:

              * `stream_name` — имя [созданного ранее](#before-you-begin) потока данных. Имя можно запросить со [списком потоков данных в каталоге](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id` — идентификатор базы данных {{ ydb-short-name }}, которая используется потоком данных {{ yds-name }}. Идентификатор можно запросить со [списком баз данных {{ ydb-short-name }} в каталоге](../../ydb/operations/manage-databases.md#list-db).
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) созданного [ранее](#before-you-begin) сервисного аккаунта.

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

  1. Выполните команду:

      ```bash
      yc audit-trails trail create --file <путь_к_файлу>
      ```

  {% endcut %}

  {% cut "В аргументах команды:" %}

  Используйте этот способ, если конфигурация трейла простая и содержит небольшое количество параметров.

  {% note info %}

  Настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  {% endnote %}

  Выполните команду:

  ```bash
  yc audit-trails trail create \
    --name <имя_трейла> \
    --description <описание_трейла> \
    --labels <список_меток> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --destination-bucket <имя_бакета> \
    --destination-bucket-object-prefix <префикс_для_объектов> \
    --destination-log-group-id <идентификатор_лог_группы> \
    --destination-yds-stream <имя_потока_данных_YDS> \
    --destination-yds-database-id <идентификатор_базы_данных_YDS> \
    --filter-all-folder-id <идентификатор_каталога> \
    --filter-all-cloud-id <идентификатор_облака> \
    --filter-all-organisation-id <идентификатор_организации> \
    --filter-some-folder-ids <список_каталогов_в_облаке> \
    --filter-from-cloud-id <идентификатор_облака_с_выбранными_каталогами> \
    --filter-some-cloud-ids <список_облаков_в_организации> \
    --filter-from-organisation-id <идентификатор_организации_с_выбранными_облаками>
    ```

    Где:
    * `--name` — имя создаваемого трейла.

    {% include [trail-cli-flag-desc](../../_includes/audit-trails/trail-cli-flag-desc.md) %}

  {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры трейла, который будет собирать аудитные логи:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

      Где:

      {% include [trail-create-tf-descs_part1](../../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs_logging](../../_includes/audit-trails/trail-create-tf-descs-logging.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      Более подробную информацию о параметрах ресурса `yandex_audit_trails_trail` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc audit-trails trail get <имя_трейла>
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../api-ref/grpc/Trail/create.md).

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в выбранный объект назначения.

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}

## Примеры {#examples}

### Создание трейла с фильтрами событий уровня конфигурации и уровня сервисов {#example-control-data-planes}

Создайте трейл со следующими параметрами:

* Имя трейла — `sample-trail-all-planes`.
* Каталог, в котором будет размещен трейл — каталог с идентификатором `folder0***`.
* Объект назначения — бакет {{ objstorage-name }} с именем `sample-logs-bucket`.
* Сервисный аккаунт для трейла — аккаунт с идентификатором `service0***`.
* Настройки фильтра событий уровня конфигурации:

    В качестве области сбора логов выбрана организация с идентификатором `org1***`. Логи будут собираться из всех облаков, которые принадлежат этой организации.

* Настройки фильтров событий уровня сервиса:

    * Для сервиса [{{ mpg-name }}](../../managed-postgresql/) логи будут собираться из облака с идентификатором `cloud1***` и каталога с идентификатором `folder1***`.

        Будут собираться все [события сервиса](../concepts/events-data-plane.md#mpg), кроме следующих:

        * `yandex.cloud.audit.mdb.postgresql.CreateDatabase`,
        * `yandex.cloud.audit.mdb.postgresql.UpdateDatabase`.

    * Для сервиса [{{ objstorage-name }}](../../storage/) логи будут собираться из облаков с идентификаторами `cloud2***` и `cloud3***`.

        Будут собираться только следующие [события сервиса](../concepts/events-data-plane.md#objstorage):

        * `yandex.cloud.audit.storage.ObjectCreate`,
        * `yandex.cloud.audit.storage.ObjectUpdate`,
        * `yandex.cloud.audit.storage.ObjectDelete`.

    * Для сервиса [{{ compute-name }}](../../compute/) логи будут собираться из каталогов с идентификаторами `folder2***` и `folder3***`.

        Будут собираться все [события сервиса](../concepts/events-data-plane.md#compute).

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте YAML-файл `sample-trail-all-planes.yaml` с конфигурацией трейла.

      {% cut "sample-trail-all-planes.yaml" %}

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
          - service: storage
            resource_scopes:
              - id: cloud2***
                type: resource-manager.cloud
              - id: cloud3***
                type: resource-manager.cloud
            included_events:
              event_types:
                - yandex.cloud.audit.storage.ObjectCreate
                - yandex.cloud.audit.storage.ObjectUpdate
                - yandex.cloud.audit.storage.ObjectDelete
          - service: compute
            resource_scopes:
              - id: folder2***
                type: resource-manager.folder
              - id: folder3***
                type: resource-manager.folder
      ```

      {% endcut %}

  1. Выполните команду:

      ```bash
      yc audit-trails trail create --file sample-trail-all-planes.yaml
      ```

  Будет создан трейл с указанными параметрами.

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле {{ TF }} параметры создаваемого трейла:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name               = "sample-trail-all-planes"
        folder_id          = "folder0***"
        service_account_id = "service0***"

        storage_destination {
          bucket_name  = "sample-logs-bucket"
        }

        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "org1***"
              resource_type = "resource-manager.organization"
            }
          }  
          data_events_filter {
            service = "mdb.postgresql"
            excluded_events = ["yandex.cloud.audit.mdb.postgresql.CreateDatabase","yandex.cloud.audit.mdb.postgresql.UpdateDatabase"]
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
            service = "storage"
            resource_scope {
              resource_id   = "cloud2***"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "cloud3***"
              resource_type = "resource-manager.cloud"
            }
          }
          data_events_filter {
            service = "compute"
            resource_scope {
              resource_id   = "folder2***"
              resource_type = "resource-manager.folder"
            }
            resource_scope {
              resource_id   = "folder3***"
              resource_type = "resource-manager.folder"
            }
          }
        }
      }
     ```

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Будет создан трейл с указанными параметрами. Проверить появление трейла можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc audit-trails trail get sample-trail-all-planes
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md).

  {% include [curl](../../_includes/curl.md) %}

  {% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

  1. [Получите](../../iam/operations/index.md#authentication) IAM-токен, чтобы [аутентифицироваться](../api-ref/authentication.md) в API.

  1. Сохраните полученный IAM-токен в переменную, выполните в терминале:

      ```bash
      export IAM_TOKEN=<IAM-токен>
      ```

  1. Подготовьте файл `body.json` с телом запроса и описанием создаваемого трейла:

      ```json
      {
        "folderId": "folder0**",
        "name": "sample-trail-all-planes",
        "description": "sample-trail",
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
                "type": "resource-manager.organization"
              }
            ]
          },
          "dataEventsFilters": [
            {
              "service": "mdb.postgresql",
              "excludedEvents": {
                "eventTypes": [
                  "yandex.cloud.audit.mdb.postgresql.CreateDatabase"
                  ,"yandex.cloud.audit.mdb.postgresql.UpdateDatabase"
                ]
              },
              "resourceScopes": [
                {
                  "id": "cloud1***",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "folder1***",
                  "type": "resource-manager.folder"
                }
              ]
            },
            {
              "service": "storage",
              "resourceScopes": [
                {
                  "id": "cloud2**",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "cloud3**",
                  "type": "resource-manager.cloud"
                }
              ]
            },
            {
              "service": "compute",
              "resourceScopes": [
                {
                  "id": "folder2**",
                  "type": "resource-manager.folder"
                },
                {
                  "id": "folder3**",
                  "type": "resource-manager.folder"
                }
              ]
            }
          ]
        }
      }
      ```

  1. Выполните в терминале запрос:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "@<файл_с_телом_запроса>" \
        https://audittrails.api.cloud.yandex.net/audit-trails/v1/trails
      ```

      Где:
      * `<файл_с_телом_запроса>` — путь к созданному ранее файлу с телом запроса `body.json`.

      Результат:

      ```json
      {
      "done": true,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.audittrails.v1.CreateTrailMetadata",
        "trailId": "cnpvprd5pa66********"
      },
      "id": "cnp9qb9g8ldb********",
      "description": "operation_create",
      "createdAt": "2025-02-20T07:06:18.547321903Z",
      "createdBy": "ajevfb0tjfts********",
      "modifiedAt": "2025-02-20T07:06:18.547321903Z"
      }
      ```

{% endlist %}


## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске событий в аудитных логах](../tutorials/search-events-audit-logs/index.md).
