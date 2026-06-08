---
title: How to create a {{ yq-full-name }} connection
description: Follow this guide to create a connection to {{ yq-full-name }}.
---

# Creating a {{ yq-full-name }} connection

{% note info %}

To create a connection, you need a [service account](../../../iam/concepts/users/service-accounts.md) with the `yq.editor` or `{{ roles-editor }}` [role](../../../iam/operations/sa/assign-role-for-sa.md) for the folder with your {{ yq-full-name }} [connection](../../../query/concepts/glossary.md#connection).

{% endnote %}

To create a {{ yq-full-name }} connection:

1. Open the [connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **{{ yq-full-name }}** connection.
1. Configure the connection as follows:

   * **Cloud and folder**: Select the folder with your {{ yq-full-name }} connection.
   * **Service account**: Select an existing [service account](../../../iam/concepts/users/service-accounts.md) or create a new one.
   * **Cache TTL in seconds**: Specify the cache TTL or leave the default value.
   * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../dataset/settings.md#sql-request-in-datatset).

1. Optionally, test the connection by clicking **Check connection**.
1. Click **Create connection**.
1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.


## Use cases {#examples}

* [{#T}](../../tutorials/data-from-yandex-query-visualization.md)
