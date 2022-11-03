# Terms and definitions

## Database {#database}

[{{ ydb-short-name }} database](https://ydb.tech/en/docs/concepts/databases#database) in {{ ydb-name }} can be [created](../operations/manage-database.md#create-db) in the Serverless configuration or with Dedicated servers. For more information about differences in configurations, see [Serverless and Dedicated modes](serverless-and-dedicated.md).

### Serverless database {#serverless}

Computing resources for serverless YDB databases in {{ ydb-name }} are provided automatically for database query purposes. The payment amount depends on the CPU capacity actually used and the I/O operations required to execute the database query. The amount of data stored in the database is paid additionally.

### Database on dedicated resources {#resource-presets}

A {{ ydb-name }} database is provided on VMs running on platforms supported by {{ compute-full-name }}. For more information, see [{#T}](../../compute/concepts/vm-platforms.md).

The following VM configurations are available in {{ ydb-name }}:

| Platform | Configuration name | Number of vCPUs | Guaranteed vCPU performance | RAM, GB |
| ----- | ----- | ----- | ----- | ----- |
| **Intel Cascade Lake** | medium | 8 | 100% | 32 |
| **Intel Cascade Lake** | medium-m64 | 8 | 100% | 64 |
| **Intel Cascade Lake** | medium-m96 | 8 | 100% | 96 |

Databases run on allocated computing resources are paid on an hourly basis. The amount of data storage for the database is paid additionally (see [Storage groups](#storage-groups) below).

## Cluster {#cluster}

A {{ ydb-short-name }} cluster is a set of {{ ydb-short-name }} nodes that the load is distributed across.

Cluster maintenance is a prerogative of the {{ ydb-name }} team, so application developers can interact directly with the {{ ydb-short-name }} database.

For more information about {{ ydb-short-name }} clusters, see the [documentation](https://ydb.tech/en/docs/concepts/databases#cluster).

## Storage groups {#storage-groups}

{{ ydb-full-name }} uses 3 disks in each of the 3 availability zones, both for databases on dedicated resources and serverless databases. This configuration ensures stability even if a zone or disk fails. It also provides a redundancy factor of 3.

For more information about {{ ydb-short-name }} storage groups, see the [documentation](https://ydb.tech/en/docs/concepts/databases#storage-groups).

## Regions and availability zones {#regions-az}

{{ ydb-name }} databases are located in three availability zones in the `{{ region-id }}` region in central Russia. {{ ydb-name }} ensures that databases are fully available even if an availability zones fails.

For more information about the geo scope of {{ yandex-cloud }}, see [{#T}](../../overview/concepts/geo-scope.md).
