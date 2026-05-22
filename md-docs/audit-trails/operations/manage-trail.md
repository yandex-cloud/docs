# Управление трейлом


Вы можете изменять [объект назначения](../concepts/trail.md#target), [типы](../concepts/control-plane-vs-data-plane.md) собираемых событий, [области сбора](../concepts/trail.md#collecting-area) аудитных логов и [другие настройки](../concepts/trail.md#trail-settings) трейла, а также [удалять](#delete-trail) его.

## Изменить трейл {#update-trail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить трейл:

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Audit Trails**.
  1. В строке с нужным трейлом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Измените параметры трейла. Список настроек трейла, которые можно изменить, см. в разделе [Настройки трейла](../concepts/trail.md#trail-settings).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Посмотрите описание команды [CLI](../../cli/index.md) для изменения трейла, чтобы получить подробную информацию о доступных аргументах:

  ```bash
  yc audit-trails trail update --help
  ```

  Трейл можно изменить, указав его параметры одним из двух способов:

  {% cut "В YAML-спецификации:" %}

  Создайте YAML-спецификацию, содержащую обновленные параметры трейла, и укажите этот файл в команде для создания трейла.
  
  Этот способ упрощает работу с параметрами трейла и снижает вероятность ошибки. Кроме того, настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  1. [Создайте YAML-спецификацию](prepare-spec.md#spec-for-update) с обновленной конфигурацией трейла.
  1. Чтобы изменить трейл, выполните команду:

      ```bash
      yc audit-trails trail update --file <путь_к_файлу>
      ```

  {% endcut %}

  {% cut "В аргументах команды:" %}

  Используйте этот способ, если конфигурация трейла простая и содержит небольшое количество параметров.
  
  {% note info %}

  Настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  {% endnote %}

  Чтобы изменить трейл, выполните команду:

  ```bash
  yc audit-trails trail update \
    --name <имя_трейла> \
    --new-name <новое_имя_трейла> \
    --description <описание_трейла> \
    --labels <список_меток> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --destination-bucket <имя_бакета> \
    --destination-bucket-object-prefix <префикс_для_объектов> \
    --destination-log-group-id <идентификатор_лог_группы> \
    --destination-yds-stream <имя_потока_данных_YDS> \
    --destination-yds-database-id <идентификатор_базы_данных_YDS> \
    --destination-yds-codec <метод_сжатия_событий> \
    --filter-all-folder-id <идентификатор_каталога> \
    --filter-all-cloud-id <идентификатор_облака> \
    --filter-all-organisation-id <идентификатор_организации> \
    --filter-some-folder-ids <список_каталогов_в_облаке> \
    --filter-from-cloud-id <идентификатор_облака_с_выбранными_каталогами> \
    --filter-some-cloud-ids <список_облаков_в_организации> \
    --filter-from-organisation-id <идентификатор_организации_с_выбранными_облаками>
    ```

    Где:
    * `--name` — имя трейла, который требуется изменить. Вместо имени можно передать идентификатор трейла в параметре `--id`.
    * `--new-name` — новое имя трейла. Имя должно быть уникальным в рамках каталога. Необязательный параметр.

    * `--description` — описание трейла. Необязательный параметр.
    * `--labels` — список [меток](../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
    * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.
    * `--destination-bucket` — [имя](../../storage/concepts/bucket.md#naming) бакета Yandex Object Storage, в который будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-log-group-id`, `--destination-yds-stream` и `--destination-eventrouter-connector-id`.
    * `--destination-bucket-object-prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
    
        {% note info %}
        
        Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
        
        {% endnote %}
    
    * `--destination-log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md) Yandex Cloud Logging, в которую будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-bucket`, `--destination-yds-stream` и `--destination-eventrouter-connector-id`.
    * `--destination-yds-stream` — имя [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams, в который будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-bucket`, `--destination-log-group-id` и `--destination-eventrouter-connector-id`.
    * `--destination-yds-database-id` — идентификатор базы данных YDB, которая используется потоком данных Data Streams.
    * `--destination-yds-codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.
    * `--destination-eventrouter-connector-id` — идентификатор [коннектора](../../serverless-integrations/concepts/eventrouter/connector.md) шины EventRouter с типом источника `Audit Trails`, в которую будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-bucket`, `--destination-log-group-id` и `--destination-yds-stream`.
    * `--filter-all-folder-id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
    * `--filter-all-cloud-id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
    * `--filter-all-organisation-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, для всех ресурсов которой будут регистрироваться события уровня конфигурации.
    * `--filter-some-folder-ids` — список идентификаторов каталогов, для всех ресурсов которых будут регистрироваться события уровня конфигурации в облаке, заданном в поле `--filter-from-cloud-id`.
    
        Параметр используется только в паре с параметром `--filter-from-cloud-id`.
    * `--filter-from-cloud-id` — идентификатор облака, в котором находятся каталоги, заданные в параметре `--filter-some-folder-ids`.
    
        Параметр используется только в паре с параметром `--filter-some-folder-ids`.
    * `--filter-some-cloud-ids` — список идентификаторов облаков, для всех ресурсов которых будут регистрироваться события уровня конфигурации в организации, заданной в поле `--filter-from-organisation-id`.
    
        Параметр используется только в паре с параметром `--filter-from-organisation-id`.
    * `--filter-from-organisation-id` — идентификатор организации, в которой находятся облака, заданные в параметре `--filter-some-folder-ids`.
    
        Параметр используется только в паре с параметром `--filter-some-cloud-ids`.

  {% endcut %}

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
      
      
        # Должно быть указано только одно место назначения:
        # storage_destination , logging_destination, data_stream_destination
        # Настройки для всех мест назначения приведены для иллюстрации
      
        logging_destination {
          log_group_id = "<идентификатор_лог-группы>"
        }
        storage_destination {
          bucket_name   = "<идентификатор_бакета>"
          object_prefix = "<префикс>"
        }
        data_stream_destination {
          database_id = "<идентификатор_базы_данных_YDS>"
          stream_name = "<имя_потока_данных_YDS>"
          codec       = "<метод_сжатия_событий>"
        }
      
        # Настройки политики фильтрации
      
        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "<идентификатор_организации>"
              resource_type = "organization-manager.organization"
            }
          }  
          data_events_filter {
            service = "<сервис>"
            included_events = ["<тип_событий_сервиса>","<тип_событий_сервиса_2>"]
            resource_scope {
              resource_id   = "<идентификатор_облака>"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "<идентификатор_каталога>"
              resource_type = "resource-manager.folder"
            }
          }
          data_events_filter {
            service = "<сервис_2>"
            resource_scope {
              resource_id   = "<идентификатор_облака_2>"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "<идентификатор_облака_3>"
              resource_type = "resource-manager.cloud"
            }
          }
          data_events_filter {
            service = "<сервис_3>"
            resource_scope {
              resource_id   = "<идентификатор_каталога_2>"
              resource_type = "resource-manager.folder"
            }
            resource_scope {
              resource_id   = "<идентификатор_каталога_3>"
              resource_type = "resource-manager.folder"
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
      * `description` — описание трейла, которое позволит отличать его от других трейлов. Например `My very first trail`. Необязательный параметр.
      * `labels` — список [меток](../../resource-manager/concepts/labels.md) в формате `ключ=значение`. Необязательный параметр.
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, от имени которого трейл будет загружать файлы аудитного лога в бакет.
      
          В зависимости от [области сбора](../concepts/trail.md#collecting-area) аудитных логов, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../../iam/concepts/access-control/roles.md) `audit-trails.viewer` на организацию, облако или каталог, в которых трейл будет собирать аудитные логи.

      {% note warning %}
      
      Должно быть указано только одно место назначения: `storage_destination` , `logging_destination` или `data_stream_destination`.
      
      {% endnote %}
      
      * `logging_destination` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) Yandex Cloud Logging.
      
          * `log_group_id` — [идентификатор лог-группы](../../logging/operations/get-group.md), в которую трейл будет сохранять аудитные логи.
      * `storage_destination` — загружать логи в [бакет](../../storage/concepts/bucket.md) Yandex Object Storage:
      
          * `bucket_name` — имя бакета, куда трейл будет сохранять аудитные логи.
          * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
      
              {% note info %}
              
              Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
              
              {% endnote %}
      
      * `data_stream_destination` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams:
      
          * `stream_name` — имя потока данных, в который трейл будет сохранять аудитные логи.
          * `database_id` — идентификатор базы данных Yandex Managed Service for YDB, которая используется потоком данных Data Streams.
          * `codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.

      * `filtering_policy` — настройки политики фильтрации, которая определяет, какие события будут собираться и попадут в аудитные логи. Политика состоит из набора фильтров, которые относятся к разным уровням событий. Содержит объекты `management_events_filter` и `data_events_filters`.
      
          * `management_events_filter` — фильтр событий уровня конфигурации.
          * `resource_scopes` — [область сбора логов](../concepts/trail.md#collecting-area). Можно комбинировать в одном параметре `resource_scopes` несколько областей, которые принадлежат одной организации. Например, собирать логи из одного облака целиком, а из другого — только из определенных каталогов. Права сервисного аккаунта должны позволять сбор логов из указанных областей.
      
              * `resource_id` — идентификатор ресурса, для ресурсов которого будут собираться аудитные логи. В зависимости от области сбора аудитных логов укажите в этом параметре [идентификатор](../../organization/operations/organization-get-id.md) организации или [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака.
              * `resource_type` — тип области согласно указанному идентификатору:
      
                  * `organization-manager.organization` — [организация](../../organization/concepts/organization.md);
                  * `resource-manager.cloud` — [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud);
                  * `resource-manager.folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
          * `data_events_filters` — фильтры событий уровня сервисов. Можно настроить несколько фильтров такого типа — по одному для каждого сервиса. Фильтр для одного сервиса имеет следующую структуру:
      
              * `service` — имя сервиса, в котором трейл будет обрабатывать события.  Его можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md)).
              * `resource_scopes` — места, откуда собирать события уровня сервисов. Этот параметр настраивается аналогично фильтру событий уровня конфигурации.
              * `included_events` — собирать только указанные события. Необязательный параметр. Если не указать, то будут собираться все события. Вместо `included_events` можно указать `excluded_events` — собирать все события, кроме указанных. Эти параметры — взаимоисключающие.
                  Полный перечень событий можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md).

      Более подробную информацию о параметрах ресурса `yandex_audit_trails_trail` в Terraform см. в [документации провайдера](../../terraform/resources/audit_trails_trail.md).

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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc audit-trails trail get <имя_трейла>
     ```

- API {#api}

  Чтобы изменить трейл, воспользуйтесь методом REST API [update](../api-ref/Trail/update.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Update](../api-ref/grpc/Trail/update.md).

  Чтобы упростить создание спецификации трейла, вы можете получить параметры трейла с помощью метода REST API [get](../api-ref/Trail/get.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызова gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).

{% endlist %}

## Удалить трейл {#delete-trail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить трейл:

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Audit Trails**.
  1. В строке с нужным трейлом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
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
      
      
        # Должно быть указано только одно место назначения:
        # storage_destination , logging_destination, data_stream_destination
        # Настройки для всех мест назначения приведены для иллюстрации
      
        logging_destination {
          log_group_id = "<идентификатор_лог-группы>"
        }
        storage_destination {
          bucket_name   = "<идентификатор_бакета>"
          object_prefix = "<префикс>"
        }
        data_stream_destination {
          database_id = "<идентификатор_базы_данных_YDS>"
          stream_name = "<имя_потока_данных_YDS>"
          codec       = "<метод_сжатия_событий>"
        }
      
        # Настройки политики фильтрации
      
        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "<идентификатор_организации>"
              resource_type = "organization-manager.organization"
            }
          }  
          data_events_filter {
            service = "<сервис>"
            included_events = ["<тип_событий_сервиса>","<тип_событий_сервиса_2>"]
            resource_scope {
              resource_id   = "<идентификатор_облака>"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "<идентификатор_каталога>"
              resource_type = "resource-manager.folder"
            }
          }
          data_events_filter {
            service = "<сервис_2>"
            resource_scope {
              resource_id   = "<идентификатор_облака_2>"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "<идентификатор_облака_3>"
              resource_type = "resource-manager.cloud"
            }
          }
          data_events_filter {
            service = "<сервис_3>"
            resource_scope {
              resource_id   = "<идентификатор_каталога_2>"
              resource_type = "resource-manager.folder"
            }
            resource_scope {
              resource_id   = "<идентификатор_каталога_3>"
              resource_type = "resource-manager.folder"
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