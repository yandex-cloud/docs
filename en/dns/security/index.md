---
title: "Access management in {{ dns-full-name }}"
description: "Access management in the service for managing DNS zones and domain names of your resources: {{ dns-full-name }}. This section describes which resources you can assign roles to, which roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ dns-name }}

In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/dns/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

* {% include [dns.auditor](../../_includes/iam/roles/dns-auditor-short.md) %}
* {% include [dns.viewer](../../_includes/iam/roles/dns-viewer-short.md) %}
* {% include [dns.editor](../../_includes/iam/roles/dns-editor-short.md) %}
* {% include [dns.admin](../../_includes/iam/roles/dns-admin-short.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#required-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, assign `editor` instead of `viewer` or `dns.admin` instead of `dns.editor`.

| Action | Methods | Required roles |
|:----------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Viewing metadata** |                                                                   |                                                                                                                                                                                             |
| Viewing information about DNS zones | `get`, `list` | `dns.auditor` for this resource |
| **View data** |                                                                   |                                                                                                                                                                                             |
| Viewing information about DNS zones and their resource records | `get`, `list`, `listRecordSets` | `viewer` or `dns.viewer` for the resource in question |
| **Manage DNS zones** |                                                                   |                                                                                                                                                                                             |
| Create a zone | `create` | `editor` or `dns.editor` for the folder as well as `vpc.user` for the folder and the {{ vpc-short-name }} network if it is an internal zone |
| Edit and delete zones | `update`, `delete` | `editor` or `dns.editor` for the folder as well as `vpc.user` for the folder and the {{ vpc-short-name }} network if it is an internal zone |
| Creating subzones | `create` | `editor` or `dns.editor` for the folder housing the zone that will include the subzones being created as well as `vpc.user` for this folder or {{ vpc-short-name }} network if it is an internal zone |
| **Manage resource records** |                                                                   |                                                                                                                                                                            |
| Create resource records in a DNS zone | `create` | `editor` or `dns.editor` for the folder or zone |
| Edit and delete resource records | `update`, `delete` | `editor` or `dns.editor` |
| **Manage access to DNS zones** |                                                                   |                                                                                                                                                                            |
| [Grant a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view roles granted for DNS zones | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` or `dns.admin` for the folder or zone |

To restrict user access, assign users roles for individual zones or subzones.


#### What's next {#next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
