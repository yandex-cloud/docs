{% note warning %}

Neuroanalyst can make mistakes. Always check its suggestions for validity.

{% endnote %}

## Generating database queries {#db-query}

Neuroanalyst can generate SQL queries based on natural language descriptions, for example:

> Find all users who have not placed any orders in the last 30 days.

> Create a test table named `test` and populate it with 10 entries.

Queries follow the syntax and structure of the database you select.


Neuroanalyst does not execute SQL queries. Execute them using one of these methods:

* Click **Execute query** below the generated SQL query. This will automatically execute the query in SQL Editor.
* Copy the query from Neuroanalyst’s response and execute it manually.


## Fixing and optimizing database queries {#db-query-optimization}

Neuroanalyst can [fix](#query-fix) and [optimize](#query-opt) SQL queries from SQL Editor based on the syntax and structure of the database you select. You can also fix and optimize other SQL queries to the selected database by forwarding them directly into the chat.

### Fixing {#query-fix}

1. Select the required connection from the list in the SQL Editor.
1. In the top panel, click ![sparkles-fill](../../../_assets/console-icons/sparkles-fill.svg) **Help me prompt**. This will open the Neuroanalyst window.
1. Type `Fix errors in this query` and click ![arrow-up](../../../_assets/console-icons/arrow-up.svg).

   Neuroanalyst can help you fix an SQL query from SQL Editor. If there is no query in the editor, Neuroanalyst will prompt you to enter the SQL query you want to fix.

### Optimizing {#query-opt}

1. Select the required connection from the list in the SQL Editor.
1. In the top panel, click ![sparkles-fill](../../../_assets/console-icons/sparkles-fill.svg) **Help me prompt**. This will open the Neuroanalyst window.
1. In the Neuroanalyst window, click the suggested message: `Optimize SQL query`.

   Neuroanalyst can help you optimize an SQL query from SQL Editor. If there is no query in the editor, Neuroanalyst will prompt you to enter the SQL query you want to optimize.

### Database overview {#db-overview}

Neuroanalyst helps with database overviews.

1. Select the required connection from the list in the SQL Editor.
1. In the top panel, click ![sparkles-fill](../../../_assets/console-icons/sparkles-fill.svg) **Help me prompt**. This will open the Neuroanalyst window.
1. In the Neuroanalyst window, click the suggested message: `Review current database`.

   Neuroanalyst will overview the selected database.
