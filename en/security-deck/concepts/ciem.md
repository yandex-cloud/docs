---
title: Cloud Infrastructure Entitlement Management in {{ sd-full-name }}
description: This section describes the {{ sd-name }} Cloud Infrastructure Entitlement Management ({{ ciem-name }}) module, which allows you to view the access permissions that an organization’s users have for its resources and, if required, revoke such permissions.
---

# Cloud Infrastructure Entitlement Management ({{ ciem-name }})

To ensure data and cloud infrastructure [security](../../security/standard/all.md), you need to regularly audit the access permissions of [users](../../overview/roles-and-resources.md#users) and [service accounts](../../iam/concepts/users/accounts.md#sa).

[Cloud Infrastructure Entitlement Management]({{ link-sd-main }}iam-diagnostics/), or {{ ciem-name }}, provides a centralized [view](../operations/ciem/view-permissions.md) of the full list of access permissions for organization [resources](../../iam/concepts/access-control/resources-with-access-control.md) granted to [subjects](../../iam/concepts/access-control/index.md#subject): users, service accounts, [user groups](../../organization/concepts/groups.md), [system groups](../../iam/concepts/access-control/system-group.md), and [public groups](../../iam/concepts/access-control/public-group.md). The tool also makes it easy to [revoke](../operations/ciem/revoke-permissions.md) accesses from subjects.

## Viewing access permissions {#viewing-permissions}

Only [organization members](../../organization/concepts/membership.md) with the `organization-manager.viewer` [role](../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view access permissions in the [{{ sd-name }} interface]({{ link-sd-main }}iam-diagnostics/).

For each access permission, the list indicates the name/ID and type of resource to which access was granted, the [role](../../iam/concepts/access-control/roles.md) assigned to the subject for that resource, and information about whether the role was assigned to the subject directly or was inherited from a group of which the subject is a member.

Cloud Infrastructure Entitlement Management allows you to view the access permissions assigned to an individual subject (user or service account):
* Directly
* Via a user group
* Via a system group
* Via a public group

To check whether access to a particular resource was assigned to a subject directly or via a group, refer to the **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** field of the table listing the subject’s access permissions. If the role was assigned directly, this field will be empty. In other cases, it will show the name of the group and its ID.

Access permissions are always assigned to groups directly, so for groups, the **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** field of the table with aceess permissions is always empty.

You can filter the list of access permissions granted to a subject by:
* ID of the resource the access was granted to.
* ID of the granted role.
* Assignment method, `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` or `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`.

{% note warning %}

Currently, Cloud Infrastructure Entitlement Management does not display subjects’ access permissions for [{{ datalens-full-name }}](../../datalens/index.yaml) resources and [billing accounts](../../billing/concepts/billing-account.md).

{% endnote %}

## Revoking access permissions {#revoking-permissions}

Cloud Infrastructure Entitlement Management allows you to [revoke](../operations/ciem/revoke-permissions.md) excessive access permissions from a subject or group as well as remove a subject from a user group, if required.

To revoke access permissions, users must have one of these roles: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner`, or the administrator role in the [service](../../overview/concepts/services.md) where they want to revoke the subject's access to a resource.

You can only remove a subject from a group created by an organization administrator. You cannot remove a subject from a system or public group.

#### See also {#see-also}

* [{#T}](../operations/ciem/view-permissions.md)
* [{#T}](../operations/ciem/revoke-permissions.md)