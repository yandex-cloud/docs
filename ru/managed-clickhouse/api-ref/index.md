---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/index.md
---

# Managed Service for ClickHouse API: REST reference

This API reference is organized by resource. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/clickhouse/v1).

**Service URL**: `https://{{ api-host-mdb }}`

#|
||Service | Description ||
|| [Backup](Backup/index.md) | A set of methods for managing ClickHouse Backup resources. ||
|| [Cluster](Cluster/index.md) | A set of methods for managing ClickHouse clusters. ||
|| [Database](Database/index.md) | A set of methods for managing ClickHouse Database resources.
NOTE: these methods are available only if database management through SQL is disabled. ||
|| [FormatSchema](FormatSchema/index.md) | A set of methods for managing [format schemas](https://clickhouse.com/docs/en/interfaces/formats) for input and output data. ||
|| [MlModel](MlModel/index.md) | A set of methods for managing machine learning models. ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. ||
|| [ResourcePreset](ResourcePreset/index.md) | A set of methods for managing ResourcePreset resources. ||
|| [User](User/index.md) | A set of methods for managing ClickHouse User resources.
NOTE: these methods are available only if user management through SQL is disabled. ||
|| [Versions](Versions/index.md) | A set of methods for managing ClickHouse versions. ||
|#