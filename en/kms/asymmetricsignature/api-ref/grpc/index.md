---
editable: false
---

# Key Management Service API: gRPC reference

Actions are performed by making RPC calls. For more information about API architecture, see [API Concepts](/docs/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/kms/v1/asymmetricsignature).

#|
||Service | Description | Service URL ||
|| [AsymmetricSignatureCrypto](AsymmetricSignatureCrypto/index.md) | Set of methods that perform asymmetric signature. | `{{ api-host-kms-symcrypto }}:443` ||
|| [AsymmetricSignatureKey](AsymmetricSignatureKey/index.md) | Set of methods for managing asymmetric signature keys. | `{{ api-host-kms }}:443` ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. | `operation.{{ api-host }}:443` ||
|#