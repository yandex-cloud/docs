---
title: Access management in {{ dns-full-name }}
description: Access management in {{ dns-full-name }}, a service for managing DNS zones and domain names of your resources. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ dns-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `dns.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To assign a role for a [DNS zone](../concepts/dns-zone.md), use the {{ yandex-cloud }} [CLI](../../cli/cli-ref/dns/cli-ref/zone/add-access-binding.md), [API](../api-ref/authentication.md), or [{{ TF }}]({{ tf-provider-resources-link }}/dns_zone_iam_binding).

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/dns/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### dns.auditor {#dns-auditor}

{% include [roles-dns-auditor](../../_roles/dns/auditor.md) %}

#### dns.viewer {#dns-viewer}

{% include [roles-dns-viewer](../../_roles/dns/viewer.md) %}

#### dns.editor {#dns-editor}

{% include [roles-dns-editor](../../_roles/dns/editor.md) %}

#### dns.admin {#dns-admin}

{% include [roles-dns-admin](../../_roles/dns/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#required-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `editor` role instead of `viewer`, or `dns.admin` instead of `dns.editor`.

| Action                                                                                                                                            |                              Methods                               | Required roles                                                                                                                                                                            |
|:----------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Viewing metadata**                                                                                                                         |                                                                   |                                                                                                                                                                                             |
| Viewing information about DNS zones                                                                                                                     |                           `get`, `list`                           | `dns.auditor` for the resource                                                                                                                                                                |
| **Viewing data**                                                                                                                             |                                                                   |                                                                                                                                                                                             |
| Viewing information about DNS zones and their resource records                                                                                           |                  `get`, `list`, `listRecordSets`                  | `viewer` or `dns.viewer` for the resource                                                                                                                                                    |
| **Manage DNS zones**                                                                                                                           |                                                                   |                                                                                                                                                                                             |
| Create a zone                                                                                                                                       |                             `create`                              | `editor` or `dns.editor` for the folder, as well as `vpc.user` for this folder or {{ vpc-short-name }} network if it is a private zone                                                                |
| Edit and delete zones                                                                                                                             |                        `update`, `delete`                         | `editor` or `dns.editor` for the folder, as well as `vpc.user` for this folder or {{ vpc-short-name }} network if it is a private zone                                                                |
| Creating subzones                                                                                                                                     |                             `create`                              | `editor` or `dns.editor` for the folder housing the zone that will comprise the new subzones, as well as `vpc.user` for this folder or {{ vpc-short-name }} network if it is a private zone |
| **Manage resource records**                                                                                                                  |                                                                   |                                                                                                                                                                            |
| Create resource records in a DNS zone                                                                                                               |                             `create`                              | `editor` or `dns.editor` for the folder or zone                                                                                                                              |
| Edit and delete resource records                                                                                                               |                        `update`, `delete`                         | `editor` or `dns.editor`                                                                                                                                                  |
| **Manage access to DNS zones**                                                                                                                 |                                                                   |                                                                                                                                                                            |
| [Grant a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view roles granted for DNS zones | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` or `dns.admin` for the folder or zone                                                                                                                                |

To restrict user access, assign users roles for individual zones or subzones.


#### What's next {#next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
