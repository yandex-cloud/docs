В блоке **{{ ui-key.yacloud.audit-trails.label_data-plane-collection-new }}**:

{% include [events-by-default](./events-by-default.md) %}

1. Включите сбор логов.
1. Выберите [сервисы](../../audit-trails/concepts/events-data-plane.md), для которых вы хотите собирать аудитные логи.
1. Для каждого сервиса настройте область сбора и фильтр событий:

    1. Справа от названия сервиса нажмите ![chevron-down](../../_assets/console-icons/chevron-down.svg).
    1. Выберите ресурс: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` или `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
    1. В зависимости от выбранного ресурса выберите конкретные облака или каталоги, с которых будут собираться события:

        * Для области сбора `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** одно или несколько облаков, с которых будут собираться события.

            Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех облаков в организации.

        * Для области сбора `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** один или несколько каталогов, с которых будут собираться события.

            Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех каталогов в облаке.

    1. Выберите фильтр [событий](../../audit-trails/concepts/events-data-plane.md):

          * `{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_all }}` — чтобы собирать все события сервиса.
          * `{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_include }}` — чтобы собирать только выбранные события. Затем выберите события.
          * `{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_exclude }}` — чтобы собирать все события, кроме выбранных. Затем выберите события.