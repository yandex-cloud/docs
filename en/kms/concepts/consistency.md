# Key consistency

Some operations are [eventually consistent](https://en.wikipedia.org/wiki/Eventual_consistency). The changes they produce take **up to three hours** to take effect. These operations include:

* Rotating keys (automatically and manually).
* Changing the primary version of a key.
* Changing the key status to `Inactive`.
* Scheduling a key version for destruction.
* Deleting a key.

The REST API methods [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt.md), [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt.md), [reEncrypt](../../kms/api-ref/SymmetricCrypto/reEncrypt.md) for the [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) resource and the gRPC API calls [SymmetricCryptoService/Encrypt](../../kms/api-ref/grpc/SymmetricCrypto/encrypt.md), [SymmetricCryptoService/Decrypt](../../kms/api-ref/grpc/SymmetricCrypto/decrypt.md), and [SymmetricCryptoService/ReEncrypt](../../kms/api-ref/grpc/SymmetricCrypto/reEncrypt.md) may not see the changes introduced by eventually consistent operations for up to three hours, e.g., encryption will use the old key version if rotation took place less than three hours ago.

[Strongly consistent](https://en.wikipedia.org/wiki/Strong_consistency) operations take effect without delay:
* Creating keys.
* Changing the key status to `Active`.
* Canceling scheduled key version destruction (the version status is `Scheduled For Destruction`).

{% note info %}

To quickly restrict access to a key, revoke the roles required to use the key for encrypting and decrypting data. For more information, see [{#T}](../security/index.md).

{% endnote %}

## Use cases {#examples}

* [{#T}](../tutorials/encrypt/cli-api.md)