---
title: Revoking access permissions in {{ sd-full-name }} {{ ciem-name }}
description: In this section, you will learn how to revoke account or group access permissions for organization resources in {{ sd-name }}.
---

# Revoking subject's access

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Cloud Infrastructure Entitlement Management](../../concepts/ciem.md) provides a centralized view of the list of accesses to the organization's [resources](../../../iam/concepts/access-control/resources-with-access-control.md) available to the [subjects](../../../iam/concepts/access-control/index.md#subject) and groups and revoke them as needed.

Accesses can be revoked by a user with the `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, or `organization-manager.organizations.owner` role, or with the admin role for the [service](../../../overview/concepts/services.md) to whose resource the subject’s access is being revoked.

To revoke a subject's access (role) for a resource:

1. [Open](./view-permissions.md) the list of the subject's accesses and select the one you want to revoke.

    Use filtering by resource ID, role ID, or access assignment method (`{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` or `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`), if required.

1. Revoke access based on the assignment method used:

    {% list tabs %}

    - Direct assignment

      If access is assigned to the subject directly (the **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** field is left blank):

      1. In the row with the access you need, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![person-xmark](../../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.iam-bindings.subject.title_revoke-access-dialog }}**.
      1. In the window that opens, verify info on the resource you are revoking access to and select the roles to revoke.
      1. Click **{{ ui-key.yacloud_org.iam-bindings.subject.action_revoke-all }}** (or **Revoke selected** if you left some roles unselected).

    - Group-based assignment

      If access is assigned to the subject through a group (the **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** field contains the group name and ID), such access cannot be revoked from the subject. Instead, you can either remove the subject from this user group or revoke the access from the whole group.

      * To remove a subject from a [user group](../../../organization/concepts/groups.md):

          1. In the row with the access, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![person-xmark](../../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.entity.group.action_remove-user }}**.
          1. In the window that opens, review the list of accesses the subject will lose when removed from the group, and click **{{ ui-key.yacloud_org.actions.exclude }}**.

          You cannot remove a subject from a [system group](../../../iam/concepts/access-control/system-group.md) or [public group](../../../iam/concepts/access-control/public-group.md). To revoke access granted through one of these groups, you have to revoke that access from the whole group.

      * To revoke access from the whole group, [open](./view-permissions.md) the list of accesses for that group and follow the guide on how to revoke directly assigned access.

{% endlist %}

#### See also {#see-also}

* [{#T}](./view-permissions.md)
* [{#T}](../../concepts/ciem.md)
* [{#T}](../../security/index.md)