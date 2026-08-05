---
title: Maintenance in {{ metastore-full-name }}
description: In {{ metastore-full-name }}, maintenance includes installing {{ metastore-name }} updates and patches as well as other maintenance works.
---


# Maintenance in {{ metastore-name }}

Maintenance stands for support activities that keep your cluster up and running. It includes installing {{ metastore-name }} updates and patches as well as other maintenance works. Both active and stopped clusters are subject to maintenance operations.

Maintenance does not include updating the cluster's major version.


## Maintenance window {#maintenance-window}

You can set your preferred maintenance start time using the {{ yandex-cloud }} interfaces ([management console]({{ link-console-main }}), [CLI](../../cli/index.yaml), {{ TF }}, and API) when [creating](../operations/metastore/cluster-create.md) or [updating](../operations/metastore/cluster-update.md) a cluster:

* The **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** option (default) allows performing maintenance at any time.
* The **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** option allows you to select the day of the week and UTC time interval for the maintenance. For example, you can choose the cluster's least busy time.

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the [managed-metastore.maintenanceTask.viewer](../security/metastore-roles.md#managed-metastore-maintenanceTask-viewer) role or higher.

To manage maintenance tasks, you need the [managed-metastore.maintenanceTask.editor](../security/metastore-roles.md#managed-metastore-maintenanceTask-editor) role or higher.

{% endnote %}

{% include [metastore-trademark](../../_includes/metadata-hub/metastore-trademark.md) %}