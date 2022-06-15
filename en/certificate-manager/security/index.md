---
title: Access management in {{ certificate-manager-full-name }}
description: "Access management in the service for obtaining and renewing TLS certificates from Let's Encrypt, as well as for uploading your own certificates — {{ certificate-manager-full-name }}. The section describes which resources you can assign a role to, which roles operate in the service, which roles are required for some other action. "
---

# Access management in {{ certificate-manager-name }}

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to. {#resources}

{% include [roles-intro](../../_includes/roles-intro.md) %}

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](../../_assets/certificate-manager/service-roles-hierarchy-with-admin.svg)

Active roles in the service:

* Service roles:
    * {% include [certificate-manager.admin](../../_includes/iam/roles/short-descriptions/certificate-manager.admin.md) %}
    * {% include [certificate-manager.certificates.downloader](../../_includes/iam/roles/short-descriptions/certificate-manager.certificates.downloader.md) %}
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Primitive roles:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **Certificate Manager** |  |
| Get a list of certificates or domains | `list` | `viewer` for a folder |
| Get certificate or domain details | `get` | `viewer` for a certificate or folder |
| [Create](../operations/managed/cert-create.md) a certificate from Let's Encrypt<sup>®</sup> | `requestNew` | `editor` for the folder |
| [Edit](../operations/managed/cert-modify.md) or [delete](../operations/managed/cert-delete.md) a Let's Encrypt certificate | `update`, `delete` | `editor` for the certificate or folder |
| [Create](../operations/import/cert-create.md) a user certificate | `create` | `editor` for the folder |
| [Update](../operations/import/cert-update.md), [edit](../operations/import/cert-modify.md), or [delete](../operations/import/cert-delete.md) a user certificate | `update`, `delete` | `editor` for the certificate or folder |
| Get the contents of a [user certificate](../operations/import/cert-get-content.md) or a [Let's Encrypt certificate](../operations/managed/cert-get-content.md) | `get-content` | `certificate-manager.certificates.downloader` for the certificate or folder |
| [Create a domain](../operations/domain/domain-create.md) | `create` | `editor` for the folder |
| [Update a domain](../operations/domain/domain-modify.md) and [delete a domain](../operations/domain/domain-delete.md) | `update`, `delete` | `editor` for the domain or folder |
| [Update a domain certificate](../operations/domain/domain-link-cert.md) | `setPrimaryCertificate` | `editor` for the domain or folder |
| **IAM** |  |
| [Assign](../../iam/operations/roles/grant.md), [revoke](../../iam/operations/roles/revoke.md), and view roles granted for the resource or cloud | `setAccessBinding`, `updateAccessBindings`, `listAccessBindings` | `admin` or `certificate-manager.admin` for the certificate, domain, or folder |

#### What's next {what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [For more information about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

