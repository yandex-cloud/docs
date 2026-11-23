### Opening a connection via SQL Editor {#open-connection}

You can open a connection in SQL Editor in two ways:

{% list tabs group=instructions %}

- Navigation panel

  1. In the left-hand panel, select ![image](../../../_assets/console-icons/terminal.svg) **SQL Editor**.
  1. From the list that opens, select the required connection.


- Connection page

  1. Open the required connection.
  1. In the top-right corner of the connection page, click **Open in SQL Editor**.

{% endlist %}

This will open a window for data operations and queries.


### Running a query {#execute-query}

To run an SQL query:

1. Select the required connection from the list in the SQL Editor.
1. In the data panel, enter your SQL query. The editor will highlight errors and provide auto-complete suggestions as you type.
1. Click **Execute**.

In the results panel, you will see a table with the query results.

You can use the following hotkeys when editing or running a query (click ![image](../../../_assets/console-icons/circle-question.svg) to view the full list):

{% list tabs group=operating_system %}

- Windows/Linux {#window-linux}

   * Display suggestions: **Ctrl** + **I**, **Ctrl** + **Space**.
   * Add a line comment: **Ctrl** + **/**.
   * Run the query: **Ctrl** + **Enter**.

- macOS {#macos}

   * Display suggestions: **⌘** + **I** , **⌃** + **Space**.
   * Add a line comment: **⌘** + **/**.
   * Run the query: **⌘** + **⏎**.

{% endlist %}

#### Viewing table contents without an SQL query {#view-table}

To get contents of a table or view without an SQL query, select the object in the connection structure. The editor will run a query automatically:

```sql
SELECT * FROM <table_name> LIMIT 100
```

### Pagination {#pagination}

You can use pagination in SQL Editor to manage result outputs. With pagination, you can:

* Switch between pages:
  * ![](../../../_assets/console-icons/chevrons-left.svg): First page.
  * ![](../../../_assets/console-icons/chevron-left.svg): Previous page.
  * ![](../../../_assets/console-icons/chevron-right.svg): Next page.
  * ![](../../../_assets/console-icons/chevrons-right.svg): Last page.

* Select the number of rows displayed per page. To do this, click the field with the number of rows (between the arrows) and select the appropriate limit.

* Get the total number of rows by clicking **Total rows**.

Each action you take with pagination re-runs the query and is logged in the query history.

### Multi-queries {#multiple-queries}

SQL Editor supports multi-queries, enabling you to run multiple queries as a single batch.

Multi-query example:

```sql
SELECT * FROM <table_1_name> LIMIT 10;
INSERT INTO <table_2_name>;
```

To run individual subqueries within a multi-query, highlight one or more subqueries and click **Run current query**. SQL Editor will display the progress status for each highlighted query.
