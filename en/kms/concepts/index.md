# Overview

{{ kms-name }} is a service for creating and managing encryption keys in Yandex.Cloud.

Modern encryption algorithms are public. Without access to keys, the knowledge of the ciphertext and encryption algorithm is not enough to decrypt data. Secure data storage thus means secure storage of encryption keys.

There are various types of encrypted data: from passwords, OAuth tokens, and SSH keys, to data arrays that are several GB in size. This may require different types of access (random or sequential) and different types of storage. The optimal encryption algorithms are selected depending on all these factors. With a large amount of data, it's important to both control access to this data consistently and consider the specifics of each type.

{{ kms-name }} meets the above objectives and provides secure and centralized storage for encryption keys.

## Interfaces for using the service {#interface}

To interact with {{ kms-short-name }}, you can use:

* [Management console]({{ link-console-main }}).
* [Command line interface (CLI)](../../cli/).
* SDK: in [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk), or [Node.js](https://github.com/yandex-cloud/nodejs-sdk).
* API: [REST](../api-ref/) or [gRPC](../grpc/).

## Key management {#keys-control}

[A key](key.md) is the main {{ kms-short-name }} resource, which is a set of versions of cryptographic material that can be used to encrypt or decrypt data. Control the lifecycle of crypto material by managing keys:

* [Create keys](../operations/key.md#create).
* [Rotate keys](../operations/key.md#rotate).
* [Update keys](../operations/key.md#update).
* [Destroy keys](../operations/key.md#delete).

### Key integration with services and tools {#integration}

You can use {{ kms-short-name }} keys:

* In Yandex.Cloud services:
  * [Managed Service for Kubernetes](../../managed-kubernetes/).
  * [Certificate Manager](../../certificate-manager/).
* When working with [Terraform](../solutions/terraform-key.md).
* In cryptographic libraries:
  * [AWS Encryption SDK](../solutions/encrypt/aws-encryption-sdk.md).
  * [Google Tink](../solutions/encrypt/google-tink.md).

### Secure key storage {#keys-storage}

The cryptographic key material is stored in encrypted form and isn't available as plaintext outside {{ kms-short-name }}. When using the service API, you can encrypt or decrypt the transmitted data with a specific key, but you can't explicitly get the crypto material. It's only restored to the RAM and just for the duration of operations with the corresponding key.

All access control features provided by {{ iam-name }} are available for keys. For more information about managing access and assigning roles, see [{#T}](../security/index.md)

### Key usage audit {#keys-audit}

You can't read the ciphertext without access to the appropriate key. All key operations are written to audit logs. So, in addition to encryption, an important advantage of using {{ kms-short-name }} is the verification of access to encrypted data via key logs.

Each entry in the audit log contains the following information:

* Date and time.
* Type of operation.
* The key used.
* Subject (a Yandex.Cloud account or service account).

To get the audit logs, contact [technical support]({{ link-console-support }}).

