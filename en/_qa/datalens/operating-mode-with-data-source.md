### Which mode of accessing a data source is faster: direct access or materialization? {#operating-mode-with-data-source}

Materialization is usually faster. The speed depends on the data structure, query, and your database resources.

For example, if you have a heavily loaded transactional {{ PG }} database and you use representation on multiple linked tables in {{ datalens-short-name }}, materialization can significantly outperform direct access.

