{% include [intro.md](_includes/databases/intro.md) %}

{% include [database.md](_includes/databases/database.md) %}

In Yandex.Cloud, the database is linked to a specific cloud folder. You can also use {{ ydb-short-name }}-based Serverless databases that don't allocate any resources to users, but share resources of their host {{ ydb-short-name }} database.

For a description of the procedure for obtaining a database in Yandex.Cloud, see ["Creating a database"](../operations/create_manage_database.md)

{% include [cluster.md](_includes/databases/cluster.md) %}

Cluster maintenance is a prerogative of the Yandex.Cloud team, so application developers can interact directly with the {{ ydb-short-name }} database.

{% include [regions.md](_includes/databases/regions.md) %}

{{ ydb-short-name }} cloud databases in Yandex.Cloud are provided in a geographically distributed region in central Russia (`ru-central1`) that has three availability zones. For more information about YC regions and availability zones, see [{#T}](../../overview/concepts/geo-scope.md). {% include [compute.md](_includes/databases/compute.md) %}

{% include [compute.md](_includes/databases/compute.md) %}

###  Yandex.Cloud {{ ydb-short-name }} DB on dedicated resources

Yandex.Cloud {{ ydb-short-name }} DB is provided on VMs that can be created on any platform supported by {{ compute-name }}. For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The following VM types are available:

| Platform | Computing resource | Number of vCPUs | Guaranteed vCPU performance | RAM, GB |
| ----- | ----- | ----- | ----- | ----- |
| **Intel Cascade Lake** | medium | 8 | 100% | 32 |
| **Intel Cascade Lake** | medium-m64 | 8 | 100% | 64 |
| **Intel Cascade Lake** | medium-m96 | 8 | 100% | 96 |

Databases run on allocated computing resources are paid on an hourly basis. The amount of data storage for the database is paid additionally (see [Storage groups](#storage-groups) below).

### Serverless {{ ydb-short-name }} database in Yandex.Cloud

Computing resources for serverless {{ ydb-short-name }} databases in Yandex.Cloud are provided automatically for database query purposes. The payment amount depends on the CPU capacity actually used and the I/O operations required to execute the database query. The amount of data stored in the database is paid additionally.

{% include [storage_groups.md](_includes/databases/storage_groups.md) %}

In cloud-based {{ ydb-short-name }} databases, Yandex.Cloud uses 3 disks in each of the 3 availability zones, both for databases on dedicated resources and serverless databases. This configuration ensures stability even if a zone or disk fails. It also provides a redundancy factor of 3.
