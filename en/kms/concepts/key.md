# Key in {{ kms-short-name }}

A key is a set of [versions](version.md), each of which defines an algorithm and cryptographic material for data encryption or decryption operations.
The key is created along with its first version, which becomes the primary one. It's used by default in key operations unless you specify a different version in the input parameters.
When [rotating keys](version.md#rotate-key), the parameters of new versions are inherited from the key parameters.

You can change the primary version of the key at any time by specifying any previous version. For additional security of your data, rotate keys regularly and use previous versions only to decrypt data. This limits the lifetime of cryptographic material.

## Key parameters {#parameters}

A {{ kms-short-name }} key may have the following parameters:
* ID: A unique key identifier in {{ yandex-cloud }}. It's used for working with keys via the SDK, API, and CLI.
* Name: The key name. It's non-unique and can be used to work with keys in the CLI if the folder only contains a single key with this name.
* Encryption algorithm: The algorithm to be used for encryption in new versions of the key. The following symmetric encryption algorithms are supported in [GCM](https://en.wikipedia.org/wiki/Galois/Counter_Mode) mode:
   * `AES-128`: The AES algorithm with 128-bit keys.
   * `AES-192`: The AES algorithm with 192-bit keys.
   * `AES-256`: The AES algorithm with 256-bit keys.
      *`AES-256 HSM`: The AES algorithm with 256-bit keys. Encryption keys are created and cryptographic operations handled in a [Hardware Security Module (HSM)](hsm.md).

* Rotation period: The amount of time between automatic key rotations.
* Status: The current state of the key. Possible statuses:
   * `Creating`: The key is being created.
   * `Active`: The key can be used for encryption and decryption.
   * `Inactive`: The key can't be used.

   You can change the key status using the [update](../api-ref/SymmetricKey/update) method.

## Using a key {#use}

Created keys can be used in data encryption and decryption operations if certain [roles](../security/index.md#roles-list). You can temporarily disable operations with a key by revoking roles or changing its status to `Inactive`. For more information, see [{#T}](../security/index.md).

## Destroying a key {#delete}

If you delete a key or its parent resource (folder or cloud), this destroys the cryptographic material contained in it. After that, you won't be able to decrypt the data encrypted with that key.
