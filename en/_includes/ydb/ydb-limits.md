#### Quotas {#ydb-quotas}

**Dedicated instance mode**

#|
|| Type of limit | Default value ||
|| Total number of CPU cores for all database hosts per cloud
`ydb.dedicatedComputeCores.count` | 64 ||
|| Total virtual memory for all database hosts per cloud
`ydb.dedicatedComputeMemory.size` | 256 GB ||
|| Maximum number of hosts per cloud
`ydb.dedicatedComputeNodes.count` | 8 ||
|| Maximum number of databases per cloud
`ydb.dedicatedDatabases.count` | 4 ||
|| Maximum number of storage groups per cloud
`ydb.dedicatedStorageGroups.count` | 8 ||
|#

**Serverless mode**

#|
|| Type of limit | Default value ||
|| Maximum number of databases
`ydb.serverlessDatabases.count` | 4 ||
|| Maximum number of serverless request units per second, per cloud
`ydb.serverlessRequestUnitsPerSecond.count` | 1,000 RUs ||
|| Maximum number of schema operations^*^ per day in a single serverless database
`ydb.schemaOperationsPerDay.count` | 1,000 ||
|| Maximum number of schema operations^*^ per minute in a single serverless database
`ydb.schemaOperationsPerMinute.count` | 30 ||
|| Total storage size of serverless databases
`ydb.serverlessStorage.size` | 300 GB ||
|| Number of {{ yds-name }} shards in a serverless database
`ydb.dataStreamShards.count` | 100 ||
|| Number of billable request units per second in serverless mode
`ydb.serverlessProvisionedCapacity.count` | 1,000 ||
|#

^*^Operations with quotas: creating, updating, and deleting table schemas, getting a table description, getting a list of tables, and creating and deleting directories.
