
# Creating a connection to {{ datalens-short-name }} Usage Analytics

{% note info %}

Only a user with the `{{ roles-datalens-instances-admin }}` or `{{ roles-datalens-admin }}` [role](../../security/roles.md#service-roles) can create and use a connection.

{% endnote %}


To create a {{ datalens-short-name }} Usage Analytics connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).

1. Under **Files and services**, select the **Usage Analytics** connection:

   * **Light**: Provides aggregated statistics on the {{ datalens-short-name }} instance usage for a limited period of time (60 days). This connection is available with any [service plan](../../pricing.md#service-plans).

   * **Detailed**: Provides both detailed and aggregated statistics on the {{ datalens-short-name }} instance usage for a long period of time (180 days). It allows you to view detailed statistics on dataset queries and dashboard views. This connection is only available with the _Business_ [service plan](../../pricing.md#service-plans). Once you change your service plan to _Community_, the connection will no longer work.

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

