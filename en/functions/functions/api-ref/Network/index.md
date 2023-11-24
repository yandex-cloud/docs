---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/index.md
---

# Cloud Functions Service, REST: Network methods
A set of methods for managing VPC networks connected to serverless resources.

## Methods {#methods}
Method | Description
--- | ---
[getUsed](getUsed.md) | Returns the specified network used in serverless resources.
[listConnectedResources](listConnectedResources.md) | Retrieves the list of serverless resources connected to any network from the specified scope.
[listUsed](listUsed.md) | Retrieves the list of networks in the specified scope that are used in serverless resources.
[triggerUsedCleanup](triggerUsedCleanup.md) | Forces obsolete used network to start cleanup process as soon as possible. Invocation does not wait for start or end of the cleanup process. Second invocation with the same network does nothing until network is completely cleaned-up.