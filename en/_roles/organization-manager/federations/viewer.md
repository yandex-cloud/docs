The `organization-manager.federations.viewer` role enables viewing info on the organization and its settings, the identity federations, and user group mappings.

Users with this role can:
* View info on the Identity Hub [organization](../../../organization/concepts/organization.md) and its settings.
* View info on [identity federations](../../../organization/concepts/add-federation.md).
* View info on [certificates](../../../organization/concepts/add-federation.md#build-trust).
* View the list of [user group mappings](../../../organization/concepts/add-federation.md#group-mapping) and info on them.
* View the list of the organization’s [users](../../../overview/roles-and-resources.md#users), info on them (including their phone number), their latest authentication date, and the latest verification date for federated and local accounts via [two-factor authentication](../../../organization/concepts/mfa.md).
* View the list of [groups](../../../organization/concepts/groups.md) that users are members of.
* View the [attributes](../../../organization/operations/setup-federation.md#claims-mapping) of federated and local users.

This role includes the `organization-manager.federations.auditor` permissions.