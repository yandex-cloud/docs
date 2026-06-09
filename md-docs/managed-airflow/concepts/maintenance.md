# Техническое обслуживание в Yandex Managed Service for Apache Airflow™

Под техническим обслуживанием понимается:

* автоматическая установка обновлений и исправлений Apache Airflow™ для [компонентов](index.md#components) кластера (в т. ч. для выключенных кластеров);
* другие сервисные работы.

## Окно обслуживания {#maintenance-window}

Предпочтительное время технического обслуживания можно задать при [создании кластера](../operations/cluster-create.md) или [изменении его настроек](../operations/cluster-update.md):

* Вариант **В любое время** (по умолчанию) разрешает проводить техническое обслуживание в любое время.
* Вариант **По расписанию** позволяет выбрать день недели и время по UTC, когда будет проводиться техническое обслуживание. Например, можно выбрать время, когда кластер наименее загружен.

{% note info %}

Чтобы просматривать информацию о заданиях на техническое обслуживание, необходима [роль](../security/index.md#managed-airflow-maintenanceTask-viewer) `managed-airflow.maintenanceTask.viewer` или выше.

Чтобы управлять заданиями на техническое обслуживание, необходима [роль](../security/index.md#managed-airflow-maintenanceTask-editor) `managed-airflow.maintenanceTask.editor` или выше.

{% endnote %}

## См. также {#see-also}

* [Управление техническим обслуживанием в кластере Managed Service for Apache Airflow™](../operations/cluster-maintenance.md)