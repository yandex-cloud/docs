# Concepts {{ kms-name }}

{{ kms-name }} is a service for creating and managing encryption keys in Yandex.Cloud. Using it, you can manage access rights for encryption keys, enable rotation of cryptographic material, and encrypt data. At the Preview stage, you can only create symmetric keys.

The service lets you manage _keys_ and their _versions_.

## Keys {#key}

A key is a set of versions of cryptographic material that can be used to encrypt or decrypt data.

Each key has the following characteristics:

* The primary version that is used if the encryption or decryption request omits the key version.
* The encryption algorithm. Each new version of the key uses the selected algorithm: AES-128, AES-192, or AES-256 (in AES-GCM mode).
* Rotation period: the amount of time between automatic key rotations.

### Rotation {#rotation}

_Rotation_ is the generation of a new key version that immediately becomes the primary version. You can rotate manually or automatically by setting the key rotation period.

Rotation is the only way to create a new key version. If you want to use the new version by default, [make another version primary](../operations/version.md#make-primary).

## Version {#version}

Key versions are the cryptographic material that you can use for encrypting and decrypting data. Every key has a default version to be used if a request omits the version. You can't destroy the default version.

For any other key version, you can schedule destruction: after the specified period, {{kms-name}} permanently destroys the version and you can no longer use it for encrypting data.

{% note alert %}

If you destroy a key version, you can't decrypt any data encrypted with it: destroying a version is practically the same as deleting the data.

{% endnote %}

