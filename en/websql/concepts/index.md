# About {{ websql-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

{{ websql-full-name }} is a {{ yandex-cloud }} service that allows you to connect to clusters of managed and public databases. You can view database tables and schemas, and run SQL queries. It is a web-based tool that simplifies writing SQL queries by suggesting prompts and commands.

## GUI {#user-interface}

To work with {{ websql-full-name }}, use:

* _Control panel_: Far-left panel with icons for **Connection manager** ![image](../../_assets/console-icons/folder-tree.svg), **Saved queries** ![image](../../_assets/console-icons/floppy-disk.svg), and **Query history** ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg).
* _Connection manager_: Panel for viewing existing database connections and adding new ones.
* _Data panel_: Far-right panel where you can build SQL queries and view the results of their execution, view connection settings and DB table information.

## Connection manager {#connection}

In {{ websql-full-name }}, you can establish, update database connections and monitor their status. Database connections with the same URL and port number constitute _connection groups_. You can edit connection settings, rename or delete groups. Once you establish a connection with the database, you can view tables, schemas, and `views`.

In the connection manager, you can work with different types of connections:
* [External connections](../operations/connect.md#connect-db): Connections to publicly available databases via the Internet.
* [{{ yandex-cloud }} cluster connections](../operations/connect.md#connect-cluster): Connections to clusters of managed databases through the internal Yandex Cloud network. Such databases do not necessarily have to be publicly available.
* [Demo connections](../operations/connect.md#demo) are pre-established connections with test databases you can use to explore {{ websql-full-name }} features.

There are groups of tables and views within a single connection. View grouping is available when there is at least one view in the database.

## SQL queries {#tables}

For each database, you can run SQL queries using tooltips: start typing a query command and select the suitable one from the list. You can also use ready-made _templates_ or save your queries as _custom templates_.

The _query history_ allows you to see your previous queries and repeat them.