---
title: Queries against datasets with {{ websql-full-name }}
description: You can use {{ websql-name }} to send SQL queries to databases in clusters that are data sources for {{ data-catalog-name }}.
---

# Queries against datasets with {{ websql-full-name }}


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


You can use [{{ websql-full-name }}](../../../websql/index.yaml) to send SQL queries to databases in clusters that are data sources for {{ data-catalog-name }}.

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with DBs, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with SQL commands by suggesting prompts.

For more information about working with {{ websql-name }}, see its [documentation](../../../websql/operations/index.md).

To run an SQL query:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. In the list that opens, select the metadata catalog.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
    1. Navigate to a metadata object with the **Dataset** type by doing one of the following:

        * Click the name of the object with the **Dataset** type.
        * Click the name of an object with a type other than **Dataset**. Navigate across child objects using the **Child** tab until you find an object with the **Dataset** type. Click the object’s name.

    1. In the **Data** field, click the **Open in WebSQL** link.
    1. Select a connection to the source cluster database. This will take you to {{ websql-name }}.
    1. In the top-right panel, enter the SQL query and click **Run**.

        Here are some examples of what you can do with SQL commands:

        * [Run multi-queries](../../../websql/operations/query-executor.md#multiple-queries)
        * [Export query results](../../../websql/operations/query-executor.md#export-results)
        * [Use an AI assistant to analyze and optimize queries](../../../websql/operations/ai-assistant.md)
        * [Save a query as a template and share it with other users](../../../websql/operations/templates.md#save-query)
        * [Use historical queries](../../../websql/operations/history.md)

{% endlist %}

{% note info %}

In case the data source is a {{ mpg-full-name }} cluster, you cannot use SQL commands for actions requiring superuser permissions.

{% endnote %}
