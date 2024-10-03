---
title: How to create a {{ monitoring-name }} connection
description: Follow this guide to create a {{ monitoring-name }} connection.
---

# Creating a {{ monitoring-name }} connection

{% note info %}

* To create a connection, you need a [service account](../../../iam/concepts/users/service-accounts.md) with the `{{ roles-monitoring-viewer }}` or `{{ roles-viewer }}` [role](../../../iam/operations/sa/assign-role-for-sa.md).
* Use the [Yandex Monitoring query language](../../../monitoring/concepts/querying.md) to write queries in QL charts.
* When writing queries, do not use the `folderId` [label](../../../monitoring/concepts/data-model.md#label).

{% endnote %}

To create a {{ monitoring-name }} connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **Monitoring** connection.
1. Specify the connection parameters:

   * **Cloud and folder**: Select the folder where your service account is located.
   * **Service account**: Select an existing service account or create a new one.

1. Click **Create connection**.
1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.