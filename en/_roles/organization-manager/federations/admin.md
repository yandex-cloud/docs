The `organization-manager.federations.admin` role enables managing identity federations, federated users, and certificates, as well as viewing info on the organization, its settings, and users.

Users with this role can:
* View info on the Identity Hub [organization](../../../organization/concepts/organization.md) and its settings.
* View info on [identity federations](../../../organization/concepts/add-federation.md) and create, modify, and delete such federations.
* View info on [certificates](../../../organization/concepts/add-federation.md#build-trust) and create, modify, and delete them.
* Add and remove [federated users](../../../iam/concepts/users/accounts.md#saml-federation).
* Revoke federated users' [refresh tokens](../../../iam/concepts/authorization/refresh-token.md).
* Delete [MFA factors](../../../iam/concepts/users/accounts.md#saml-federation) for federated and [local](../../../iam/concepts/users/accounts.md#saml-federation) user accounts.
* Reset the verification date for federated and local user accounts.
* Configure [mapping](../../../organization/concepts/add-federation.md#group-mapping) for [federated user](../../../iam/concepts/users/accounts.md#saml-federation) groups.
* View the lists of federated user group mappings and info on them, as well as create, edit, and delete such lists.
* View the list of the organization's [users](../../../overview/roles-and-resources.md#users), info on them (including their phone number), their latest authentication date, and the latest verification date for federated and local accounts via [two-factor authentication](../../../organization/concepts/mfa.md).
* View the list of [groups](../../../organization/concepts/groups.md) that users are members of.
* View the list of and info on Identity Hub user groups associated with identity federations through synchronization with user groups in Active Directory or another external source.
* Associate user groups with identity federations through synchronization with user groups in Active Directory or another external source, as well as disassociate them.
* View the [attributes](../../../organization/operations/setup-federation.md#claims-mapping) of federated and local users.

This role includes the `organization-manager.federations.editor`, `organization-manager.federations.extGroupsManager`, and `organization-manager.federations.extGroupsCleaner` permissions.

To configure user group mapping, the role must be assigned for the Identity Hub groups you intend to map.