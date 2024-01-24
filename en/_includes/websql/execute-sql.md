To build a query:
1. In the **Connection manager**, select the database and table.
1. In the data panel, you will see a form with the default query:

   ```sql
   SELECT * FROM <table_name> LIMIT 10;
   ```
1. Use this query or edit it. The interface will suggest relevant parts of the SQL query and highlight errors.
1. Click **Execute**.

In the results panel, you will see a table with the query results.

When editing or running a query, you can use the following keyboard shortcuts (click ![image](../../_assets/websql/questionmark.svg) to see the full list):

{% list tabs group=operating_system %}

- Windows/Linux {#window-linux}

   * Show suggestions: **Ctrl** + **I** , **Ctrl** + **Space**.
   * Comment out a line: **Ctrl** + **/**.
   * Run a query: **Ctrl** + **Enter**.

- macOS {#macos}

   * Show suggestions: **⌘** + **I** , **⌃** + **Space**.
   * Comment out a line: **⌘** + **/**.
   * Run a query: **⌘** + **⏎**.

{% endlist %}
