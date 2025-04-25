The `organization-manager.viewer` role enables viewing info on the organization and its settings, as well as on the identity federations, users and user groups within the organization.

{% cut "Users with this role can:" %}

* View info on the [organization](../../organization/concepts/organization.md) under Cloud Organization and its settings.
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the organization.
* View info on the organization’s [identity federations](../../organization/concepts/add-federation.md).
* View the list of the organization [users](../../overview/roles-and-resources.md#users).
* View the list of the organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events.
* View info on [certificates](../../organization/concepts/add-federation.md#build-trust).
* View the list of [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mappings](../../organization/concepts/add-federation.md#group-mapping) and info on them.
* View info on the attributes of the federated users.
* View info on the organization's [OS Login](../../organization/concepts/os-login.md) settings.
* View the list of OS Login [profiles](../../organization/concepts/os-login.md#os-login-profiles) for users and service accounts.
* View the list of the organization users' SSH keys and the info on such keys.
* View info on the [user groups](../../organization/concepts/groups.md) and access permissions granted for them.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View the info on the [refresh tokens](../../iam/concepts/authorization/refresh-token.md) of the organization’s federated users and on the refresh token settings.
* View info on Cloud Organization quotas.
* View the info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and the info on them, as well as create and close such requests, leave comments, and attach files to them.

{% endcut %}

This role also includes the `organization-manager.auditor` and `organization-manager.users.viewer` permissions.