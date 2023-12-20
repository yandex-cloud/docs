# Executing SQL queries

{% include notitle [preview](../../_includes/note-preview.md) %}

## Running a query {#execute-query}

To perform a query to a database, [establish a connection](connect.md##connect-db) with this database first. If the connection is inactive, [activate](connect.md#update-connection) it.

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}

  {% note info %}

  A table with multiple rows might be difficult to view. Use the `LIMIT` condition and extra conditions to cap the number of displayed rows.

  {% endnote %}

You can view your executed queries [in the query history](history.md) and [save them as templates](templates.md).

## Exporting query execution results {#export-results}

To save the results in a format you like:

1. Click **Export** in the top-right corner of the panel with the results table.
1. Select the appropriate format: `JSON`,`CSV`, or `TSV`.

A file with the results will be added to your browser's downloads section.

## Setting up the query editor {#sql-editor-settings}

{{ websql-full-name }} enables you to quickly edit your queries, including with features, such as context help or SQL syntax and error highlighting. To manage these features:

1. Click **Settings** (![image](../../_assets/console-icons/gear.svg)) in the bottom-left corner.
1. Go to the **Query editor** section.
1. Set up the options that enable you to use the editing features.