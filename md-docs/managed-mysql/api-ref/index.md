# Managed Service for MySQL API: REST reference

This API reference is organized by resource. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts](../../api-design-guide/index.md).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/mysql/v1).

**Service URL**: `https://mdb.api.cloud.yandex.net`

#|
||Service | Description ||
|| [Backup](Backup/index.md) | A set of methods for managing MySQL backups.

See [the documentation](../operations/cluster-backups.md) for details. ||
|| [Cluster](Cluster/index.md) | A set of methods for managing MySQL clusters. ||
|| [Database](Database/index.md) | A set of methods for managing MySQL databases in a cluster.

See [the documentation](../operations/databases.md) for details. ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. ||
|| [ResourcePreset](ResourcePreset/index.md) | A set of methods for managing MySQL resource presets.

See [the documentation](../concepts/instance-types.md) for details. ||
|| [User](User/index.md) | A set of methods for managing MySQL users.

See [the documentation](../operations/cluster-users.md) for details. ||
|#