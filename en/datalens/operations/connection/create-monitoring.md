---
title: How to create a {{ monitoring-name }} connection
description: Follow this guide to create a connection to {{ monitoring-name }}.
---

# Creating a {{ monitoring-name }} connection

{% note info %}

* To create a connection, you need a [service account]({{ link-docs }}/iam/concepts/users/service-accounts) with the `{{ roles-monitoring-viewer }}` or `{{ roles-viewer }}` [role]({{ link-docs }}/iam/operations/sa/assign-role-for-sa).
* Use the [Yandex Monitoring query language]({{ link-docs }}/monitoring/concepts/querying) to write queries in QL charts.
* When writing queries, do not use the `folderId` [label]({{ link-docs }}/monitoring/concepts/data-model#label).

{% endnote %}

To create a {{ monitoring-name }} connection:

1. Open the [connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **Monitoring** connection.
1. Configure the connection as follows:

   * **Cloud and folder**: Select the folder with your service account.
   * **Service account**: Select an existing service account or create a new one.

1. Click **Create connection**.
1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.


## Use cases {#examples}

* [{#T}](../../tutorials/data-from-monitoring-visualization.md)
