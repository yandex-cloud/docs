# Working with the query editor

The query editor opens in the data panel when you select a database, a table, or a view in the ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section.

## Running a query {#execute-query}

To perform a database query, [establish](create-connection.md#connect-db) or [activate](connect.md#update-connection) a connection with the database.

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}

{% note info %}

A table with multiple rows may be difficult to view. Use the `LIMIT` condition and extra conditions to cap the number of displayed rows.

{% endnote %}

You can view your executed queries [in query history](history.md) and [save them as templates](templates.md).

## Exporting query execution results {#export-results}

To save the results in a format you like:

1. Click **Export** in the top-right corner of the panel with the results table.
1. Select the appropriate format: `JSON`,`CSV`, or `TSV`.

A file with the results will be added to your browser's downloads section.

## Setting up the query editor {#sql-editor-settings}

{{ websql-full-name }} enables you to quickly edit your queries, including with features, such as context help or SQL syntax and error highlighting. To manage these features:

1. Click ![image](../../_assets/console-icons/gear.svg) **Settings** in the bottom-left corner.
1. Go to the **Query editor** section.
1. Set up the editor theme (`Visual Studio` or `High Contrast`), font size and type, and the editing features:
   * Editor tips
   * Syntax highlighting
   * Error highlighting
   * Editor minimap
   * Autoclosing of quotes
   * Autoclosing of parentheses