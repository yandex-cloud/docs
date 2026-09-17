[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > [Пошаговые инструкции](index.md) > Создание трейла

# Создание трейла для загрузки аудитных логов


Вы можете создать трейл, который будет загружать аудитные логи [уровня конфигурации](../concepts/format.md) и [уровня сервисов](../concepts/format-data-plane.md) в один из [объектов назначения](../concepts/trail.md#target):

* бакет [Yandex Object Storage](../../storage/index.md);
* лог-группу [Yandex Cloud Logging](../../logging/index.md);
* поток данных [Yandex Data Streams](../../data-streams/index.md).

При создании трейла через CLI, Terraform или API в фильтрах событий уровня сервисов можно задать [условия по значениям полей](../concepts/trail.md#field-filters). Это позволяет уменьшить поток событий и объем хранимых логов.

## Перед началом работы {#before-you-begin}

Подготовьте [объект назначения](../concepts/trail.md#target) и сервисный аккаунт для трейла:

{% list tabs group=trail-target %}

- Бакет Object Storage {#bucket}

  1. [Создайте бакет](../../storage/operations/buckets/create.md) с ограниченным доступом, в который будут загружаться аудитные логи.
  1. (Опционально) Включите шифрование для бакета.

      [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у аккаунта, от имени которого вы собираетесь создавать ключ шифрования для бакета, есть [роль](../../kms/security/index.md#kms-editor) `kms.editor` на каталог.
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [storage.uploader](../../storage/security/index.md#storage-uploader) на [бакет](../../storage/concepts/bucket.md).
      * [kms.keys.encrypter](../../kms/security/index.md#kms-keys-encrypter) на [ключ шифрования](../../kms/concepts/key.md) для бакета.

          Эта роль необходима, только если для бакета было включено шифрование.

      * [audit-trails.viewer](../security/index.md#at-viewer) на один из ресурсов, который определяет [нужную область сбора](../concepts/trail.md#collecting-area) логов:
      
          * [Организация](../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
          * [Облако](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
          * [Каталог](../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.
      
          Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../organization/operations/add-role.md).

  1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у [аккаунта](../../iam/concepts/users/accounts.md), от имени которого вы собираетесь создавать трейл, есть необходимые роли:
     
     * [audit-trails.editor](../security/index.md#at-editor) на каталог, в котором будет находиться трейл.
     * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) на сервисный аккаунт для трейла.

- Лог-группа Cloud Logging {#logging}

  1. [Создайте лог-группу](../../logging/operations/create-group.md), в которую будут загружаться аудитные логи.
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [logging.writer](../../logging/security/index.md#logging-writer) на [лог-группу](../../logging/concepts/log-group.md).

      * [audit-trails.viewer](../security/index.md#at-viewer) на один из ресурсов, который определяет [нужную область сбора](../concepts/trail.md#collecting-area) логов:
      
          * [Организация](../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
          * [Облако](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
          * [Каталог](../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.
      
          Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../organization/operations/add-role.md).

  1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у [аккаунта](../../iam/concepts/users/accounts.md), от имени которого вы собираетесь создавать трейл, есть необходимые роли:
     
     * [audit-trails.editor](../security/index.md#at-editor) на каталог, в котором будет находиться трейл.
     * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) на сервисный аккаунт для трейла.

- Поток данных Data Streams {#data-streams}

  1. [Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream), в который будут загружаться аудитные логи.

      {% note tip %}

      Рекомендуем включить [автопартиционирование](../../data-streams/concepts/glossary.md#autopartitioning) на принимающем потоке данных.

      Часть событий может потеряться при перегрузке отдельных [сегментов](../../data-streams/concepts/glossary.md#shard) или всего [потока](../../data-streams/concepts/glossary.md#stream-concepts). Автопартиционирование автоматически добавляет сегменты и распределяет нагрузку, что помогает избежать потерь. Если автопартиционирование отключено, самостоятельно проверяйте и увеличивайте количество сегментов при необходимости.

      {% endnote %}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [yds.writer](../../data-streams/security/index.md#yds-writer) на [поток данных](../../data-streams/concepts/glossary.md#stream-concepts).

      * [audit-trails.viewer](../security/index.md#at-viewer) на один из ресурсов, который определяет [нужную область сбора](../concepts/trail.md#collecting-area) логов:
      
          * [Организация](../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
          * [Облако](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
          * [Каталог](../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.
      
          Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../organization/operations/add-role.md).

  1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у [аккаунта](../../iam/concepts/users/accounts.md), от имени которого вы собираетесь создавать трейл, есть необходимые роли:
     
     * [audit-trails.editor](../security/index.md#at-editor) на каталог, в котором будет находиться трейл.
     * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) на сервисный аккаунт для трейла.

{% endlist %}

## Создать трейл {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите разместить трейл.
  1. [Перейдите](https://console.yandex.cloud/link/audit-trails) в сервис **Audit Trails**.
  1. Нажмите **Создать трейл**.
  1. В блоке **Назначение** выберите один из объектов назначения и укажите его настройки:

      * **Object Storage** — загружать аудитные логи в бакет Object Storage. Рекомендуется для долгосрочного хранения данных. Задайте настройки хранения логов:

          * **Бакет** — бакет, который [был создан ранее](#before-you-begin).
          * **Префикс объекта** — [префикс](../concepts/format.md#log-file-name), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.

              {% note info %}
              
              Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
              
              {% endnote %}

          * **Ключ шифрования** — ключ шифрования для бакета. Выбирать его необходимо, только если для бакета было включено шифрование.
      
      * **Cloud Logging** — лог-группа, которая [была создана ранее](#before-you-begin). В нее будут загружаться аудитные логи. Рекомендуется для быстрого сбора и анализа логов.
      * **Data Streams** — поток данных, который [был создан ранее](#before-you-begin). В этот поток будут загружаться аудитные логи. Рекомендуется для потоковой передачи логов в другие сервисы или системы.

  1. В блоке **Сбор логов с управляющего слоя**:
     
     1. Включите сбор логов.
     1. Выберите ресурс: `Организация`, `Облако` или `Каталог`.
     1. В зависимости от выбранного ресурса выберите конкретные облака или каталоги, с которых будут собираться события:
     
         * Для области сбора `Организация` выберите из выпадающего списка **Облако** одно или несколько облаков, с которых будут собираться события.
     
             Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех облаков в организации.
     
         * Для области сбора `Облако` выберите из выпадающего списка **Каталог** один или несколько каталогов, с которых будут собираться события.
     
             Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех каталогов в облаке.
  1. В блоке **Сбор логов со слоя данных**:
     
     {% note warning %}
     
     В консоли управления сбор некоторых событий [уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) включен [по умолчанию](../concepts/trail.md#default). Их доставка оплачивается в соответствии с [правилами тарификации](../pricing.md). Если события уровня сервисов вам не нужны, отключите их сбор.
     
     {% endnote %}
     
     1. Включите сбор логов.
     1. Выберите [сервисы](../concepts/events-data-plane.md), для которых вы хотите собирать аудитные логи.
     1. Для каждого сервиса настройте область сбора и фильтр событий:
     
         1. Справа от названия сервиса нажмите ![chevron-down](../../_assets/console-icons/chevron-down.svg).
         1. Выберите ресурс: `Организация`, `Облако` или `Каталог`.
         1. В зависимости от выбранного ресурса выберите конкретные облака или каталоги, с которых будут собираться события:
     
             * Для области сбора `Организация` выберите из выпадающего списка **Облако** одно или несколько облаков, с которых будут собираться события.
     
                 Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех облаков в организации.
     
             * Для области сбора `Облако` выберите из выпадающего списка **Каталог** один или несколько каталогов, с которых будут собираться события.
     
                 Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех каталогов в облаке.
     
         1. Выберите фильтр [событий](../concepts/events-data-plane.md):
     
               * `Получать все` — чтобы собирать все события сервиса.
               * `Выбранные` — чтобы собирать только выбранные события. Затем выберите события.
               * `Исключить` — чтобы собирать все события, кроме выбранных. Затем выберите события.

      Чтобы ограничить сбор событий по значениям полей, задайте [условия фильтрации](../concepts/trail.md#field-filters) через CLI, API или Terraform.

  1. В блоке **Сервисный аккаунт** выберите [созданный ранее](#before-you-begin) сервисный аккаунт, от имени которого будет работать трейл.
  1. В поле **Имя** укажите имя создаваемого трейла. Оно должно быть уникальным в рамках каталога.
  1. (Опционально) Укажите описание трейла.
  1. Нажмите **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Посмотрите описание команды CLI для создания трейла:

  ```bash
  yc audit-trails trail create --help
  ```

  Для сбора [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) используйте YAML-спецификацию. Если нужны только события уровня конфигурации, параметры можно передать непосредственно в команде.

  {% cut "В YAML-спецификации" %}

  1. Создайте YAML-файл с конфигурацией трейла. В шаблоне логи загружаются в бакет:

      ```yaml
      name: <имя_трейла>
      folder_id: <идентификатор_каталога>
      destination:
        object_storage:
          bucket_id: <имя_бакета>
          object_prefix: <префикс_для_объектов>
      service_account_id: <идентификатор_сервисного_аккаунта>
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: <идентификатор_организации_облака_или_каталога>
              type: <тип>
        data_events_filters:
          - service: <имя_сервиса>
            resource_scopes:
              - id: <идентификатор_организации_облака_или_каталога>
                type: <тип>
            included_events:
              event_types:
                - <полное_имя_события>
      ```

      За основу также можно взять [спецификацию существующего трейла](prepare-spec.md#spec-for-create).

      Параметры конфигурации:

      * `name` — имя трейла. Оно должно быть уникальным в рамках каталога.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором будет размещен трейл.
      * `destination` — настройки объекта назначения для аудитных логов.

          Укажите только один объект назначения: `object_storage`, `cloud_logging` или `data_stream`.

          * `object_storage` — загружать логи в [бакет](../../storage/concepts/bucket.md#naming) Yandex Object Storage:

              * `bucket_id` — [имя](../../storage/concepts/bucket.md#naming) созданного [ранее](#before-you-begin) бакета.

                  Чтобы посмотреть имена бакетов в каталоге по умолчанию, выполните команду:

                  ```bash
                  yc storage bucket list
                  ```
              
              * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.

                  {% note info %}
                  
                  Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
                  
                  {% endnote %}

          * `cloud_logging` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) Yandex Cloud Logging.

              Замените блок `destination` в шаблоне:

              ```yaml
              destination:
                cloud_logging:
                  log_group_id: <идентификатор_лог_группы>
              ```

              В параметре `log_group_id` укажите идентификатор [созданной ранее](#before-you-begin) лог-группы. Идентификатор можно запросить со [списком лог-групп в каталоге](../../logging/operations/list.md).
          
          * `data_stream` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams:

              Замените блок `destination` в шаблоне:

              ```yaml
              destination:
                data_stream:
                  stream_name: <имя_потока_данных>
                  database_id: <идентификатор_базы_данных>
                  codec: RAW
              ```

              * `stream_name` — имя [созданного ранее](#before-you-begin) потока данных. Имя можно запросить со [списком потоков данных в каталоге](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id` — идентификатор базы данных YDB, которая используется потоком данных Data Streams. Идентификатор можно запросить со [списком баз данных YDB в каталоге](../../ydb/operations/manage-databases.md#list-db).
              * `codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.
          
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) созданного [ранее](#before-you-begin) сервисного аккаунта.

      * `filtering_policy` — настройки политики фильтрации, которая определяет, какие события будут собираться и попадут в аудитные логи. Политика состоит из набора фильтров, которые относятся к разным уровням событий.
      
          {% note warning %}
      
          Для политики обязательно должен быть настроен хотя бы один фильтр, иначе не получится создать трейл.
      
          {% endnote %}
      
          Доступные фильтры:
      
          * `management_events_filter` — фильтр событий уровня конфигурации.
      
              {#filter-cli}
      
              Укажите [область сбора логов](../concepts/trail.md#collecting-area) в параметре `resource_scopes`:
      
              * `id` — идентификатор организации, облака или каталога.
              * `type` — тип области согласно указанному идентификатору:
      
                  * `organization-manager.organization` — [организация](../../organization/concepts/organization.md);
                  * `resource-manager.cloud` — [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud);
                  * `resource-manager.folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
      
              Можно комбинировать в одном параметре `resource_scopes` несколько областей, которые принадлежат одной организации. Например, собирать логи из одного облака целиком, а из другого — только из определенных каталогов:
      
              ```yaml
              resource_scopes:
                # Сбор логов из облака 1 целиком
                - id: <идентификатор_облака_1>
                  type: resource-manager.cloud
                # Сбор логов из каталога 1 облака 2
                - id: <идентификатор_каталога_1>
                  type: resource-manager.folder
                # Сбор логов из каталога 2 облака 2
                - id: <идентификатор_каталога_2>
                  type: resource-manager.folder
              ```
      
              Права сервисного аккаунта должны позволять сбор логов из указанных областей.
      
          * `data_events_filters` — фильтры событий уровня сервисов. Можно настроить несколько фильтров такого типа — по одному для каждого сервиса.
      
              Фильтр для одного сервиса имеет следующую структуру:
      
              * `service` — имя сервиса. Его можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md).
      
              * `resource_scopes` — места, откуда собирать события уровня сервисов. Этот параметр настраивается аналогично фильтру событий уровня конфигурации.
      
              * `*_events` — полные имена событий для сбора или исключения:
      
                  * `included_events.event_types` — собирать только указанные события.
                  * `excluded_events.event_types` — собирать все события, кроме указанных.
      
                  Для исключения событий замените блок `included_events` в шаблоне:
      
                  ```yaml
                  excluded_events:
                    event_types:
                      - <полное_имя_события>
                  ```
      
                  Используйте полное имя из поля `event_type` аудитного лога. Например, событию `CreateIamToken` из [справочника](../concepts/events-data-plane.md) соответствует `yandex.cloud.audit.iam.CreateIamToken`.
      
              {% note warning %}
      
              Для фильтров по именам событий блоки `included_events` и `excluded_events` взаимоисключающие. Если они не заполнены, записываются все события. В том же фильтре можно дополнительно задать [условия по значениям полей](../concepts/trail.md#field-filters).
      
              {% endnote %}

  1. (Опционально) Дополните фильтр [условиями по значениям полей](../concepts/trail.md#field-filters) для нужного сервиса. Для этого в элементе списка `filtering_policy.data_events_filters` задайте правила `include_rules`, `exclude_rules`. Примеры настройки фильтрации приведены в инструкции [Создание трейла](create-trail.md#filter-examples).

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

  1. Опишите в конфигурационном файле параметры трейла. В шаблоне логи загружаются в бакет:

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

    1. [Аутентифицируйтесь](../api-ref/authentication.md) в API.
    1. Подготовьте параметры трейла: каталог, объект назначения, сервисный аккаунт и политику фильтрации с нужными сервисами и областями сбора.

        Чтобы взять за основу настройки существующего трейла, получите их методом REST API [get](../api-ref/Trail/get.md) или вызовом gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).

    1. (Опционально) Дополните фильтр [условиями по значениям полей](../concepts/trail.md#field-filters) для нужного сервиса. Для этого в запросе REST API в элементе списка `filteringPolicy.dataEventsFilters` задайте правила `includeRules`, `excludeRules`. В gRPC API используйте `filtering_policy.data_events_filters`, `include_rules` и `exclude_rules`. Пример настройки фильтрации приведен в инструкции [Создание трейла](create-trail.md#example-control-data-planes).
    1. Создайте трейл методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../api-ref/grpc/Trail/create.md).

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в выбранный объект назначения.

При загрузке в Cloud Logging события в [лог-группе](../../logging/concepts/log-group.md) могут дублироваться. Чтобы найти дубли, ориентируйтесь на уникальный идентификатор записи `json_payload.event_id`.

## Примеры {#examples}

### Создание трейла с фильтрацией событий {#example-control-data-planes}

В примере трейл `sample-trail-all-planes` создается в каталоге `folder0***` и записывает логи в бакет `sample-logs-bucket` с помощью сервисного аккаунта `service0***`.

Фильтры определяют, какие события попадают в логи:

* События уровня конфигурации — из всех облаков организации `org1***`.
* События уровня сервисов:
  * [Managed Service for PostgreSQL](../../managed-postgresql/index.md) — из облака `cloud1***` и каталога `folder1***`: все события, кроме `CreateDatabase` и `UpdateDatabase`.
  * [Identity and Access Management](../../iam/index.md) — из каталога `folder2***`: только события `CreateIamToken`. Из них исключаются события, в которых одновременно тип учетных данных равен `iam.session`, а имя субъекта — `user@example.com`.

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

- Terraform {#tf}

  1. Опишите в конфигурационном файле Terraform параметры трейла:

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

  Чтобы воспользоваться примерами, установите [cURL](https://curl.haxx.se).

  Пример ниже разработан для выполнения в операционных системах MacOS и Linux. Чтобы выполнить его в системе Windows, [ознакомьтесь](../../overview/concepts/console-syntax-guide.md) с особенностями работы с Bash в Microsoft Windows.

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

Примеры подходят для создания и изменения трейла. Добавьте фрагмент в фильтр нужного сервиса: в CLI — в элемент списка `filtering_policy.data_events_filters`, в Terraform — в блок `filtering_policy.data_events_filter`.

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

- Terraform {#tf}

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

- Terraform {#tf}

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

- Terraform {#tf}

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

{% cut "Сбор событий чтения секретов Kubernetes" %}

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

- Terraform {#tf}

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

Регистр ключа `objectRef` соответствует исходному событию Kubernetes.

{% endcut %}

## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске событий в аудитных логах](../tutorials/search-events-audit-logs/index.md).