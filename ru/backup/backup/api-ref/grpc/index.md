---
sourcePath: en/_api-ref-grpc/backup/backup/backup/api-ref/grpc/index.md
---
# Cloud Backup API: gRPC reference
This API reference is organized around Cloud Backup resources. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

See the interface definitions of the API on [GitHub](https://github.com/yandex-cloud/cloudapi).

Service | Description
--- | ---
[BackupService](./backup_service.md) | A set of methods for managing [backups](/docs/backup/concepts/backup).
[PolicyService](./policy_service.md) | A set of methods for managing [policies](/docs/backup/concepts/policy).
[ProviderService](./provider_service.md) | A set of methods for managing [backup providers](/docs/backup/concepts/#providers).
[ResourceService](./resource_service.md) | A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os).
[OperationService](./operation_service.md) | A set of methods for managing operations for asynchronous API requests.
