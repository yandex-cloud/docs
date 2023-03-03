---
editable: false
sourcePath: en/_api-ref-grpc/kms/api-ref/grpc/asymmetric_encryption_crypto_service.md
---

# Key Management Service API, gRPC: AsymmetricEncryptionCryptoService

Set of methods that perform asymmetric decryption.

| Call | Description |
| --- | --- |
| [Decrypt](#Decrypt) | Decrypts the given ciphertext with the specified key. |
| [GetPublicKey](#GetPublicKey) | Gets value of public key. |

## Calls AsymmetricEncryptionCryptoService {#calls}

## Decrypt {#Decrypt}

Decrypts the given ciphertext with the specified key.

**rpc Decrypt ([AsymmetricDecryptRequest](#AsymmetricDecryptRequest)) returns ([AsymmetricDecryptResponse](#AsymmetricDecryptResponse))**

### AsymmetricDecryptRequest {#AsymmetricDecryptRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the asymmetric KMS key to use for decryption. The maximum string length in characters is 50.
ciphertext | **bytes**<br>Required. Ciphertext to be decrypted. Should be encoded with base64. The maximum string length in characters is 32768.


### AsymmetricDecryptResponse {#AsymmetricDecryptResponse}

Field | Description
--- | ---
key_id | **string**<br>ID of the asymmetric KMS key that was used for decryption. 
plaintext | **bytes**<br>Decrypted plaintext. 


## GetPublicKey {#GetPublicKey}

Gets value of public key.

**rpc GetPublicKey ([AsymmetricGetPublicKeyRequest](#AsymmetricGetPublicKeyRequest)) returns ([AsymmetricGetPublicKeyResponse](#AsymmetricGetPublicKeyResponse))**

### AsymmetricGetPublicKeyRequest {#AsymmetricGetPublicKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the asymmetric KMS key to be used for public key retrieval. The maximum string length in characters is 50.


### AsymmetricGetPublicKeyResponse {#AsymmetricGetPublicKeyResponse}

Field | Description
--- | ---
key_id | **string**<br>ID of the asymmetric KMS key to get public key of. 
public_key | **string**<br>Public key value. The value is a PEM-encoded X.509 public key, also known as SubjectPublicKeyInfo (SPKI), as defined in RFC 5280. 


