---
editable: false
---

# Key Management Service API: gRPC reference

Actions are performed by making RPC calls. For more information about API architecture, see [API Concepts](/docs/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/kms/v1/asymmetricencryption).

#|
||Service | Description | Service URL ||
|| [AsymmetricEncryptionCrypto](AsymmetricEncryptionCrypto/index.md) | Set of methods that perform asymmetric decryption. | `{{ api-host-kms-symcrypto }}:443` ||
|| [AsymmetricEncryptionKey](AsymmetricEncryptionKey/index.md) | Set of methods for managing asymmetric KMS keys. | `{{ api-host-kms }}:443` ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. | `operation.{{ api-host }}:443` ||
|#