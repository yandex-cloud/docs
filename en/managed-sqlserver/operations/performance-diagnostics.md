# Performance diagnostics

{{ mms-name }} uses the built-in {{ MS }} [performance diagnostic tools](https://docs.microsoft.com/en-us/sql/relational-databases/performance/query-store-usage-scenarios).

## Enabling statistics collection {#activate-stats-collector}

To begin gathering statistics, enable the [query store](https://docs.microsoft.com/en-us/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store):

1. [Connect to the {{ MS }}](../operations/connect.md#connection-ide) cluster.

1. Enable the query store using one of the methods below:

    {% list tabs %}

    - SQL

      Run the query below against the database:

      ```sql
      ALTER DATABASE <DB name>
      SET QUERY_STORE = ON (OPERATION_MODE = READ_WRITE);
      ```

    - SQL Server Management Studio
      1. Select a database in the **Object Explorer** window.
      1. Right-click and select **Properties**.
      1. Select the **Query Store** page.
      1. In the **Operation mode (requested)** box, select `Read Write`.
      1. Press **OK**.

    {% endlist %}

## Getting information about sessions and queries {#get-sessions-queries}

To view this data:

* [Run the SQL query](https://docs.microsoft.com/en-us/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store?view=sql-server-ver15#performance-auditing-and-troubleshooting) directly to the query store.
* Use [SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/relational-databases/performance/performance-dashboard?view=sql-server-ver15).
* Use [built-in stored procedures](sessions.md).
