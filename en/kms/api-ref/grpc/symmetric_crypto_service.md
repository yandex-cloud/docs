---
editable: false
sourcePath: en/_api-ref-grpc/kms/api-ref/grpc/symmetric_crypto_service.md
---

# SymmetricCryptoService

Set of methods that perform symmetric encryption and decryption.

| Call | Description |
| --- | --- |
| [Encrypt](#Encrypt) | Encrypts given plaintext with the specified key. |
| [Decrypt](#Decrypt) | Decrypts the given ciphertext with the specified key. |
| [ReEncrypt](#ReEncrypt) | Re-encrypts a ciphertext with the specified KMS key. |
| [GenerateDataKey](#GenerateDataKey) | Generates a new symmetric data encryption key (not a KMS key) and returns the generated key as plaintext and as ciphertext encrypted with the specified symmetric KMS key. |

## Calls SymmetricCryptoService {#calls}

## Encrypt {#Encrypt}

Encrypts given plaintext with the specified key.

**rpc Encrypt ([SymmetricEncryptRequest](#SymmetricEncryptRequest)) returns ([SymmetricEncryptResponse](#SymmetricEncryptResponse))**

### SymmetricEncryptRequest {#SymmetricEncryptRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key to use for encryption. The maximum string length in characters is 50.
version_id | **string**<br>ID of the key version to encrypt plaintext with. Defaults to the primary version if not specified. The maximum string length in characters is 50.
aad_context | **bytes**<br>Additional authenticated data (AAD context), optional. If specified, this data will be required for decryption with the [SymmetricDecryptRequest](#SymmetricDecryptRequest). Should be encoded with base64. The maximum string length in characters is 8192.
plaintext | **bytes**<br>Required. Plaintext to be encrypted. Should be encoded with base64. The maximum string length in characters is 32768.


### SymmetricEncryptResponse {#SymmetricEncryptResponse}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key that was used for encryption. The maximum string length in characters is 50.
version_id | **string**<br>ID of the key version that was used for encryption. The maximum string length in characters is 50.
ciphertext | **bytes**<br>Resulting ciphertext. 


## Decrypt {#Decrypt}

Decrypts the given ciphertext with the specified key.

**rpc Decrypt ([SymmetricDecryptRequest](#SymmetricDecryptRequest)) returns ([SymmetricDecryptResponse](#SymmetricDecryptResponse))**

### SymmetricDecryptRequest {#SymmetricDecryptRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key to use for decryption. The maximum string length in characters is 50.
aad_context | **bytes**<br>Additional authenticated data, must be the same as was provided in the corresponding [SymmetricEncryptRequest](#SymmetricEncryptRequest). Should be encoded with base64. The maximum string length in characters is 8192.
ciphertext | **bytes**<br>Required. Ciphertext to be decrypted. Should be encoded with base64. 


### SymmetricDecryptResponse {#SymmetricDecryptResponse}

Field | Description
--- | ---
key_id | **string**<br>ID of the symmetric KMS key that was used for decryption. 
version_id | **string**<br>ID of the key version that was used for decryption. 
plaintext | **bytes**<br>Decrypted plaintext. 


## ReEncrypt {#ReEncrypt}

Re-encrypts a ciphertext with the specified KMS key.

**rpc ReEncrypt ([SymmetricReEncryptRequest](#SymmetricReEncryptRequest)) returns ([SymmetricReEncryptResponse](#SymmetricReEncryptResponse))**

### SymmetricReEncryptRequest {#SymmetricReEncryptRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the new key to be used for encryption. The maximum string length in characters is 50.
version_id | **string**<br>ID of the version of the new key to be used for encryption. Defaults to the primary version if not specified. The maximum string length in characters is 50.
aad_context | **bytes**<br>Additional authenticated data to be required for decryption. Should be encoded with base64. The maximum string length in characters is 8192.
source_key_id | **string**<br>Required. ID of the key that the ciphertext is currently encrypted with. May be the same as for the new key. The maximum string length in characters is 50.
source_aad_context | **bytes**<br>Additional authenticated data provided with the initial encryption request. Should be encoded with base64. The maximum string length in characters is 8192.
ciphertext | **bytes**<br>Required. Ciphertext to re-encrypt. Should be encoded with base64. 


### SymmetricReEncryptResponse {#SymmetricReEncryptResponse}

Field | Description
--- | ---
key_id | **string**<br>ID of the key that the ciphertext is encrypted with now. 
version_id | **string**<br>ID of key version that was used for encryption. 
source_key_id | **string**<br>ID of the key that the ciphertext was encrypted with previously. 
source_version_id | **string**<br>ID of the key version that was used to decrypt the re-encrypted ciphertext. 
ciphertext | **bytes**<br>Resulting re-encrypted ciphertext. 


## GenerateDataKey {#GenerateDataKey}

Generates a new symmetric data encryption key (not a KMS key) and returns the generated key as plaintext and as ciphertext encrypted with the specified symmetric KMS key.

**rpc GenerateDataKey ([GenerateDataKeyRequest](#GenerateDataKeyRequest)) returns ([GenerateDataKeyResponse](#GenerateDataKeyResponse))**

### GenerateDataKeyRequest {#GenerateDataKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key that the generated data key should be encrypted with. The maximum string length in characters is 50.
version_id | **string**<br>ID of the key version to encrypt the generated data key with. Defaults to the primary version if not specified. The maximum string length in characters is 50.
aad_context | **bytes**<br>Additional authenticated data (AAD context), optional. If specified, this data will be required for decryption with the [SymmetricDecryptRequest](#SymmetricDecryptRequest). Should be encoded with base64. The maximum string length in characters is 8192.
data_key_spec | enum **SymmetricAlgorithm**<br>Encryption algorithm and key length for the generated data key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
skip_plaintext | **bool**<br>If `true`, the method won't return the data key as plaintext. Default value is `false`. 


### GenerateDataKeyResponse {#GenerateDataKeyResponse}

Field | Description
--- | ---
key_id | **string**<br>ID of the symmetric KMS key that was used to encrypt the generated data key. 
version_id | **string**<br>ID of the key version that was used for encryption. 
data_key_plaintext | **bytes**<br>Generated data key as plaintext. The field is empty, if the [GenerateDataKeyRequest.skip_plaintext](#GenerateDataKeyRequest) parameter was set to `true`. 
data_key_ciphertext | **bytes**<br>The encrypted data key. 


