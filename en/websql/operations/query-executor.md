# Executing SQL queries

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

To perform a query to a database, [establish a connection](connect.md##connect-db) with this database first. If the connection is inactive, [activate](connect.md#update-connection) it.

To build a query:
1. In the **Connection manager**, select the database and table.
1. On the data panel, you will see a form with the default query:

   ```sql
   SELECT * FROM <table_name> LIMIT 10;
   ```

1. Use this query or edit it. The interface will suggest relevant parts of the SQL query and highlight errors.
1. Click **Execute**

In the results panel, you will see a table with the query results.

  {% note info %}

  A table with multiple rows might be difficult to view. Use the `LIMIT` condition and extra conditions to cap the number of displayed rows.

  {% endnote %}

You can view your executed queries [in the query history](history.md) and [save them as templates](templates.md).
