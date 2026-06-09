# Техническое обслуживание в {{ mtr-name }}

Под техническим обслуживанием понимается:

* автоматическая установка обновлений и исправлений {{ TR }} для хостов (в т. ч. для выключенных кластеров);
* другие сервисные работы.

## Окно обслуживания {#maintenance-window}

Предпочтительное время технического обслуживания можно задать при [создании кластера](../operations/cluster-create.md) или [изменении его настроек](../operations/cluster-update.md#change-additional-settings):

* Вариант **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию) разрешает проводить техническое обслуживание в любое время.
* Вариант **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** позволяет выбрать день недели и время по UTC, когда будет проводиться техническое обслуживание. Например, можно выбрать время, когда кластер наименее загружен.

{% note info %}

Чтобы просматривать информацию о заданиях на техническое обслуживание, необходима [роль](../security.md#managed-trino-maintenanceTask-viewer) `managed-trino.maintenanceTask.viewer` или выше.

Чтобы управлять заданиями на техническое обслуживание, необходима [роль](../security.md#managed-trino-maintenanceTask-editor) `managed-trino.maintenanceTask.editor` или выше.

{% endnote %}