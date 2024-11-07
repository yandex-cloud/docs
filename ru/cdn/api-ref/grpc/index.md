---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/index.md
---

# Cloud CDN API: gRPC reference

This API reference is organized around CDN resources. Actions are performed by making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/cdn/v1).

**Service URL**: `https://cdn.{{ api-host }}`

#|
||Service | Description ||
|| [Cache](Cache/index.md) | A set of methods for managing Cache Service resources. ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. ||
|| [OriginGroup](OriginGroup/index.md) | Origin Groups management service. ||
|| [Origin](Origin/index.md) | Origin management service.
Origin is not a standalone entity. It can live only within origin group. ||
|| [Provider](Provider/index.md) | A set of methods for managing Provider Service resources. ||
|| [RawLogs](RawLogs/index.md) |  ||
|| [ResourceRules](ResourceRules/index.md) | Rules management service.

Used for Resources Rules management. ||
|| [Resource](Resource/index.md) | Provider's resources management service. ||
|#