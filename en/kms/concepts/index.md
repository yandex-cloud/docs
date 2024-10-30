---
title: '{{ kms-name }}. Overview'
description: '{{ kms-name }} is a service to create and manage encryption keys in {{ yandex-cloud }}. Modern encryption algorithms are public. Without access to keys, the knowledge of the ciphertext and encryption algorithm is not enough to decrypt data. Therefore, secure data storage means secure storage of encryption keys.'
---

# {{ kms-name }} overview

{{ kms-name }} is a service to create and manage encryption keys in {{ yandex-cloud }}.

Modern encryption algorithms are public. The knowledge of the ciphertext and encryption algorithm is not enough to decrypt data unless you have access to keys. Therefore, secure data storage means secure storage of encryption keys.

There are various types of encrypted data: from passwords, OAuth tokens, and SSH keys to data arrays that are several GB in size. They may require different types of access (random or sequential) and different types of storage. The optimal encryption algorithms are selected depending on all these factors. With a large amount of data, it is equally important to control access to it in a consistent manner and to consider the specifics of each data type.

{{ kms-name }} meets the above objectives and provides secure and centralized storage for encryption keys.

## Interfaces for using the service {#interface}

To interact with {{ kms-short-name }}, you can use:
* [The management console]({{ link-console-main }}).
* [Command line interface (CLI)](../../cli/).
* SDK: in [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk), or [Node.js](https://github.com/yandex-cloud/nodejs-sdk).
* API: [REST](../api-ref/) or [gRPC](../api-ref/grpc/).

## Managing symmetric encryption keys {#symmetric-encryption-keys-control}

A [symmetric encryption key](key.md) is a {{ kms-short-name }} resource and a collection of versions of cryptographic material that can be used to encrypt or decrypt data. Control the lifecycle of crypto material by managing keys:
* [Create a key](../operations/key.md#create).
* [Rotate keys](../operations/key.md#rotate).
* [Update keys](../operations/key.md#update).
* [Destroy keys](../operations/key.md#delete).

## Managing asymmetric encryption key pairs {#asymmetric-encryption-keys-control}

An [asymmetric encryption key pair](asymmetric-encryption-key.md) is a {{ kms-short-name }} resource that consists of two parts: a public key and a private key. The public key is used for encryption and the private key is used for decryption. Manage encryption key pairs:
* [Create a key pair](../operations/asymmetric-encryption-key.md#create).
* [Update a key pair](../operations/asymmetric-encryption-key.md#update).
* [Delete a key pair](../operations/asymmetric-encryption-key.md#delete).

## Managing asymmetric key pairs of digital signatures {#asymmetric-signature-keys-control}

An [asymmetric digital signature key pair](asymmetric-signature-key.md) is a {{ kms-short-name }} resource that consists of two parts: a public key and a private key. You use the private key to create a digital signature and the public key to verify it. Manage signature key pairs:
* [Create a key pair](../operations/asymmetric-signature-key.md#create).
* [Update a key pair](../operations/asymmetric-signature-key.md#update).
* [Delete a key pair](../operations/asymmetric-signature-key.md#delete).

### Key integration with services and tools {#integration}

You can use {{ kms-short-name }} keys:
* In {{ yandex-cloud }} services:
   * [Managed Service for Kubernetes](../../managed-kubernetes/)
   * [Certificate Manager](../../certificate-manager/)
* When working with [{{ TF }}](../tutorials/terraform-key.md).
* In cryptographic libraries:
   * [AWS Encryption SDK](../tutorials/encrypt/aws-encryption-sdk.md)
   * [Google Tink](../tutorials/encrypt/google-tink.md)

### Secure key storage {#keys-storage}

The cryptographic key material is stored in encrypted form and is not available as plaintext outside {{ kms-short-name }}. When using the service API, you can encrypt or decrypt the transmitted data with a specific key, but you cannot get the crypto material in an explicit form. It can only be restored to RAM, and just for the duration of operations with the corresponding key.

If you use a [Hardware Security Module (HSM)](hsm.md), user keys never leave the HSM as plaintext. Key creation also takes place inside the HSM.

All access control features provided by {{ iam-name }} are available for keys. For more information about access control and role assignment, see [{#T}](../security/index.md).

### Key usage audit {#keys-audit}

You can't read the ciphertext without access to the appropriate key. All key operations are written to audit logs. So, in addition to encryption, an important advantage of using {{ kms-short-name }} is the verification of access to encrypted data via key logs.

Each entry in the audit log contains the following information:
* Date and time.
* Type of operation.
* The key used.
* Subject ({{ yandex-cloud }} or service account).

To retrieve logs, please contact [technical support]({{ link-console-support }}).