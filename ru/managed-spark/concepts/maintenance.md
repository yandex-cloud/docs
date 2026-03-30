---
title: Техническое обслуживание в {{ msp-full-name }}
description: Под техническим обслуживанием в {{ msp-name }} понимается автоматическая установка обновлений и исправлений для хостов (в т. ч. для выключенных кластеров), изменение класса хостов и другие сервисные работы.
---

# Техническое обслуживание в {{ msp-full-name }}

Под техническим обслуживанием понимается:

* автоматическая установка обновлений и исправлений {{ SPRK }} для хостов (в т. ч. для выключенных кластеров);
* другие сервисные работы.

## Окно обслуживания {#maintenance-window}

Предпочтительное время технического обслуживания можно задать при [создании кластера](../operations/cluster-create.md) или [изменении его настроек](../operations/cluster-update.md#change-additional-settings):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

Чтобы просматривать информацию о заданиях на техническое обслуживание, необходима [роль](../security.md#managed-spark-maintenanceTask-viewer) `managed-spark.maintenanceTask.viewer` или выше.

Чтобы управлять заданиями на техническое обслуживание, необходима [роль](../security.md#managed-spark-maintenanceTask-editor) `managed-spark.maintenanceTask.editor` или выше.

{% endnote %}