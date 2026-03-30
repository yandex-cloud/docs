---
title: Техническое обслуживание в {{ maf-full-name }}
description: Под техническим обслуживанием в {{ maf-name }} понимается автоматическая установка обновлений и исправлений для компонентов кластера (в т. ч. для выключенных кластеров), изменение конфигурации компонентов и другие сервисные работы.
---

# Техническое обслуживание в {{ maf-full-name }}

Под техническим обслуживанием понимается:

* автоматическая установка обновлений и исправлений {{ AF }} для [компонентов](index.md#components) кластера (в т. ч. для выключенных кластеров);
* другие сервисные работы.

## Окно обслуживания {#maintenance-window}

Предпочтительное время технического обслуживания можно задать при [создании кластера](../operations/cluster-create.md) или [изменении его настроек](../operations/cluster-update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

Чтобы просматривать информацию о заданиях на техническое обслуживание, необходима [роль](../security/index.md#managed-airflow-maintenanceTask-viewer) `managed-airflow.maintenanceTask.viewer` или выше.

Чтобы управлять заданиями на техническое обслуживание, необходима [роль](../security/index.md#managed-airflow-maintenanceTask-editor) `managed-airflow.maintenanceTask.editor` или выше.

{% endnote %}

## См. также {#see-also}

* [Управление техническим обслуживанием в кластере {{ maf-name }}](../operations/cluster-maintenance.md)