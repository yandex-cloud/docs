---
editable: false
---

# Key Management Service API: REST reference

This API reference is organized by resource. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/kms/v1).

#|
||Service | Description | Service URL ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. | `https://operation.{{ api-host }}` ||
|| [SymmetricCrypto](SymmetricCrypto/index.md) | Set of methods that perform symmetric encryption and decryption. | `https://{{ api-host-kms-symcrypto }}` ||
|| [SymmetricKey](SymmetricKey/index.md) | Set of methods for managing symmetric KMS keys. | `https://{{ api-host-kms }}` ||
|#