В блоке **{{ ui-key.yacloud.audit-trails.label_control-plane-collection-new }}**:

1. Включите сбор логов.
1. Выберите ресурс: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` или `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
1. В зависимости от выбранного ресурса выберите конкретные облака или каталоги, с которых будут собираться события:

    * Для области сбора `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** одно или несколько облаков, с которых будут собираться события.

        Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех облаков в организации.

    * Для области сбора `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` выберите из выпадающего списка **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** один или несколько каталогов, с которых будут собираться события.

        Оставьте значение по умолчанию (`{{ ui-key.yacloud.common.all }}`), чтобы собирать события со всех каталогов в облаке.