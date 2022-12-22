# Connections

As a data source, you can use {{ datalens-short-name }} connections. The following connection types are supported:

* {{ CH }} over YT
* {{ CH }} over YDB
* {{ CH }}
* {{ GP }}
* {{ MS }}
* {{ MY }}
* Oracle Database
* {{ PG }}
* {{ ydb-full-name }}

To use a connection as a source:

1. [Create](../../operations/index.md#creating-connection) or select a connection to the data source. The ID of an existing connection is specified in the URL (see the [section](../../faq.md#how-to-find-object-id)).
1. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
1. In ChartEditor on the [Urls](../architecture.md#urls) tab, specify the ID of your connection {{ datalens-short-name }} and type the SQL query to retrieve the data from the connection. For example:

   ```js
   const {buildSource} = require('libs/sql/v1');
   
   module.exports = {
     sql: buildSource({
         // Specify relevant connection ID
         id: '0sa8m0z2vqgqz',
   
         // Type the query to retrieve the data from the connection (use the syntax of the DB you are connecting to)
         query: `
             select Category, sum(Profit)
             from samples.SampleLite
             group by Category
             order by Category
         `,
     })
   };
   ```

1. In the [JavaScript](../architecture.md#js) tab, use one of the methods of the `libs/sql/v1` module:

   * getRows: Getting values from `query`.
   * getColumns: Getting column names (fields from `query`).
   * GetMetadata: Getting the metadata (values from `query`, field names from `query`, data types).



