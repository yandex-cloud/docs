* `filtering_policy` — настройки политики фильтрации, которая определяет, какие события будут собираться и попадут в аудитные логи. Политика состоит из набора фильтров, которые относятся к разным уровням событий. Содержит блоки `management_events_filter` и `data_events_filter`.

    * `management_events_filter` — фильтр событий уровня конфигурации.

        * `resource_scope` — [область сбора логов](../../audit-trails/concepts/trail.md#collecting-area). Можно указать несколько блоков `resource_scope` для областей, которые принадлежат одной организации. Например, собирать логи из одного облака целиком, а из другого — только из определенных каталогов. Права сервисного аккаунта должны позволять сбор логов из указанных областей.

            * `resource_id` — идентификатор области сбора: [организации](../../organization/operations/organization-get-id.md), [облака](../../resource-manager/operations/cloud/get-id.md) или [каталога](../../resource-manager/operations/folder/get-id.md).
            * `resource_type` — тип области согласно указанному идентификатору:

                * `organization-manager.organization` — [организация](../../organization/concepts/organization.md);
                * `resource-manager.cloud` — [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud);
                * `resource-manager.folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
    * `data_events_filter` — фильтр событий уровня сервисов. Можно настроить несколько фильтров такого типа — по одному для каждого сервиса. Фильтр для одного сервиса имеет следующую структуру:

        * `service` — имя сервиса, в котором трейл будет обрабатывать события. Его можно получить в [справочнике событий уровня сервисов](../../audit-trails/concepts/events-data-plane.md).
        * `resource_scope` — места, откуда собирать события уровня сервисов. Этот блок настраивается аналогично фильтру событий уровня конфигурации.
        * `included_events` — полные имена событий для сбора. Вместо него можно указать `excluded_events` — полные имена событий для исключения. Эти параметры взаимоисключающие. Если оба не заданы, отбор не ограничивается именами событий.

            Используйте полное имя из поля `event_type` аудитного лога. Например, событию `CreateIamToken` из [справочника](../../audit-trails/concepts/events-data-plane.md) соответствует `yandex.cloud.audit.iam.CreateIamToken`.
        * `include_rule` и `exclude_rule` — необязательные [правила с условиями по значениям полей](../../audit-trails/concepts/trail.md#field-filters). Действуют вместе с выбором событий по именам.
