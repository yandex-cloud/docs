---
title: Asymmetric signature key pair in {{ kms-short-name }}
description: This article describes the features of asymmetric signature key pairs in {{ kms-short-name }}.
---

# Asymmetric signature key pair in {{ kms-short-name }}

An asymmetric key pair of a digital signature consists of two parts: a public key and a private key. The private key is used to create a digital signature and the public key is used to verify it.

{% include [asymmetric-keys-quota](../../_includes/kms/asymmetric-keys-quota.md) %}

## Digital signature key pair parameters {#parameters}

A digital signature key pair in {{ kms-short-name }} may have the following parameters:
* ID: Unique key pair identifier in {{ yandex-cloud }}. It is used for working with key pairs via the SDK, API, and CLI.
* Name: Non-unique key pair name. It can be used to work with key pairs in the CLI if the folder only contains a single key pair with this name.
* Signature algorithm: Algorithm used to create and verify a digital signature. The following signature algorithms are supported:

    * `rsa-2048-sign-pss-sha-256`
    * `rsa-2048-sign-pss-sha-384`
    * `rsa-2048-sign-pss-sha-512`
    * `rsa-3072-sign-pss-sha-256`
    * `rsa-3072-sign-pss-sha-384`
    * `rsa-3072-sign-pss-sha-512`
    * `rsa-4096-sign-pss-sha-256`
    * `rsa-4096-sign-pss-sha-384`
    * `rsa-4096-sign-pss-sha-512`
    * `ecdsa-nist-p256-sha-256`
    * `ecdsa-nist-p384-sha-384`
    * `ecdsa-nist-p521-sha-512`
    * `ecdsa-secp256-k1-sha-256`

* Status: Current state of the key pair. The following statuses are possible:
    * `Creating`: Key pair is being created.
    * `Active`: Key pair can be used for signing data and verifying the signature.
    * `Inactive`: Key pair cannot be used.

    You can change the key pair status from `Active` to `Inactive` and back using the [AsymmetricSignatureKeyService/Update](../api-ref/grpc/asymmetric_signature_key_service.md#Update) gRPC API call.

## Using a digital signature key pair {#use}

You can use an asymmetric key pair of a digital signature in digital signature and signature verification operations if you have the appropriate [roles](../security/index.md#roles-list) assigned. You can temporarily disable operations with a key pair by revoking the roles or changing its status to `Inactive`. For more information, see [{#T}](../security/index.md).

## Deleting a digital signature key pair {#delete}

If you delete a digital signature key pair or its parent resource (folder or cloud), this destroys the cryptographic material contained in it.
