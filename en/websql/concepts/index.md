# About {{ websql-full-name }}

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

{{ websql-full-name }} is a {{ yandex-cloud }} service that allows you to connect to clusters of managed databases, work with databases, tables, and schemas, and execute SQL queries. The service operates in your browser and offers convenient suggestions for SQL query execution.

## User interface

To work with {{ websql-full-name }}, use:

* _Control panel_ is the far-left panel with icons for **Connection manager** ![image](../../_assets/websql/connections.svg), **Saved queries** ![image](../../_assets/websql/template.svg), and **Query history** ![image](../../_assets/websql/history.svg).
* _Connection manager_ is a panel for viewing existing and adding new database connections.
* _Data panel_ is the far-right panel where you can build SQL queries and view the results of their execution and the connection settings.

## Connection manager {#connection}

In {{ websql-full-name }}, you can establish, update database connections and monitor their status. Database connections with the same URL and port number constitute _connection groups_. You can edit connection settings, rename or delete groups. Once you establish a connection with the database, you can view tables, schemas, and `views`.

The connection manager supports operations with [demo connections](../operations/connect.md#demo) which are pre-established connections with test databases that allow you to explore the {{ websql-full-name }} features.

## SQL queries {#tables}

For each database, you can use suggestions to explore various paths of SQL query execution: start typing a query command and choose a suitable option from the list. You can also use ready-made _templates_ or save your queries as _custom query templates_.

The _query history_ allows you to see your previous queries and repeat them.