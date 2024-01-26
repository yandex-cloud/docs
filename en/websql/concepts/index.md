# About {{ websql-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

{{ websql-full-name }} is a {{ yandex-cloud }} service that allows you to connect to clusters of managed databases, work with databases, tables, and schemas, and execute SQL queries. The service operates in your browser and offers convenient suggestions for SQL query execution.

## User interface

To work with {{ websql-full-name }}, use:

* _Control panel_ is the far-left panel with icons for **Connection manager** ![image](../../_assets/console-icons/folder-tree.svg), **Saved queries** ![image](../../_assets/console-icons/floppy-disk.svg), and **Query history** ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg).
* _Connection manager_ is a panel for viewing existing and adding new database connections.
* _Data panel_ is the far-right panel where you can build SQL queries and view the results of their execution, as well as connection settings, and information about DB tables.

## Connection manager {#connection}

In {{ websql-full-name }}, you can establish, update database connections and monitor their status. Database connections with the same URL and port number constitute _connection groups_. You can edit connection settings, rename or delete groups. Once you establish a connection with the database, you can view tables, schemas, and `views`.

In the connection manager, you can work with different types of connections:
* [External connections](../operations/connect.md#connect-db): Connections to publicly available databases via the Internet.
* [{{ yandex-cloud }} cluster connections](../operations/connect.md#connect-cluster): Connections to clusters of managed databases through the internal Yandex Cloud network. Such databases do not necessarily have to be publicly available.
* [Demo connections](../operations/connect.md#demo): Pre-established connections with test databases allowing you to explore the {{ websql-full-name }} features.

There are groups of tables and views within a single connection. View grouping is available when there is at least one view in the database.

## SQL queries {#tables}

For each database, you can use suggestions to explore various paths of SQL query execution: start typing a query command and choose a suitable option from the list. You can also use ready-made _templates_ or save your queries as _custom query templates_.

The _query history_ allows you to see your previous queries and repeat them.