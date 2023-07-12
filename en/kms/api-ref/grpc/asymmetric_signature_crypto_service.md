---
editable: false
sourcePath: en/_api-ref-grpc/kms/api-ref/grpc/asymmetric_signature_crypto_service.md
---

# Key Management Service API, gRPC: AsymmetricSignatureCryptoService

Set of methods that perform asymmetric signature.

| Call | Description |
| --- | --- |
| [Sign](#Sign) | Signs data specified KMS key. |
| [SignHash](#SignHash) | Signs hash value specified KMS key. |
| [GetPublicKey](#GetPublicKey) | Gets value of public key. |

## Calls AsymmetricSignatureCryptoService {#calls}

## Sign {#Sign}

Signs data specified KMS key.

**rpc Sign ([AsymmetricSignRequest](#AsymmetricSignRequest)) returns ([AsymmetricSignResponse](#AsymmetricSignResponse))**

### AsymmetricSignRequest {#AsymmetricSignRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the asymmetric KMS key to use for signature. The maximum string length in characters is 50.
message | **bytes**<br>Required. Message to sign. Should be encoded with base64. The maximum string length in characters is 32768.


### AsymmetricSignResponse {#AsymmetricSignResponse}

Field | Description
--- | ---
key_id | **string**<br>ID of the asymmetric KMS key that was used for signature. 
signature | **bytes**<br>Value of signature. Signature value is produced in accordance with RFC 8017 for RSA and is a DER-encoded object as defined by ANSI X9.62-2005 and RFC 3279 Section 2.2.3 for ECDSA. 


## SignHash {#SignHash}

Signs hash value specified KMS key.

**rpc SignHash ([AsymmetricSignHashRequest](#AsymmetricSignHashRequest)) returns ([AsymmetricSignHashResponse](#AsymmetricSignHashResponse))**

### AsymmetricSignHashRequest {#AsymmetricSignHashRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the asymmetric KMS key to use for signature. The maximum string length in characters is 50.
hash | **bytes**<br>Required. Hash value to be signed. Should be encoded with base64. The maximum string length in characters is 4096.


### AsymmetricSignHashResponse {#AsymmetricSignHashResponse}

Field | Description
--- | ---
key_id | **string**<br>ID of the asymmetric KMS key that was used for signature. 
signature | **bytes**<br>Value of signature. Signature value is produced in accordance with RFC 8017 for RSA and is a DER-encoded object as defined by ANSI X9.62-2005 and RFC 3279 Section 2.2.3 for ECDSA. 


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


