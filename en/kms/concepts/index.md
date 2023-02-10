---
title: "{{ kms-full-name }}. Service overview"
description: "{{ kms-full-name }} is a service for creating and managing encryption keys in {{ yandex-cloud }}. Modern encryption algorithms are open. Without access to the key, knowledge of the ciphertext and encryption algorithm is not enough to decrypt the data. Thus, the task of securely storing data is reduced to the task of safely storing encryption keys."
---

# {{ kms-name }} overview

{{ kms-name }} is a service to create and manage encryption keys in {{ yandex-cloud }}.

Modern encryption algorithms are public. Without access to a key, knowledge of the ciphertext and the encryption algorithm is not enough to decrypt data. Secure data storage means secure storage of encryption keys.

There are various types of encrypted data: from passwords, OAuth tokens, and {% if lang == "ru" and audience != "internal" %}[SSH keys](../../glossary/ssh-keygen.md){% else %}SSH keys{% endif %}, to data arrays that are several GB in size. They may require different types of access (random or sequential) and different types of storage. The optimal encryption algorithms are selected depending on all these factors. With a large amount of data, it's important to both control access to this data consistently and consider the specifics of each type.

{{ kms-name }} meets the above objectives and provides secure and centralized storage for encryption keys.

## Interfaces for using the service {#interface}

To interact with {{ kms-short-name }}, you can use:
* The [management console]({{ link-console-main }}).
* [Command line interface (CLI)](../../cli/).
{% if product == "yandex-cloud" %}
* SDK: in [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk), or [Node.js](https://github.com/yandex-cloud/nodejs-sdk).
{% endif %}
* API: [REST](../api-ref/) or [gRPC](../../_api-ref-grpc/).

## Managing keys {#keys-control}

A [key](key.md) is a primary {{ kms-short-name }} resource and a collection of versions of cryptographic material that can be used to encrypt or decrypt data. Control the lifecycle of crypto material by managing keys:
* [Create a key](../operations/key.md#create).
* [Rotate keys](../operations/key.md#rotate).
* [Update keys](../operations/key.md#update).
* [Destroy keys](../operations/key.md#delete).

### Key integration with services and tools {#integration}

You can use {{ kms-short-name }} keys:
* In {{ yandex-cloud }} services:
   * [Managed Service for Kubernetes](../../managed-kubernetes/).
   * [Certificate Manager](../../certificate-manager/).
* When working with [{{ TF }}](../tutorials/terraform-key.md).
   {% if product == "yandex-cloud" %}
* In cryptographic libraries:
   * [AWS Encryption SDK](../tutorials/encrypt/aws-encryption-sdk.md).
   * [Google Tink](../tutorials/encrypt/google-tink.md).
      {% endif %}

### Secure key storage {#keys-storage}

The cryptographic key material is stored in encrypted form and isn't available as plaintext outside {{ kms-short-name }}. When using the service API, you can encrypt or decrypt the transmitted data with a specific key, but you can't explicitly get the crypto material. It's only restored to the RAM and just for the duration of operations with the corresponding key.

{% if product == "yandex-cloud" %}
In you use a [Hardware Security Module (HSM)](hsm.md), user keys never leave the HSM as plaintext. Key creation also takes place inside the HSM.
{% endif %}

All access control features provided by {{ iam-name }} are available for keys. For more information about access control and role assignment, see [{#T}](../security/index.md).

### Key usage audit {#keys-audit}

You can't read the ciphertext without access to the appropriate key. All key operations are written to audit logs. So, in addition to encryption, an important advantage of using {{ kms-short-name }} is the verification of access to encrypted data via key logs.

Each entry in the audit log contains the following information:
* Date and time.
* Type of operation.
* The key used.
* Subject ({{ yandex-cloud }} or service account).

To retrieve logs, please contact [technical support]({{ link-console-support }}).