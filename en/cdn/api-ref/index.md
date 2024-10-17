---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/index.md
---

# Cloud CDN API: REST reference

This API reference is organized around CDN resources. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

See the interface definitions of the API on [GitHub](https://github.com/yandex-cloud/cloudapi).

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