[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > [Пошаговые инструкции](index.md) > Управление трейлом

# Управление трейлом


Вы можете изменять [объект назначения](../concepts/trail.md#target), [уровни](../concepts/control-plane-vs-data-plane.md) собираемых событий, [области сбора](../concepts/trail.md#collecting-area) аудитных логов и [другие настройки](../concepts/trail.md#trail-settings) трейла, а также [удалять](#delete-trail) его.

## Изменить трейл {#update-trail}

В фильтры событий уровня сервисов можно добавить [условия по значениям полей](../concepts/trail.md#field-filters) через CLI, Terraform или API. При изменении политики фильтрации передавайте ее целиком, сохраняя остальные нужные фильтры.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить трейл:

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. [Перейдите](https://console.yandex.cloud/link/audit-trails) в сервис **Audit Trails**.
  1. В строке с нужным трейлом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Измените параметры трейла. Список настроек трейла, которые можно изменить, приведен в разделе [Настройки трейла](../concepts/trail.md#trail-settings).
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Посмотрите описание команды CLI для изменения трейла:

  ```bash
  yc audit-trails trail update --help
  ```

  Трейл можно изменить, указав его параметры одним из двух способов:

  {% cut "В YAML-спецификации" %}

  Создайте YAML-спецификацию, содержащую обновленные параметры трейла, и укажите этот файл в команде для изменения трейла.
  
  Этот способ упрощает работу с параметрами трейла и снижает вероятность ошибки. Кроме того, настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  1. [Подготовьте YAML-спецификацию](prepare-spec.md) на основе текущих настроек трейла и измените нужные параметры.
  1. (Опционально) Дополните фильтр [условиями по значениям полей](../concepts/trail.md#field-filters) для нужного сервиса. Для этого в элементе списка `filtering_policy.data_events_filters` задайте правила `include_rules`, `exclude_rules`. Примеры настройки фильтрации приведены в инструкции [Создание трейла](create-trail.md#filter-examples).
  1. Чтобы изменить трейл, выполните команду:

      ```bash
      yc audit-trails trail update --file <путь_к_файлу>
      ```

  {% endcut %}

  {% cut "В параметрах команды" %}

  Используйте этот способ, если конфигурация трейла простая и содержит небольшое количество параметров.
  
  {% note info %}

  Настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  {% endnote %}

  Укажите в команде только те параметры, которые хотите изменить. Например, чтобы изменить имя трейла, выполните команду:

  ```bash
  yc audit-trails trail update \
    --name <имя_трейла> \
    --new-name <новое_имя_трейла>
  ```

  Параметры команды:

  * `--name` — имя трейла, который требуется изменить. Вместо имени можно передать идентификатор трейла в параметре `--id`.
  * `--new-name` — новое имя трейла. Имя должно быть уникальным в рамках каталога. Необязательный параметр.

  * `--description` — описание трейла. Необязательный параметр.
  * `--labels` — список [меток](../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
  * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.
  * `--destination-bucket` — [имя](../../storage/concepts/bucket.md#naming) бакета Yandex Object Storage, в который будут загружаться аудитные логи.
  
      С этим параметром нельзя использовать параметры `--destination-log-group-id` и `--destination-yds-stream`.
  * `--destination-bucket-object-prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
  
      {% note info %}
      
      Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
      
      {% endnote %}
  
  * `--destination-log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md) Yandex Cloud Logging, в которую будут загружаться аудитные логи.
  
      С этим параметром нельзя использовать параметры `--destination-bucket` и `--destination-yds-stream`.
  * `--destination-yds-stream` — имя [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams, в который будут загружаться аудитные логи.
  
      С этим параметром нельзя использовать параметры `--destination-bucket` и `--destination-log-group-id`.
  * `--destination-yds-database-id` — идентификатор базы данных YDB, которая используется потоком данных Data Streams.
  * `--destination-yds-codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.
  * `--filter-all-folder-id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
  * `--filter-all-cloud-id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
  * `--filter-all-organisation-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, для всех ресурсов которой будут регистрироваться события уровня конфигурации.
  * `--filter-some-folder-ids` — список идентификаторов каталогов, для всех ресурсов которых будут регистрироваться события уровня конфигурации в облаке, заданном в поле `--filter-from-cloud-id`.
  
      Параметр используется только в паре с параметром `--filter-from-cloud-id`.
  * `--filter-from-cloud-id` — идентификатор облака, в котором находятся каталоги, заданные в параметре `--filter-some-folder-ids`.
  
      Параметр используется только в паре с параметром `--filter-some-folder-ids`.
  * `--filter-some-cloud-ids` — список идентификаторов облаков, для всех ресурсов которых будут регистрироваться события уровня конфигурации в организации, заданной в поле `--filter-from-organisation-id`.
  
      Параметр используется только в паре с параметром `--filter-from-organisation-id`.
  * `--filter-from-organisation-id` — идентификатор организации, в которой находятся облака, заданные в параметре `--filter-some-cloud-ids`.
  
      Параметр используется только в паре с параметром `--filter-some-cloud-ids`.

  {% endcut %}

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Чтобы изменить трейл, созданный с помощью Terraform, откройте файл конфигурации Terraform и измените фрагмент с описанием трейла:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name        = "<имя_трейла>"
        folder_id   = "<идентификатор_каталога>"
        description = "<описание_трейла>"
        labels = {
          key = "value"
        }
        service_account_id = "<идентификатор_сервисного_аккаунта>"
      
        storage_destination {
          bucket_name   = "<имя_бакета>"
          object_prefix = "<префикс>"
        }
      
        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "<идентификатор_организации_облака_или_каталога>"
              resource_type = "<тип>"
            }
          }
      
          data_events_filter {
            service         = "<имя_сервиса>"
            included_events = ["<полное_имя_события>"]
      
            resource_scope {
              resource_id   = "<идентификатор_организации_облака_или_каталога>"
              resource_type = "<тип>"
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя создаваемого трейла. Требования к формату имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.
      
      * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создается трейл.
      * `description` — описание трейла. Необязательный параметр.
      * `labels` — список [меток](../../resource-manager/concepts/labels.md) в формате `ключ=значение`. Необязательный параметр.
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, от имени которого трейл собирает и загружает аудитные логи.
      
          В зависимости от [области сбора](../concepts/trail.md#collecting-area) аудитных логов [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../../iam/concepts/access-control/roles.md) `audit-trails.viewer` на организацию, облако или каталог, в которых трейл будет собирать аудитные логи.

      Укажите только один объект назначения: `storage_destination`, `logging_destination` или `data_stream_destination`.
      
      * `logging_destination` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) Yandex Cloud Logging.
      
          Замените блок `storage_destination` в шаблоне:
      
          ```hcl
          logging_destination {
            log_group_id = "<идентификатор_лог_группы>"
          }
          ```
      
          * `log_group_id` — [идентификатор лог-группы](../../logging/operations/get-group.md), в которую трейл будет сохранять аудитные логи.
      * `storage_destination` — загружать логи в [бакет](../../storage/concepts/bucket.md) Yandex Object Storage:
      
          * `bucket_name` — имя бакета, куда трейл будет сохранять аудитные логи.
          * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
      
              {% note info %}
              
              Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
              
              {% endnote %}
      
      * `data_stream_destination` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams:
      
          Замените блок `storage_destination` в шаблоне:
      
          ```hcl
          data_stream_destination {
            database_id = "<идентификатор_базы_данных>"
            stream_name = "<имя_потока_данных>"
            codec       = "RAW"
          }
          ```
      
          * `stream_name` — имя потока данных, в который трейл будет сохранять аудитные логи.
          * `database_id` — идентификатор базы данных Yandex Managed Service for YDB, которая используется потоком данных Data Streams.
          * `codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.

      * `filtering_policy` — настройки политики фильтрации, которая определяет, какие события будут собираться и попадут в аудитные логи. Политика состоит из набора фильтров, которые относятся к разным уровням событий. Содержит блоки `management_events_filter` и `data_events_filter`.
      
          * `management_events_filter` — фильтр событий уровня конфигурации.
      
              * `resource_scope` — [область сбора логов](../concepts/trail.md#collecting-area). Можно указать несколько блоков `resource_scope` для областей, которые принадлежат одной организации. Например, собирать логи из одного облака целиком, а из другого — только из определенных каталогов. Права сервисного аккаунта должны позволять сбор логов из указанных областей.
      
                  * `resource_id` — идентификатор области сбора: [организации](../../organization/operations/organization-get-id.md), [облака](../../resource-manager/operations/cloud/get-id.md) или [каталога](../../resource-manager/operations/folder/get-id.md).
                  * `resource_type` — тип области согласно указанному идентификатору:
      
                      * `organization-manager.organization` — [организация](../../organization/concepts/organization.md);
                      * `resource-manager.cloud` — [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud);
                      * `resource-manager.folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
          * `data_events_filter` — фильтр событий уровня сервисов. Можно настроить несколько фильтров такого типа — по одному для каждого сервиса. Фильтр для одного сервиса имеет следующую структуру:
      
              * `service` — имя сервиса, в котором трейл будет обрабатывать события. Его можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md).
              * `resource_scope` — места, откуда собирать события уровня сервисов. Этот блок настраивается аналогично фильтру событий уровня конфигурации.
              * `included_events` — полные имена событий для сбора. Вместо него можно указать `excluded_events` — полные имена событий для исключения. Эти параметры взаимоисключающие. Если оба не заданы, отбор не ограничивается именами событий.
      
                  Используйте полное имя из поля `event_type` аудитного лога. Например, событию `CreateIamToken` из [справочника](../concepts/events-data-plane.md) соответствует `yandex.cloud.audit.iam.CreateIamToken`.
              * `include_rule` и `exclude_rule` — необязательные [правила с условиями по значениям полей](../concepts/trail.md#field-filters). Действуют вместе с выбором событий по именам.

      Подробнее о параметрах ресурса `yandex_audit_trails_trail` в [документации провайдера](../../terraform/resources/audit_trails_trail.md).

  1. (Опционально) Дополните фильтр [условиями по значениям полей](../concepts/trail.md#field-filters) для нужного сервиса. Для этого в блоке `filtering_policy.data_events_filter` задайте правила `include_rule`, `exclude_rule`. Используйте провайдер Yandex Cloud версии 0.225.0 или выше. Примеры настройки фильтрации приведены в инструкции [Создание трейла](create-trail.md#filter-examples).

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

      Проверьте настройки трейла в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc audit-trails trail get <имя_трейла>
     ```

- API {#api}

    1. [Аутентифицируйтесь](../api-ref/authentication.md) в API и получите настройки трейла методом REST API [get](../api-ref/Trail/get.md) или вызовом gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).
    1. Измените нужные параметры трейла.
    1. (Опционально) Дополните фильтр [условиями по значениям полей](../concepts/trail.md#field-filters) для нужного сервиса. Для этого в запросе REST API в элементе списка `filteringPolicy.dataEventsFilters` задайте правила `includeRules`, `excludeRules`. В gRPC API используйте `filtering_policy.data_events_filters`, `include_rules` и `exclude_rules`. Пример настройки фильтрации приведен в инструкции [Создание трейла](create-trail.md#example-control-data-planes).
    1. Обновите трейл методом REST API [update](../api-ref/Trail/update.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Update](../api-ref/grpc/Trail/update.md). Передайте идентификатор трейла, обновленные параметры и маску изменений.

        Если меняете политику фильтрации, включите `filteringPolicy` в `updateMask` для REST API или `filtering_policy` в `update_mask.paths` для gRPC API.

{% endlist %}

Примеры фильтров из [инструкции по созданию трейла](create-trail.md#filter-examples) подходят и для изменения трейла.

## Удалить трейл {#delete-trail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить трейл:

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. [Перейдите](https://console.yandex.cloud/link/audit-trails) в сервис **Audit Trails**.
  1. В строке с нужным трейлом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Чтобы удалить трейл, выполните команду:

  ```bash
  yc audit-trails trail delete <имя_или_идентификатор_трейла>
  ```

  Чтобы узнать имена и идентификаторы доступных трейлов, воспользуйтесь [инструкцией](get-list.md).

- Terraform {#tf}

  Чтобы удалить трейл, созданный с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите секцию с описанием трейла.

      Пример описания трейла в конфигурации Terraform:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name        = "<имя_трейла>"
        folder_id   = "<идентификатор_каталога>"
        description = "<описание_трейла>"
        labels = {
          key = "value"
        }
        service_account_id = "<идентификатор_сервисного_аккаунта>"
      
        storage_destination {
          bucket_name   = "<имя_бакета>"
          object_prefix = "<префикс>"
        }
      
        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "<идентификатор_организации_облака_или_каталога>"
              resource_type = "<тип>"
            }
          }
      
          data_events_filter {
            service         = "<имя_сервиса>"
            included_events = ["<полное_имя_события>"]
      
            resource_scope {
              resource_id   = "<идентификатор_организации_облака_или_каталога>"
              resource_type = "<тип>"
            }
          }
        }
      }
      ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.
  1. Проверьте конфигурацию командой:

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
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
  1. Чтобы убедиться в том, что трейл был удален, воспользуйтесь [инструкцией](get-list.md).

- API {#api}

  Чтобы удалить трейл, воспользуйтесь методом REST API [delete](../api-ref/Trail/delete.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Delete](../api-ref/grpc/Trail/delete.md).

{% endlist %}