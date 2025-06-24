---
title: Encryption in {{ managed-k8s-full-name }}
description: In this article, you will learn about encryption in {{ managed-k8s-name }}.
---

# Encryption in {{ managed-k8s-name }}

{{ yandex-cloud }} adopts many [information security measures](../../security/standarts.md). They include multi-level encryption of {{ managed-k8s-name }} data:

* Data is encrypted using system keys when it is placed in a {{ yandex-cloud }} storage. This protects your data from being compromised in the event of a physical theft of disks from {{ yandex-cloud }} data centers.
* Data is encrypted when transmitted over the network using the TLS protocol. The keys used for TLS are stored on hosts running the protocol. This ensures that the data is protected against interception.

The following cryptographic algorithms are used:
* Symmetric: AES, ChaCha.
* Asymmetric: RSA, Ed25519.

The minimum used key length is 128 bits for symmetric encryption algorithms, and 2048 bits for asymmetric encryption algorithms.

{{ yandex-cloud }} provides management for these keys.

## Encryption with custom symmetric keys {#kms-keys-encryption}

{{ managed-k8s-name }} supports encryption with [custom {{ kms-full-name }} symmetric keys](../../kms/concepts/key.md) for the following resources:
* [{{ k8s }} secrets](#k8s-secrets-encryption)
* [Disks for persistent volumes](./volume.md#encrypted-disks)

Such keys are managed on the user side, which provides extra opportunities:

* Auditing [events](../../kms/at-ref.md) related to the key usage with [{{ at-full-name }}](../../audit-trails/).
* Tracking operations with keys using [{{ monitoring-full-name }}](../../monitoring/).
* [Operations with keys](../../kms/operations/index.md#symmetric-encryption), such as rotation, modification, deactivation, and deletion.
* Granular management of [access permissions to the key](../../kms/security/index.md) at the level of individual [{{ yandex-cloud }} accounts](../../iam/concepts/users/accounts.md).
* Using the [hardware security module (HSM)](../../kms/concepts/hsm.md) when needed.

    {% note info %}

    In {{ managed-k8s-name }}, a {{ yandex-cloud }} service account is [called](./index.md#service-accounts) a cloud service account to avoid confusion with a {{ k8s }} service account.

    {% endnote %}

### Encrypting {{ k8s }} secrets {#k8s-secrets-encryption}

A [_{{ k8s }} secret_](https://kubernetes.io/docs/concepts/configuration/secret/) is private information the {{ k8s }} clusters use when managing pods, e.g., OAuth keys, passwords, SSH keys, etc.

By default, cluster secrets are stored in an open format. If you specified an encryption key when [creating a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md), the cluster secrets will be encrypted.

{% note warning %}

You can specify an encryption key only when creating a cluster.

If you need to use another key, create a new cluster with that key.

{% endnote %}

The encryption process of an individual secret runs as follows:

1. {{ k8s }} encrypts the secret using the [KMS provider](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/).

1. During the encryption process, the KMS provider accesses the KMS plugin that enables using the encryption key you have specified when creating the cluster:

    This encryption key is not used to encrypt secrets directly. Instead, the [envelope encryption](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/#kms-encryption-and-per-object-encryption-keys) algorithm involving the key is used.

    For a general description of the algorithm, see [{#T}](../../kms/concepts/envelope.md).

1. During the encryption process, the KMS plugin works with [{{ kms-full-name }}](../../kms/concepts/index.md) where the encryption key is stored.

    This plugin as well as the provider using it are already installed in the {{ managed-k8s-name }} cluster and properly configured.

Secrets are decrypted in a similar way.

## Use cases {#examples}

* [{#T}](../tutorials/kms-k8s.md)
* [{#T}](../tutorials/nginx-ingress-certificate-manager.md)
* [{#T}](../operations/volumes/encrypted-disks.md)


* [{#T}](../tutorials/kubernetes-lockbox-secrets.md)

## See also {#see-also}

* [{#T}](../operations/applications/hashicorp-vault.md)
* [{#T}](../tutorials/marketplace/hashicorp-vault.md)
* [{#T}](../tutorials/kms-k8s.md)
* [{#T}](../operations/applications/external-secrets-operator.md)
* [{#T}](../tutorials/kubernetes-lockbox-secrets.md)