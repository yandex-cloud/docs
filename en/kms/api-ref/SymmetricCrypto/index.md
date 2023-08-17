---
editable: false
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricCrypto/index.md
---

# Key Management Service API, REST: SymmetricCrypto methods
Set of methods that perform symmetric encryption and decryption.

## Methods {#methods}
Method | Description
--- | ---
[decrypt](decrypt.md) | Decrypts the given ciphertext with the specified key.
[encrypt](encrypt.md) | Encrypts given plaintext with the specified key.
[generateDataKey](generateDataKey.md) | Generates a new symmetric data encryption key (not a KMS key) and returns the generated key as plaintext and as ciphertext encrypted with the specified symmetric KMS key.
[reEncrypt](reEncrypt.md) | Re-encrypts a ciphertext with the specified KMS key.