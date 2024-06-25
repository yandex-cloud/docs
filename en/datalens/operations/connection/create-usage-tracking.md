
# Creating a connection to {{ datalens-short-name }} Usage Analytics

This connection will allow you to analyze {{ datalens-short-name }} user behavior, i.e., view statistics on using the service instance.

{% note info %}

Only a user with the `{{ roles-datalens-instances-admin }}` or `{{ roles-datalens-admin }}` [role](../../security/roles.md#service-roles) can create and use a connection.

{% endnote %}


To create a {{ datalens-short-name }} Usage Analytics connection:

1. Open the [page for creating a new connection]({{ link-datalens-main }}/connections/new).

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


## Specifics of working with a connection {#ut-connection-dashboard}


Service usage statistics are generated considering the following:

* For some connections, the query text is not saved:

   * [Files](create-file.md)
   * [Google Sheets](create-google-sheets.md)
   * [Yandex Documents](create-yadocs.md)
   * [{{ yq-full-name }}](create-yandex-query.md)
   * [Metrica](create-metrica-api.md)
   * [AppMetrica](create-appmetrica.md)
   * [{{ billing-name }}](create-cloud-billing.md)
   * [{{ monitoring-full-name }}](create-monitoring.md)

* When creating a new object (connection, dataset, chart, or dashboard), you will see `__unknown__` instead of its name in the statistics for up to 24 hours. When renaming an object, you will see its old name for up to 24 hours.
* Aggregated data is updated once in 24 hours.
* Unused objects and inactive users are not presented in the statistics.

### DataLens Usage Analytics Light dashboard {#light-dash}

The dashboard provides the following summary information:

* Number of objects of different types
* Number of executed queries and errors
* Number of users using the objects

At the top, there are filters by object and user. You can configure the statistics period with the help of the calendar. Use a custom table with object hierarchy to figure which dashboards are used the most and which areas are most prone to errors.

### DataLens Usage Analytics Detailed dashboard {#detailed-dash}

This dashboard is divided into three sections:

* **Objects**: This section provides a summary about the number of different types of objects. At the top, there are filters by object. Use a custom table with object hierarchy to figure which dashboards are used the most, which charts take longer than others to load, which areas are most prone to errors, and other information.

* **Users and Dashboard Views**: In this section, you can see who is using your objects. The tabs provide information by both views and queries.

* **Queries**: In this section, you can view the longest running queries and common errors.

