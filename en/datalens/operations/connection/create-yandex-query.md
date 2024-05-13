---
title: "How to create a {{ yq-full-name }} connection"
description: "Follow this guide to create a {{ yq-full-name }} connection."
---

# Creating a {{ yq-full-name }} connection

{% note info %}

To create a connection, you need a [service account](../../../iam/concepts/users/service-accounts.md) with the `{{ roles-editor }}` [role](../../../iam/operations/sa/assign-role-for-sa.md) for the folder where the {{ yq-full-name }} [connection](../../../query/concepts/glossary.md#connection) was created.

{% endnote %}

To create a {{ yq-full-name }} connection:

1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Click **Create connection**.
1. Select a **{{ yq-full-name }}** connection.
1. Specify the connection parameters:

   * **Cloud and folder**: Select the folder where the {{ yq-full-name }} connection was created.
   * **Service account**: Select an existing [service account](../../../iam/concepts/users/service-accounts.md) or create a new one.
   * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value.
   * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. Click **Create connection**. If you use a new {{ datalens-short-name }} object model with [workbooks and collections](../../../datalens/workbooks-collections/index.md), select or create a workbook to save the connection to.
1. Enter a name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
