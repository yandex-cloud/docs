---
title: Access management in {{ certificate-manager-full-name }}
description: Access management in {{ certificate-manager-full-name }}, a service used to issue and update Let's Encrypt TLS certificates and upload custom certificates. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.
---

# Access management in {{ certificate-manager-name }}

In this section, you will learn about:
* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required](#choosing-roles) for specific actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `certificate-manager.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [Let's Encrypt certificate](../concepts/managed-certificate.md) or [custom certificate](../concepts/imported-certificate.md) via the {{ yandex-cloud }} [CLI](../../cli/cli-ref/certificate-manager/cli-ref/certificate/add-access-binding.md), [{{ TF }}]({{ tf-provider-resources-link }}/cm_certificate_iam_binding), or the [API](../api-ref/authentication.md).

## Roles this service has {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

{% include [certificate-manager](../../_mermaid/roles/certificate-manager.md) %}

### Service roles {#service-roles}

#### certificate-manager.auditor {#certificate-manager-auditor}

{% include [certificate-manager.auditor](../../_roles/certificate-manager/auditor.md) %}

#### certificate-manager.viewer {#certificate-manager-viewer}

{% include [certificate-manager.viewer](../../_roles/certificate-manager/viewer.md) %}

#### certificate-manager.editor {#certificate-manager.editor}

{% include [certificate-manager.editor](../../_roles/certificate-manager/editor.md) %}

#### certificate-manager.admin {#certificate-manager-admin}

{% include [certificate-manager.admin](../../_roles/certificate-manager/admin.md) %}

#### certificate-manager.certificates.downloader {#certificate-manager-certificates-downloader}

{% include [certificate-manager.certificates.downloader](../../_roles/certificate-manager/certificates/downloader.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`.

Action | Methods | Required roles
----- | ----- | -----
**Certificate Manager** | | 
Getting lists of certificates | `list` | `viewer` for the folder
Get certificate details | `get` | `viewer` for certificate or folder
[Adding](../operations/managed/cert-create.md) a Let's Encrypt certificate | `requestNew` | `editor` for folder
[Updating](../operations/managed/cert-modify.md) and [deleting](../operations/managed/cert-delete.md) a Let's Encrypt certificate | `update`, `delete` | `editor` for certificate or folder
[Adding](../operations/import/cert-create.md) a custom certificate | `create` | `editor` for the folder
[Renewing](../operations/import/cert-update.md), [updating](../operations/import/cert-modify.md), or [deleting](../operations/import/cert-delete.md) a custom certificate | `update`, `delete` | `editor` for certificate or folder
Getting the contents of a [custom certificate](../operations/import/cert-get-content.md) or [Let's Encrypt certificate](../operations/managed/cert-get-content.md) | `get-content` | `certificate-manager.certificates.downloader` for certificate or folder
**IAM** | |
[Assigning a role](../../iam/operations/roles/grant.md), [revoking a role](../../iam/operations/roles/revoke.md), and viewing the roles assigned for a folder or cloud | `setAccessBinding`, `updateAccessBindings`, `listAccessBindings` | `admin` or `certificate-manager.admin` for certificate or folder 

#### What's next {what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
