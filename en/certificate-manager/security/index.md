---
title: "Access management in {{ certificate-manager-full-name }}"
description: "Access management in {{ certificate-manager-full-name }}, a service for issuing and updating TLS certificates from Let's Encrypt and for uploading custom certificates. This section describes which resources you can assign a role for, what roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ certificate-manager-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or [certificate](../concepts/index.md). These roles also apply to nested resources.

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/certificate-manager/service-roles-hierarchy-with-admin.svg)

### Service roles {#service-roles}

Active roles in the service:

* {% include [certificate-manager.auditor](../../_includes/iam/roles/short-descriptions/certificate-manager.auditor.md) %}
* {% include [certificate-manager.viewer](../../_includes/iam/roles/short-descriptions/certificate-manager.viewer.md) %}
* {% include [certificate-manager.editor](../../_includes/iam/roles/short-descriptions/certificate-manager.editor.md) %}
* {% include [certificate-manager.admin](../../_includes/iam/roles/short-descriptions/certificate-manager.admin.md) %}
* {% include [certificate-manager.certificates.downloader](../../_includes/iam/roles/short-descriptions/certificate-manager.certificates.downloader.md) %}
* {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
* {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, you can assign the `editor` role instead of the `viewer` one.

| Action | Methods | Required roles |
----- | ----- | -----
| **Certificate Manager** | |
| Getting a list of certificates or domains | `list` | `viewer` for a folder |
| Getting certificate or domain details | `get` | `viewer` for a certificate or folder |
| [Adding](../operations/managed/cert-create.md) a Let's Encrypt certificate | `requestNew` | `editor` for the folder |
| [Updating](../operations/managed/cert-modify.md) and [deleting](../operations/managed/cert-delete.md) a Let's Encrypt certificate | `update`, `delete` | `editor` for the certificate or folder |
| [Adding](../operations/import/cert-create.md) a custom certificate | `create` | `editor` for the folder |
| [Renewing](../operations/import/cert-update.md), [updating](../operations/import/cert-modify.md), or [deleting](../operations/import/cert-delete.md) a custom certificate | `update`, `delete` | `editor` for the certificate or folder |
| Getting the contents of a [custom certificate](../operations/import/cert-get-content.md) or [Let's Encrypt certificate](../operations/managed/cert-get-content.md) | `get-content` | `certificate-manager.certificates.downloader` for the certificate or folder |
| [Adding a domain](../operations/domain/domain-create.md) | `create` | `editor` for the folder |
| [Updating a domain](../operations/domain/domain-modify.md) and [deleting a domain](../operations/domain/domain-delete.md) | `update`, `delete` | `editor` for the domain or folder |
| [Updating a domain certificate](../operations/domain/domain-link-cert.md) | `setPrimaryCertificate` | `editor` for the domain or folder |
| **IAM** | |
| [Assigning a role](../../iam/operations/roles/grant.md), [revoking a role](../../iam/operations/roles/revoke.md), and viewing the roles assigned for a folder or cloud | `setAccessBinding`, `updateAccessBindings`, `listAccessBindings` | `admin` or `certificate-manager.admin` for the certificate, domain, or folder |

#### What's next {what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
