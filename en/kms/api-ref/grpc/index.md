---
editable: false
---

# Key Management Service API: gRPC reference

Actions are performed by making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/kms/v1).

#|
||Service | Description | Service URL ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. | `operation.{{ api-host }}:443` ||
|| [SymmetricCrypto](SymmetricCrypto/index.md) | Set of methods that perform symmetric encryption and decryption. | `{{ api-host-kms-symcrypto }}:443` ||
|| [SymmetricKey](SymmetricKey/index.md) | Set of methods for managing symmetric KMS keys. | `{{ api-host-kms }}:443` ||
|#