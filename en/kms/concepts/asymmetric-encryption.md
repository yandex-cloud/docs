---
title: Asymmetric encryption in {{ kms-short-name }}
description: This guide describes the features of asymmetric encryption in {{ kms-short-name }}.
---

# Asymmetric encryption in {{ kms-short-name }}

One of the available encryption modes in {{ kms-short-name }} is _asymmetric encryption_. It uses a public key of an asymmetric key pair (crypto pair) to encrypt data and its private key to decrypt the data. {{ kms-name }} allows you to export the public key to encrypt text on the client side. To decrypt such text in {{ kms-short-name }}, you can use the private key from the key pair. You cannot access the private key in {{ kms-short-name }} directly.

{% include [asymmetric-keys-quota](../../_includes/kms/asymmetric-keys-quota.md) %}

## Obtaining a key pair public key {#acquire-public-key}

To encrypt a message, you need to get a public key in {{ kms-short-name }}. To do this, make a service request using the [CLI](../../cli/cli-ref/managed-services/kms/asymmetric-encryption-crypto/get-public-key.md) or [API](../api-ref/grpc/asymmetric_encryption_crypto_service.md#GetPublicKey).

To obtain the public key of encryption key pair, the user or service account must be [assigned the `kms.asymmetricEncryptionKeys.publicKeyViewer` role](../operations/key-access.md) for the key pair.

## Data encryption {#encryption}

Data is encrypted outside {{ kms-name }}. Encryption requires a [public key](#acquire-public-key) of the asymmetric encryption key pair.

To encrypt a message, you can use the [OpenSSL](https://www.openssl.org/) utility.

```bash
openssl pkeyutl \
  -in <path_to_message_file> \
  -encrypt \
  -pubin \
  -inkey <path_to_public_key_file> \
  -pkeyopt rsa_padding_mode:oaep \
  -pkeyopt rsa_oaep_md:sha256 \
  -pkeyopt rsa_mgf1_md:sha256 | base64
```

Where:
* `-in`: Path to the file with the message to be encrypted.
* `-inkey`: Path to the file containing the public encryption key.

The hash function is specified at the end of the selected key. Only `sha256` is used for encryption. {{ kms-short-name }} accepts encrypted text in `base64` encoding and decrypts it with the private key.

The maximum size of a message to encrypt depends on the length of an encryption key and hash function (see [RFC2437](https://datatracker.ietf.org/doc/html/rfc2437#section-7.1)). The maximum message size can be calculated using the following formula:

```text
<message_length> = (k - 2) - 2 × hashLength
```

Where:
* `<message_length>`: Size of the message being encrypted, in bytes.
* `k`: Length of the encryption key, in bytes.
* `hashLength`: Length of the hash function, in bytes.

| **Algorithm** | **Parameters** | **Max message length** |
| --- | --- | --- |
| `RSA_2048_ENC_OAEP_SHA_256` | `k`=256, `hashLength`=32 | 190 bytes |
| `RSA_3072_ENC_OAEP_SHA_256` | `k`=384, `hashLength`=32 | 318 bytes |
| `RSA_4096_ENC_OAEP_SHA_256` | `k`=512, `hashLength`=32 | 446 bytes |

## Data decryption {#decryption}

You can decrypt data using a private key of the key pair in {{ kms-name }}. To do this, make a service request using the [CLI](../../cli/cli-ref/managed-services/kms/asymmetric-encryption-crypto/decrypt.md) or [API](../api-ref/grpc/asymmetric_encryption_crypto_service.md#Decrypt).

To decrypt data, the user or service account must be [assigned the `kms.asymmetricEncryptionKeys.decrypter` role](../operations/key-access.md) for the encryption key pair.
