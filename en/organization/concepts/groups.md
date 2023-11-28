# User groups

For organizations with a lot of employees, multiple users may need to be granted the same access rights to {{ yandex-cloud }} resources. In this case, it is more convenient to grant roles and permissions to a group rather than individually. You can [set up a group member's access](../operations/manage-groups.md#access) to clouds, folders, service accounts, and organizations in {{ yandex-cloud }}.

Other users will be able to [manage the group](../operations/manage-groups.md#access-manage-group) if you grant them appropriate [roles](../security/index.md#service-roles), e.g., `organization-manager.groups.memberAdmin` to view data and add group members.

Groups may only have a one-level structure. You cannot create nested groups. Membership in a group provides all of its members with equal rights.

If you use user groups in your identity provider (IdP) when working with [federations](add-federation.md), you can [map groups](add-federation.md#group-mapping) between the IdP and {{ org-name }}.

#### What's next {#what-is-next}

* [Managing user groups](../operations/manage-groups.md)
* [Quotas and limits](limits.md)
