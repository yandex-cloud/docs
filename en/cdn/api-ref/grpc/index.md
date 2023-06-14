---
sourcePath: en/_api-ref-grpc/cdn/api-ref/grpc/index.md
---
# Cloud CDN API: gRPC reference
This API reference is organized around CDN resources. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

See the interface definitions of the API on [GitHub](https://github.com/yandex-cloud/cloudapi).

Service | Description
--- | ---
[CacheService](./cache_service.md) | A set of methods for managing Cache Service resources.
[OriginGroupService](./origin_group_service.md) | Origin Groups management service.
[OriginService](./origin_service.md) | Origin management service. Origin is not a standalone entity. It can live only within origin group.
[ProviderService](./provider_service.md) | A set of methods for managing Provider Service resources.
[RawLogsService](./raw_logs_service.md) | 
[ResourceService](./resource_service.md) | Provider's resources management service.
[OperationService](./operation_service.md) | A set of methods for managing operations for asynchronous API requests.
