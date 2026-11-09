---
title: '{{ access-analyzer-name }} in {{ sd-full-name }}'
description: This section describes the {{ sd-name }} {{ access-analyzer-name }} module, which allows you to view the access permissions that an organization’s subjects have for resources and, if required, update or revoke such permissions.
---

# {{ access-analyzer-name }} module

To ensure data and cloud infrastructure [security](../../security/standard/all.md), you need to regularly audit the access permissions of [users](../../overview/roles-and-resources.md#users) and [service accounts](../../iam/concepts/users/accounts.md#sa).

[{{ access-analyzer-name }}]({{ link-sd-main }}access-analyzer/) is designed for analyzing access permissions of organization [subjects](../../iam/concepts/access-control/index.md#subject) for its resources, detecting unused and excessively granted privileges, and running diagnostics of access permissions to reduce information security risks.

## Recommendations {#recommendations}

{% include [access-analyzer-recommendations-preview-notice](../../_includes/security-deck/access-analyzer-recommendations-preview-notice.md) %}

{{ access-analyzer-name }} automatically analyzes roles assigned to users and groups for [folders](*folder_definition), [clouds](*cloud_definition), and [organizations](*organization_definition) and provides, in each individual case, specific _recommendations_ to improve security. The module does not provide recommendations regarding roles assigned to subjects for specific {{ yandex-cloud }} service resources, such as virtual machines, service accounts, managed database clusters, etc.

Analysis of roles starts when the {{ access-analyzer-name }} module is enabled in the [workspace](./workspace.md) settings. After that, it runs regularly and automatically. The date and time of the last analysis are [displayed](../operations/access-analyzer/use-recommendations.md#view) on the page with a list of recommendations under the filter bar.

If the {{ access-analyzer-name }} module is disabled in the workspace settings, the recommendation feature is not available.

When running analysis or generating recommendations, {{ access-analyzer-name }} uses system logs of [{{ iam-full-name }}](../../iam/index.yaml) authorizations over the last 90 days.

{% include [access-analyzer-recommendations-view-role-notice](../../_includes/security-deck/access-analyzer-recommendations-view-role-notice.md) %}

Roles can be revoked or changed by users holding one of the following roles: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, and `organization-manager.organizations.owner`.

### Recommendation types {#recommendation-types}

Each recommendation suggest performing one of the following actions:

* [Replacing the current role](../operations/access-analyzer/use-recommendations.md#replace) with another, more [granular](*granular_definition) role or role group.

    Depending on your situation, the service may suggest one to five roles as a replacement. In this case, the total scope of permissions provided by the new roles is always less than that of the current role.
* [Revoking a role](../operations/access-analyzer/use-recommendations.md#revoke) from a subject.

    Revoking a role is recommended when permissions provided by the current role of the subject have not been used for authorizing operations in {{ yandex-cloud }} during the last 90 days.

If any recommendations do not suit you, you can [hide](../operations/access-analyzer/use-recommendations.md#manage-visibility) them.

For more information on working with recommendations, see [{#T}](../operations/access-analyzer/use-recommendations.md).

{% include [access-analyzer-recommendations-responsibility-alert](../../_includes/security-deck/access-analyzer-recommendations-responsibility-alert.md) %}

## Access diagnostics {#viewing-permissions}

{% note info %}

This {{ access-analyzer-name }} feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

The access diagnostics functionality allows you to view the access permissions assigned to an individual subject (user or service account):

* Directly
* Via a user group
* Via a system group
* Via a public group

For each access permission, the list indicates the name/ID and type of [resource](../../iam/concepts/access-control/resources-with-access-control.md) to which access was granted, the [role](../../iam/concepts/access-control/roles.md) assigned to the subject for that resource, and information about whether the role was assigned to the subject directly or was inherited from a group of which the subject is a member.

To check whether access to a particular resource was assigned to a subject directly or via a group, refer to the **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** field of the table listing the subject’s access permissions. If the role was assigned directly, this field will be empty. In other cases, it will show the name of the group and its ID.

Access permissions are always assigned to groups directly, so for groups, the **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** field of the table with aceess permissions is always empty.

You can filter the list of access permissions granted to a subject by:

* ID of the resource the access was granted to.
* ID of the granted role.
* Assignment method, `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` or `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`.

Only [organization members](../../organization/concepts/membership.md) with the `organization-manager.viewer` [role](../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view access permissions in the [{{ sd-name }} interface]({{ link-sd-main }}access-analyzer/). In this case you can use access diagnostics even if the {{ access-analyzer-name }} module is not enabled in the [workspace](./workspace.md) settings.

The access diagnostics functionality allows you to [revoke](../operations/access-analyzer/analyze-permissions.md#revoke) excessive access permissions from individual subjects or groups and remove individual subjects from user groups.

To revoke access permissions, users must have one of these roles: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner`, or the administrator role in the [service](../../overview/concepts/services.md) where they want to revoke the subject's access to a resource.

You can only remove a subject from a group created by an organization administrator. You cannot remove a subject from a system or public group.

#### Useful links {#see-also}

* [{#T}](../operations/access-analyzer/use-recommendations.md)
* [{#T}](../operations/access-analyzer/analyze-permissions.md)

[*folder_definition]: {% include [folder-definition](../../_popups/resource-manager/folder-definition.md) %}

[*cloud_definition]: {% include [cloud-definition](../../_popups/resource-manager/cloud-definition.md) %}

[*organization_definition]: {% include [organization-definition](../../_popups/identity-hub/organization-definition.md) %}

[*granular_definition]: {% include [granularity-in-access-management-definition](../../_popups/granularity-in-access-management-definition.md) %}
