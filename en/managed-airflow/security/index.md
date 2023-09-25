---
title: "Access management in {{ maf-full-name }}"
description: "Access management in the {{ AF }} database creation and management service. This section describes which resources you can assign roles to, which roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ maf-name }}


In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ maf-name }} service resources, assign the user the appropriate roles for the folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

Below is a list of all roles that are used to verify access rights in the service.

{% include [maf-viewer](../../_includes/iam/roles/maf-viewer.md) %}

{% include [maf-editor](../../_includes/iam/roles/maf-editor.md) %}

{% include [maf-admin](../../_includes/iam/roles/maf-admin.md) %}

### {{ roles-viewer }} {#viewer}

The `{{ roles-viewer }}` role enables you to view information about {{ maf-name }} clusters and their runtime logs.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resource, e.g., create clusters and create and delete their subclusters.

This role includes the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, e.g., allow other users to create {{ maf-name }} clusters and to view information about user rights.

This role includes the `{{ roles-editor }}` role.

### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

