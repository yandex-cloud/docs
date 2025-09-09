# Working with the query editor

The query editor opens in the data panel when you select a database, a table, or a view in the ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section. 

## Running a query {#execute-query}

To perform a database query, [establish](create-connection.md#connect-db) or [activate](connect.md#update-connection) a connection with the database.

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}

You can view your executed queries [in query history](history.md) and [save them as templates](templates.md).

## Pagination {#pagination}

You can use pagination in the query editor to manage result outputs. With pagination, you can:

* Switch between pages:
  * ![](../../_assets/console-icons/chevrons-left.svg): First page
  * ![](../../_assets/console-icons/chevron-left.svg): Previous page
  * ![](../../_assets/console-icons/chevron-right.svg): Next page
  * ![](../../_assets/console-icons/chevrons-right.svg): Last page

* Select the number of rows displayed per page. To do this, click the field with the number of rows (between the arrows) and select the appropriate limit.

* Get the total number of rows by clicking **Total rows**.

Each action you take with pagination re-runs the query and is logged in the [query history](../concepts/index.md#query-log).

## Multi-queries {#multiple-queries}

In the query editor, you can use multi-queries, enabling you to run multiple queries as a single batch. These queries are executed within a single database session.

Multi-query example:

```sql
SELECT * FROM <table_1_name> LIMIT 10;
INSERT INTO <table_2_name>;
```

To run individual subqueries within a multi-query, highlight one or more subqueries and click **Run current query**. The editor will display the progress status of the highlighted queries.

## Exporting query execution results {#export-results}

To save the results in a format you like:

1. Click **Export** in the top-right corner of the panel with the results table.
1. Select the format: `JSON`,`CSV` or `TSV`.

A file with the results will be added to your browser's downloads section.

## Setting up the query editor {#sql-editor-settings}

{{ websql-full-name }} enables you to quickly edit your queries, including with features, such as context help or SQL syntax and error highlighting. To manage these features: 

1. Click ![image](../../_assets/console-icons/gear.svg) **Settings** in the bottom-left corner.
1. Go to the **Query editor** section. 
1. Customize the editor theme (`Visual Studio` or `High Contrast`), font size and type, and the following editing feature options:
   * Editor tips
   * Syntax highlighting
   * Error highlighting
   * Editor minimap
   * Autoclosing of quotes
   * Autoclosing of parentheses

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
