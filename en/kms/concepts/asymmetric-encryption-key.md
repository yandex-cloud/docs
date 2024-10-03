---
title: Asymmetric encryption key pair in {{ kms-short-name }}
description: This guide describes the features of asymmetric encryption key pairs in {{ kms-short-name }}.
---

# Asymmetric encryption key pair in {{ kms-short-name }}

An asymmetric encryption key pair consists of two parts: a public key and a private key. The public key is used for encryption and the private key is used for decryption.

{{ kms-name }} allows you to export the public key to encrypt text on the client side. To decrypt such text in {{ kms-short-name }}, you can use the private key. You cannot access the private key in {{ kms-short-name }} directly.

{% include [asymmetric-keys-quota](../../_includes/kms/asymmetric-keys-quota.md) %}

## Encryption key pair parameters {#parameters}

A {{ kms-short-name }} encryption key pair may have the following parameters:
* ID: Unique key pair identifier in {{ yandex-cloud }}. It is used for working with key pairs via the SDK, API, and CLI.
* Name: Non-unique key pair name. It can be used to work with key pairs in the CLI if the folder only contains a single key pair with this name.
* Encryption algorithm: Algorithm used for encryption. The following asymmetric encryption algorithms are supported:
   * `rsa-2048-enc-oaep-sha-256`
   * `rsa-3072-enc-oaep-sha-256`
   * `rsa-4096-enc-oaep-sha-256`

* Status: Current state of the key pair. The following statuses are possible:
   * `Creating`: Key pair is being created.
   * `Active`: Key pair can be used for encryption and decryption.
   * `Inactive`: Key pair cannot be used.

   You can change the key pair status from `Active` to `Inactive` and back using the [AsymmetricEncryptionKeyService/Update](../api-ref/grpc/asymmetric_encryption_key_service.md#Update) gRPC API call.

## Using encryption key pairs {#use}

You can use an asymmetric encryption key pair in data encryption and decryption operations if you have the appropriate [roles](../security/index.md#roles-list) assigned. You can temporarily disable operations with a key pair by revoking the roles or changing its status to `Inactive`. For more information, see [{#T}](../security/index.md).

## Deleting encryption key pairs {#delete}

If you delete an encryption key pair or its parent resource (folder or cloud), this destroys the cryptographic material contained in it. After that, you will not be able to decrypt the data encrypted with the public key of the key pair.