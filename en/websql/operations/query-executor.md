# Executing SQL queries

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

To perform a query to a database, [establish a connection](connect.md##connect-db) with this database first. If the connection is inactive, [activate](connect.md#update-connection) it.

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}

  {% note info %}

  A table with multiple rows might be difficult to view. Use the `LIMIT` condition and extra conditions to cap the number of displayed rows.

  {% endnote %}

You can view your executed queries [in the query history](history.md) and [save them as templates](templates.md).