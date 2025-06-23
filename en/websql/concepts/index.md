# About {{ websql-full-name }}

{{ websql-full-name }} is a {{ yandex-cloud }} service that allows you to connect to public databases and managed database clusters. 

Once connected to a database, you will be able to view DB schemas, tables, and views, as well as run queries. It is a web-based tool that simplifies writing queries by suggesting prompts and commands.

You can connect to managed database clusters from clouds and folders that belong to your {{ yandex-cloud }} [organization](../../organization/concepts/organization.md). If you [switch to a different organization](../../organization/operations/manage-organizations.md#switch-to-another-org), you will have access to clusters from other clouds and folders. The connections you added will be available while you are in the current {{ yandex-cloud }} organization.

{{ websql-full-name }} supports the following DB versions:

* {{ PG }}: 12 and higher
* {{ MY }}: 5 and higher
* {{ CH }}: 23 and higher
* {{ RD }}/{{ VLK }} (non-sharded clusters only): 6 and higher
* {{ MG }}: 6 and higher
* [{{ mtr-full-name }}](../../managed-trino/) (currently at the [Preview](../../overview/concepts/launch-stages.md) stage): 454 and higher
* {{ GP }}: 6 and higher

## GUI {#user-interface}

To work with {{ websql-full-name }}, use:

* _Control panel_: Far-left panel with icons for ![image](../../_assets/console-icons/folder-tree.svg) **Connections**, ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries**, and ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg) **Query history**.
* _Connections_: Panel for viewing existing database connections and adding new ones.
* _Data panel_: Far-right panel where you can build queries and view the results of their execution, as well as view connection settings and DB object information.

In the {{ websql-full-name }} interface, the URL of the current page automatically includes the IDs of the {{ websql-full-name }} entities you open. This enables you to share a direct link to a cluster, connection, database, saved query, or historical query in {{ websql-full-name }} with other users.

> For example, while using {{ websql-full-name }}, you saved a query and want to share it with another user. To do this, go to the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section, select the query you need, and copy its URL from the address bar. 
> The URL will look like this:
> ```
> https://websql.yandex.cloud/folders/<your_folder_ID>/saved-queries/<saved_query_ID>`
> ```
> This link will take the user directly to the page with the saved query in {{ websql-full-name }}.

## Connections {#connection}

In {{ websql-full-name }}, you can create, use, and manage DB connections. In the ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section, you can work with the following types of connections:
* [Connections to {{ yandex-cloud }} clusters](../operations/create-connection.md#connect-cluster): Connections to databases in managed database clusters via the {{ yandex-cloud }} internal network. Such clusters do not necessarily have to be publicly available.
* [External connections](../operations/create-connection.md#connect-db): Connections to public databases over the internet.

The **{{ yandex-cloud }} connections** subsection automatically displays {{ PG }}, {{ CH }}, {{ MY }}, {{ RD }}/{{ VLK }}, {{ MG }}, {{ mtr-full-name }}, and {{ GP }} clusters from the current folder if the user has access to them. You can select a different folder in the bar above the **Connections** section. The list of clusters will update automatically.

Connections to databases within a single managed database cluster are grouped into an expandable list under the name of that cluster. You cannot change this name in {{ websql-full-name }} but you can update the cluster name in the managed database service. The ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section will automatically show this update. 

External connections are not grouped together even if they share the same DB host address.

{{ websql-full-name }} also supports integration with [{{ metadata-hub-full-name }}](../../metadata-hub/index.yaml) at the user folder level. Connections created in {{ websql-full-name }} automatically appear in {{ metadata-hub-full-name }} {{ connection-manager-name }} and vice versa.

You can also [edit connection settings](../operations/connect.md#change-connection-settings) and [delete connections you no longer need](../operations/connect.md#delete-connection). After you connect to a DB, you can [monitor schemas, tables, and views](../operations/view-db-objects-info.md) (`VIEW`). Tables and views within one connection are grouped together. Grouping of views is available if there is at least one view in the DB.

## Queries {#queries}

For each database, you can run queries using tooltips: start typing a query command and select the suitable one from the drop-down list. You can also use ready-made _templates_ or [save your queries](../operations/templates.md#save-query) as [custom templates](#saved-queries). 

[Query history](#query-log) allows you to [see](../operations/history.md) and repeat your previous queries.

To learn more about running queries, see [this guide](../operations/query-executor.md).

## Saved queries {#saved-queries}

A _saved query_ is a query saved as a template. You can save any query. It will appear in the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section on the control panel.

To learn more about using saved queries, see [this guide](../operations/templates.md).

## Historical queries {#query-log}

_Historical queries_ are queries executed in your {{ yandex-cloud }} [organization](../../organization/concepts/organization.md) within the current connection session. They are displayed in the ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg) **Query history** section. Next to each query, you can find its status:

* ![image](../../_assets/websql/success.svg): Query executed successfully.
* ![image](../../_assets/websql/error.svg): Query execution failed.
* ![image](../../_assets/websql/unknown.svg): Unexpected error on the {{ websql-full-name }} side.

To learn more about handling historical queries, see [this guide](../operations/history.md).

