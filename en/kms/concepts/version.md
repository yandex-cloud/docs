# Key version

Key version is the cryptographic material you can use for encrypting and decrypting data.

The following operations with key versions are supported:
* Creating versions when [rotating key](#rotate-key).

    The algorithm and size of a new version's cryptographic material are determined by the current key encryption algorithm.
* Using versions to encrypt and decrypt data.

    A key always has the primary version that is used by default in key operations. You can specify the version explicitly. In this case, the cryptographic material of the specified version is used. Directly or indirectly, all encryption and decryption operations in {{ kms-short-name }} use the cryptographic material contained in one of the versions.
* Destroying versions.

    You cannot destroy the primary version of a key.

Versions can have one of the following statuses:
* `Active`: The version is active and can be used for data encryption and decryption.
* `Scheduled For Destruction`: The version is scheduled for destruction. This means that it is already inactive, but you can still restore it if necessary.
* `Destroyed`: The version is destroyed and cannot be restored.

## Rotating keys {#rotate-key}

Rotation limits the lifetime of cryptographic material. When a key is rotated, a new version is created: cryptographic material is generated again (its parameters are determined by the algorithm specified in the key). The version of the key created during its rotation becomes the primary one. If necessary, you can specify any other active version of the key as the primary one.

After key rotation:
* Encryption operations use the new version of the key, unless you explicitly specify a different version.
* The previous key versions are only used to decrypt data encrypted by them before the key was rotated.

Rotation can be manual or automatic. This depends on the **{{ ui-key.yacloud.kms.symmetric-key.overview.label_rotation }}** key parameter.

## Destroying key versions {#version-distruct}

{% note alert %}

Destroying any version of a key means destroying all data encrypted with it. Before you destroy a version, make sure that there is no data encrypted with this version or that you really need to delete all the encrypted data.

{% endnote %}

To destroy previous key versions without negative consequences, use the [reEncrypt](../api-ref/SymmetricCrypto/reEncrypt) method. This operation decrypts the transmitted ciphertext and then re-encrypts it with the primary version of the key.

For safety reasons, destruction is not immediate. You can [schedule a version for destruction](../operations/version#delete) by setting the time to elapse before destruction. This will change the version's status to `Scheduled For Destruction`: it can no longer be used for encryption or decryption but still can be restored. When the destruction time comes, the version's status changes to `Destroyed` and it is permanently deleted.