---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/index.md
---

# Cloud Backup API: REST reference

This API reference is organized around Cloud Backup resources. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/backup/v1).

**Service URL**: `https://backup.{{ api-host }}`

#|
||Service | Description ||
|| [Backup](Backup/index.md) | A set of methods for managing [backups](/docs/backup/concepts/backup). ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. ||
|| [Policy](Policy/index.md) | A set of methods for managing [policies](/docs/backup/concepts/policy). ||
|| [Provider](Provider/index.md) | A set of methods for managing [backup providers](/docs/backup/concepts/#providers). ||
|| [Resource](Resource/index.md) | A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os). ||
|#