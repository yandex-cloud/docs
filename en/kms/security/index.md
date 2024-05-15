---
title: "Access management in {{ kms-full-name }}"
description: "Access management in {{ kms-full-name }}, an encryption key management system. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management in {{ kms-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

In the management console, you can assign a role through the YC CLI or the {{ yandex-cloud }} API for individual resources of the service:

{% include notitle [kms-resources](../../_includes/iam/resources-with-access-control/kms.md) %}

## Which roles exist in the service {#roles-list}

You can manage access to {{ kms-short-name }} keys using both service and primitive roles.

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/kms/service-roles-hierarchy.svg)

### Service roles {#service-roles}

Service roles provide more granular control over {{ kms-short-name }} keys, taking into account the service specifics: a strict division of subjects into key administrators (the `kms.admin` role) and users (the `kms.keys.encrypterDecrypter` role).

Users without the `resource-manager.clouds.owner` or `admin` role cannot assign roles via the management console.

#### kms.keys.encrypter {#kms-keys-encrypter}

{% include [kms.keys.encrypter](../../_roles/kms/keys/encrypter.md) %}

#### kms.keys.decrypter {#kms-keys-decrypter}

{% include [kms.keys.decrypter](../../_roles/kms/keys/decrypter.md) %}

#### kms.keys.encrypterDecrypter {#kms-keys-encrypterDecrypter}

{% include [kms.keys.encrypterDecrypter](../../_roles/kms/keys/encrypterDecrypter.md) %}

#### kms.asymmetricEncryptionKeys.publicKeyViewer {#kms-asymmetricEncryptionKeys-publicKeyViewer}

{% include [kms.asymmetricEncryptionKeys.publicKeyViewer](../../_roles/kms/asymmetricEncryptionKeys/publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.publicKeyViewer {#kms-asymmetricSignatureKeys-publicKeyViewer}

{% include [kms.asymmetricSignatureKeys.publicKeyViewer](../../_roles/kms/asymmetricSignatureKeys/publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.signer {#kms-asymmetricSignatureKeys-signer}

{% include [kms.asymmetricSignatureKeys.signer](../../_roles/kms/asymmetricSignatureKeys/signer.md) %}

#### kms.asymmetricEncryptionKeys.decrypter {#kms-asymmetricEncryptionKeys-decrypter}

{% include [kms.asymmetricEncryptionKeys.decrypter](../../_roles/kms/asymmetricEncryptionKeys/decrypter.md) %}

#### kms.auditor {#kms-auditor}

{% include [kms.auditor](../../_roles/kms/auditor.md) %}

#### kms.viewer {#kms-viewer}

{% include [kms.viewer](../../_roles/kms/viewer.md) %}

#### kms.editor {#kms-editor}

{% include [kms.editor](../../_roles/kms/editor.md) %}

#### kms.admin {#kms-admin}

{% include [kms.admin](../../_roles/kms/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

**Example of key access control**

We recommend working with roles as follows:
1. The cloud owner (the `resource-manager.clouds.owner` role) or administrator (the `admin` role) assigns the `kms.admin` role to the {{ kms-short-name }} administrator.
1. The {{ kms-short-name }} administrator creates the required number of keys and assigns (through the CLI or API) the roles to use them: subjects from different teams are given the `kms.keys.encrypter`, `kms.keys.decrypter`, `kms.asymmetricEncryptionKeys.publicKeyViewer`, `kms.asymmetricEncryptionKeys.decrypter`, and `kms.editor` roles for keys and folders.

It is good practice to store {{ kms-short-name }} keys in a dedicated folder apart from other {{ yandex-cloud }} resources.

| Action | Methods | Required roles |
----- | ----- | -----
| **{{ kms-short-name }}** | |
| Getting information about keys and versions | `get`, `listVersions` | `kms.viewer` for key for folder |
| [Symmetric encryption and decryption](../api-ref/SymmetricCrypto/) operations | `encrypt`, `decrypt`, `reEncrypt`, `generateDataKey` | `kms.keys.encrypterDecrypter` for key (encryption and decryption), `kms.keys.encrypter` for key (encryption only), and `kms.keys.decrypter` for key (decryption only) |
| Obtaining a list of keys in a folder | `list` | `kms.auditor` for folder |
| Obtaining a public key of an asymmetric encryption key pair | | `kms.asymmetricEncryptionKeys.publicKeyViewer` for key |
| Decrypting data with a private key of an asymmetric encryption key pair | | `kms.asymmetricEncryptionKeys.decrypter` for key |
| [Creating](../operations/key.md#create) and [updating](../operations/key.md#update) a key | `create`, `update` | `kms.editor` for folder |
| [Rotating a key](../operations/key.md#rotate) | `rotate` | `kms.editor` for key |
| [Changing the primary version](../operations/version.md#make-primary) | `setPrimaryVersion` | `kms.admin` for key |
| [Destroying keys](../operations/key.md#delete) and [versions](../operations/version.md#delete) | `delete`, `scheduleVersionDestruction`, `cancelVersionDestruction` | `kms.admin` for a key |
| [Granting a role](../../iam/operations/roles/grant.md), [revoking a role](../../iam/operations/roles/revoke.md) | `setAccessBindings`, `updateAccessBindings` | `kms.admin` for key |
| Viewing roles granted for a key | `listAccessBindings` | `kms.auditor` for key |

#### What's next {#what-is-next}

* [How to use {{ yandex-cloud }} securely](../../iam/best-practices/using-iam-securely.md)
* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
