#### Quotas {#ydb-quotas}

**Dedicated instance mode**

| Type of limit | Default value |
----- | -----
| Total number of processor cores for all database hosts per cloud | 64 |
| Total virtual memory for all database hosts per cloud | 256 GB |
| Maximum number of hosts per cloud | 8 |
| Maximum number of databases per cloud | 4 |
| Maximum number of storage groups per cloud | 8 |

**Serverless mode**

| Type of limit | Default value |
----- | -----
| Maximum number of databases | 4 |
| Maximum number of serverless queries per second, per cloud | 1,000 RUs |
| Maximum number of schema operations^*^ per day, per serverless database | 1,000 |
| Maximum number of schema operations^*^ per minute, per serverless database | 30 |
| Total storage size of serverless databases | 300 GB |
| Number of {{ yds-name }} shards in a serverless database | 100 |

^*^Transactions with quotas: creating, updating, and deleting table schemas, getting a table description, getting a list of tables, and creating and deleting directories.
