The `organization-manager.federations.editor` role enables managing identity federations, federated users, and certificates, as well as viewing info on the organization, its settings, and users.

Users with this role can:
* View info on the [organization](../../../organization/concepts/organization.md) and its settings.
* View info on the [identity federations](../../../organization/concepts/add-federation.md) and create, modify, and delete such federations.
* View info on the [certificates](../../../organization/concepts/add-federation.md#build-trust) and create, modify, and delete them.
* View the list of [user group mappings](../../../organization/concepts/add-federation.md#group-mapping) and info on them.
* Add and remove [federated users](../../../organization/concepts/add-federation.md#saml-authentication).
* Revoke federated users’ [refresh tokens](../../../iam/concepts/authorization/refresh-token.md).
* View the list of the organization [users](../../../overview/roles-and-resources.md#users) and info on them.
* View the list of the [groups](../../../organization/concepts/groups.md) the organization users are members of.
* View the [attributes](../../../organization/operations/setup-federation.md#claims-mapping) of the federated users.

This role also includes the `organization-manager.federations.viewer` and `organization-manager.federations.userAdmin` permissions.