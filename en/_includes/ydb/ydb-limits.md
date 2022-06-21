#### Quotas {#ydb-quotas}

**Dedicated instance mode**

| Type of limit | Default value |
| ----- | ----- |
| Total number of processor cores for all the database hosts in a cloud | 64 |
| Total virtual memory for all DBs per cloud | 256 GB |
| Maximum number of hosts per cloud | 8 |
| Maximum number of databases per cloud | 4 |
| Maximum number of storage groups per cloud | 8 |

**Serverless mode**

| Type of limit | Default value |
| ----- | ----- |
| Maximum number of databases | 4 |
| Maximum number of serverless queries per second per cloud | 1000 RU |
| Maximum number of schema operations^*^ per day per serverless database | 1000 |
| Maximum number of schema operations^*^ per minute per serverless database | 30 |

^*^Transactions for which there is a quota: creating, updating, and deleting table schemas, getting a table description, getting a list of tables, and creating and deleting directories.
