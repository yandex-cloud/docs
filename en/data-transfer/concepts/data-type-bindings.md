# Data type conversions

Different DBMS systems can act as sources and as targets in {{ data-transfer-full-name }}. Since the list of available data types for different DBMS may differ, {{ data-transfer-name }} converts one data type to another during a transfer.

This section describes the data type conversion rules as a function of the source and target DBMS systems.


{% list tabs %}

- {{ PG }}

   | PostgreSQL | MySQL | MongoDB | ClickHouse |
   |------------|-------|---------|------------|
   | type 1 |       |         |            |
   | type 2 |       |         |            |
   | type 3 |       |         |            |

- {{ MY }}

   | MySQL | PostgreSQL | MongoDB | ClickHouse |
   |------------|-------|---------|------------|
   | type 1 |       |         |            |
   | type 2 |       |         |            |
   | type 3 |       |         |            |

- {{ MG }}

   | MongoDB | MySQL | PostgreSQL | ClickHouse |
   |------------|-------|---------|------------|
   | type 1 |       |         |            |
   | type 2 |       |         |            |
   | type 3 |       |         |            |

{% endlist %}