# Подготовка спецификации трейла

Вы можете [создавать](#spec-for-create) и [обновлять](#spec-for-update) трейлы с помощью YAML-спецификации через [CLI](../../cli/index.md). Для создания нового трейла сформируйте спецификацию из вывода команды `get` похожего трейла. Для обновления существующего — возьмите за основу вывод команды `get` этого же трейла.

{% note tip %}

Для создания и управления несколькими трейлами рекомендуем использовать [Terraform](../tf-ref.md)

{% endnote %}

## Подготовить спецификацию для трейла {#spec-for-create}

{% list tabs group=instructions %}

- CLI {#cli}

  1. [Получите](get-info.md) информацию о трейле, который будете изменять, либо использовать как основу для нового:

      ```bash
      yc audit-trails trail get <имя_или_идентификатор_трейла>
      ```

      Результат:

      ```text
      id: cnpmhbf7gsq3********
      folder_id: b1g681qpemb4********
      created_at: "2026-02-13T20:32:52.357Z"
      updated_at: "2026-02-13T20:32:52.357Z"
      name: create-me
      destination:
        object_storage:
          bucket_id: recreate-trails
      service_account_id: ajelprpohp7r********
      status: ACTIVE
      cloud_id: b1gia87mbaom********
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: b1g681qpemb4********
              type: resource-manager.folder
        data_events_filters:
          - service: compute
            resource_scopes:
              - id: b1g681qpemb4********
                type: resource-manager.folder
      ```

  1. Сохраните полученную информацию в файл, например `my-trail-spec.yaml`.
  1. При изменении трейла переименуйте поле `id` в `trail_id`.
  1. Удалите поля:
      * `folder_id` (только при изменении трейла)
      * `created_at`
      * `updated_at`
      * `status`
      * `cloud_id`

  1. (Опционально) Удалите устаревшие блоки, если они есть:
      * `filter`
      * `path_filter`
      * `event_filter`

  1. Обновите нужные параметры трейла.

      {% cut "Описание параметров трейла" %}

      ```yaml
      name: <имя_трейла>
      folder_id: <идентификатор_каталога>
      destination:
        # Должно быть указано только одно место назначения:
        # object_storage, cloud_logging, data_stream или eventrouter
        # Настройки для всех мест назначения приведены для иллюстрации
        object_storage:
          bucket_id: <имя_бакета>
          object_prefix: <префикс_для_объектов>
        cloud_logging:
          log_group_id: <идентификатор_лог_группы>
        data_stream:
          stream_name: <имя_потока_данных_YDS>
          database_id: <идентификатор_базы_данных_YDS>
          codec: <метод_сжатия_событий>
        eventrouter:
          eventrouter_connector_id: <идентификатор_коннектора_шины>
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
            # Допустимо указать либо included_events, либо excluded_events,
            # либо не указывать оба этих параметра, чтобы собирались все события сервиса
            # Оба параметра приведены для иллюстрации
            included_events:
              event_types:
                - <эти_события_будут_собираться>
            excluded_events:
              event_types:
                - <эти_события_не_будут_собираться>
      ```

      Где:

      * `name` — имя трейла. Оно должно быть уникальным в рамках каталога.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором будет размещен трейл.

      * `destination` — настройки выбранного места назначения, куда будут загружаться аудитные логи.
      
          {% note warning %}
      
          Настройки мест назначения взаимоисключающие. Использование одних настроек делает невозможным использование других.
      
          {% endnote %}
      
          * `object_storage` — загружать логи в [бакет](../../storage/concepts/bucket.md#naming) Yandex Object Storage:
      
              * `bucket_id` — [имя](../../storage/concepts/bucket.md#naming) бакета.
      
                  Имя бакета можно запросить со списком бакетов в каталоге (используется каталог по умолчанию):
      
                  ```bash
                  yc storage bucket list
                  ```
              * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
      
                  {% note info %}
                  
                  Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
                  
                  {% endnote %}
      
          * `cloud_logging` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) Yandex Cloud Logging.
      
              В параметре `log_group_id` укажите идентификатор лог-группы. Идентификатор можно запросить со [списком лог-групп в каталоге](../../logging/operations/list.md).
          * `data_stream` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams:
      
              * `stream_name` — имя потока данных. Имя можно запросить со [списком потоков данных в каталоге](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id` — идентификатор базы данных YDB, которая используется потоком данных Data Streams. Идентификатор можно запросить со [списком баз данных YDB в каталоге](../../ydb/operations/manage-databases.md#list-db).
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.

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
      
              * `*_events` — фильтры событий уровня сервиса:
      
                  * `included_events.event_types` — собирать только указанные события.
                  * `excluded_events.event_types` — собирать все события, кроме указанных.
      
                  Перечень событий можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md).
      
                  {% note warning %}
      
                  Фильтры `included_events` и `excluded_events` взаимоисключающие, настройте только один из них. Если оба фильтра не настроены, будут собираться все события.
      
                  {% endnote %}

      {% endcut %}

  1. Сохраните изменения в файле.

{% endlist %}