---
editable: false
---

# Key Management Service API: REST reference

This API reference is organized by resource. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts](/docs/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/kms/v1/asymmetricencryption).

#|
||Service | Description | Service URL ||
|| [AsymmetricEncryptionCrypto](AsymmetricEncryptionCrypto/index.md) | Set of methods that perform asymmetric decryption. | `https://{{ api-host-kms-symcrypto }}` ||
|| [AsymmetricEncryptionKey](AsymmetricEncryptionKey/index.md) | Set of methods for managing asymmetric KMS keys. | `https://{{ api-host-kms }}` ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. | `https://operation.{{ api-host }}` ||
|#