# Техническое обслуживание в {{ maf-full-name }}

Под техническим обслуживанием понимается:

* автоматическая установка обновлений и исправлений {{ AF }} для [компонентов](index.md#components) кластера (в т. ч. для выключенных кластеров);
* другие сервисные работы.

## Окно обслуживания {#maintenance-window}

Предпочтительное время технического обслуживания можно задать при [создании кластера](../operations/cluster-create.md) или [изменении его настроек](../operations/cluster-update.md):

* Вариант **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию) разрешает проводить техническое обслуживание в любое время.
* Вариант **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** позволяет выбрать день недели и время по UTC, когда будет проводиться техническое обслуживание. Например, можно выбрать время, когда кластер наименее загружен.

{% note info %}

Чтобы просматривать информацию о заданиях на техническое обслуживание, необходима [роль](../security/index.md#managed-airflow-maintenanceTask-viewer) `managed-airflow.maintenanceTask.viewer` или выше.

Чтобы управлять заданиями на техническое обслуживание, необходима [роль](../security/index.md#managed-airflow-maintenanceTask-editor) `managed-airflow.maintenanceTask.editor` или выше.

{% endnote %}

## См. также {#see-also}

* [Управление техническим обслуживанием в кластере {{ maf-name }}](../operations/cluster-maintenance.md)