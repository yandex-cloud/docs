---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Resource/index.md
---

# Cloud Backup API, gRPC: ResourceService

A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os).

## Methods

#|
||Method | Description ||
|| [List](list.md) | List resources: Compute Cloud instances. ||
|| [Get](get.md) | Get specific Compute Cloud instance. ||
|| [Delete](delete.md) | Delete specific Compute Cloud instance from Cloud Backup. It does not delete ||
|| [ListTasks](listTasks.md) | List tasks of resources. ||
|| [ListDirectory](listDirectory.md) | ListDirectory returns all subdirectories found in requested directory identified ||
|| [CreateDirectory](createDirectory.md) | CreateDirectory creates new directory by requested path. ||
|| [ListOperations](listOperations.md) | ListOperations return all operations in backup service for given instance ||
|| [GetInstanceRegistrationToken](getInstanceRegistrationToken.md) | Get instance registration token to install backup agent withot SA attached to instance ||
|#