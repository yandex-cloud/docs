---
description: In this article, you will learn how to create a connection to get detailed statistics on dataset queries and dashboard views.
---


# Creating a connection to {{ datalens-short-name }} Usage Analytics

{% note info %}

Only a user with the `{{ roles-datalens-instances-admin }}` or `{{ roles-datalens-admin }}` [role](../../security/roles.md#service-roles) can create and use a connection in an [organization](../../concepts/organizations.md). The `{{ roles-datalens-workbooks-editor }}` [workbook admin](../../security/roles.md#datalens-workbooks-admin) role is not enough to create a connection.

To allow other users to view a connection and run queries to it, the connection administrator can configure [object access permissions](../../security/manage-access.md).

{% endnote %}


To create a {{ datalens-short-name }} Usage Analytics connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).

1. Under **Files and services**, select the **Usage Analytics** connection:

   * **Light**: Provides aggregated statistics on the {{ datalens-short-name }} instance usage for a limited period of time (60 days).

   * **Detailed**: Provides both detailed and aggregated statistics for the {{ datalens-short-name }} instance over a long period of time (360 days). Offers detailed statistics on dataset queries and dashboard views.

{% include [datalens-usage-tracking-connection-011225-note](../../../_includes/datalens/operations/datalens-usage-tracking-connection-011225-note.md) %}

1. Leave the **Automatically create dashboard, charts, and dataset over connection** option enabled if you want a standard dataset:

   {% cut "For Light connection" %}

   * **DataLens Usage Analytics Light**: Dashboard with preset charts.
   * **Usage Analytics (light)**: Dataset with aggregate data on dataset queries.

   {% endcut %}

   {% cut "For Detailed connection" %}

   * **DataLens Usage Analytics Detailed**: Dashboard with preset charts.
   * **Usage Analytics (light)**: Dataset with aggregate data on dataset queries.
   * **Usage Analytics (detailed)**: Dataset with a complete log of dataset queries.
   * **Usage Analytics (dashboard views)**: Dataset with data on the number of dashboard views.

   {% endcut %}

1. Click **Create connection**.
1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.


You can use a preset dashboard or create custom charts and dashboards for specified datasets.

