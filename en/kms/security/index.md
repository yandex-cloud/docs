---
title: Access management in Yandex Key Management Service
description: "Access management in the service for creating and managing encryption keys — Yandex Key Management Service. The section describes which resources you can assign a role to, which roles act in the service, which roles are required for this or that action."
---

# Access management

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to. {#resources}

You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or [key](../concepts/key). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

You can manage access to {{ kms-short-name }} keys using both service and primitive roles. The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](../../_assets/kms/service-roles-hierarchy.svg)

### Service roles {#service}

Service roles provide more granular control over {{ kms-short-name }} keys, taking into account the service specifics: a strict division of subjects into key administrators (the `kms.admin` role) and users (the `kms.keys.encrypterDecrypter` role).

Users without the `resource-manager.clouds.owner` or `admin` role can't assign roles via the management console.

List of service roles:

* `kms.keys.encrypterDecrypter`: Lets you perform data encryption and decryption operations and view information about keys.
* `kms.admin`: Lets you manage keys (view, create, update, destroy, rotate keys, as well as encrypt and decrypt data). It also lets you assign the `kms.keys.encrypterDecrypter` role for keys using the CLI and API.

### Primitive roles {#primitive}

Primitive roles are common to all Yandex.Cloud resources. Assigning any of them grants certain permissions in {{ kms-short-name }} and other cloud services. For example, the `admin` role assigned for a folder lets you destroy any {{ kms-short-name }} key in that folder and update the folder itself or resources in it. You can manage primitive roles using the management console.

List of primitive roles:

* `viewer`: Only lets you view information about the resources.
* `editor`: Lets you manage resources (create and edit).
* `admin`: Lets you manage access to resources and the resources themselves (create, modify, and delete).

## What roles do I need {#choosing-roles}

**Example of key access control**

We recommend working with roles as follows:

1. The cloud owner (the `resource-manager.clouds.owner` role) or administrator (the `admin` role) assigns the `kms.admin` role to the {{ kms-short-name }} administrator.
1. The {{ kms-short-name }} administrator creates the required number of keys and assigns (through the CLI or API) roles to use them: subjects from different teams are granted the `kms.keys.encrypterDecrypter` role for the keys they need.

It's good practice to store {{ kms-short-name }} keys in a dedicated folder, separately from other Yandex.Cloud resources.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **KMS** |  |
| Get information about keys and versions | `get`, `listVersions` | `kms.keys.encrypterDecrypter` for a key |
| Operations of [encryption and decryption](../api-ref/SymmetricCrypto/) | `encrypt`, `decrypt`, `reencrypt`, `generatedatakey` | `kms.keys.encrypterDecrypter` for a key |
| Get a list of keys in a folder | `list` | `kms.admin` for a key |
| [Create](../operations/key.md#create) and [update](../operations/key.md#update) a key | `create`, `update` | `kms.admin` for a key |
| [Rotate a key](../operations/key.md#rotate) and [change the primary version](../operations/version.md#make-primary) | `rotate`, `setPrimaryVersion` | `kms.admin` for a key |
| [Destroy a key](../operations/key.md#delete) and [version](../operations/version.md#delete) | `delete`, `scheduleVersionDestruction`, `cancelVersionDestruction` | `kms.admin` for a key |
| [Assign](../../iam/operations/roles/grant.md), [revoke](../../iam/operations/roles/revoke.md), and view roles granted for the key | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `kms.admin` for a key |

#### What's next {#what-is-next}

* [How to use Yandex.Cloud securely](../../iam/best-practices/using-iam-securely.md)
* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Read more about access management in Yandex.Cloud](../../iam/concepts/access-control/index.md).
* [More about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

