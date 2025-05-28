---
title: User groups
description: You can organize the organization users into groups to grant the same role to multiple users.
---

# User groups

In [organizations](organization.md) with many [users](membership.md), you may need to issue the same access permissions for {{ yandex-cloud }} resources to more than one user. In which case it is easier to issue roles and permissions to groups rather than individual users. Group members can [get access](../operations/access-group.md) to {{ yandex-cloud }} organizations, clouds, folders, and service accounts.

Other users will be able to [manage the group](../operations/access-manage-group.md) if you grant them the relevant [roles](../security/index.md#service-roles), e.g., `organization-manager.groups.memberAdmin` to view data and add group members.

In addition to groups created by the administrator, {{ yandex-cloud }} also has [system groups](../../iam/concepts/access-control/system-group.md) (`All users in organization X` and `All users in federation N`) and [public groups](../../iam/concepts/access-control/public-group.md) (`All authenticated users` and `All users`).

Groups may only have a one-level structure. You cannot create nested groups. Membership in a group provides all of its members with equal rights.

If you use user groups in your identity provider (IdP) when working with [federations](add-federation.md), you can [map groups](add-federation.md#group-mapping) between the IdP and {{ org-name }}.

## Use cases {#examples}

* [{#T}](../tutorials/user-group-access-control.md)
* [{#T}](../tutorials/federations/group-mapping/adfs.md)
* [{#T}](../tutorials/federations/group-mapping/entra-id.md)
* [{#T}](../tutorials/federations/group-mapping/keycloak.md)
* [{#T}](../../tutorials/security/integration-azure.md)

#### What's next {#what-is-next}

* [Managing user groups](../operations/manage-groups.md)
* [Quotas and limits](limits.md)
