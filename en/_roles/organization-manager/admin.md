The `organization-manager.admin` role enables managing organization settings, identity federations, users and their groups, and the user access permissions to the organization and its resources.

{% cut "Users with this role can:" %}

* Link a [billing account](../../billing/concepts/billing-account.md) to an [organization under Cloud Organization](../../organization/concepts/organization.md).
* View and edit info on the relevant organization under Cloud Organization.
* View and edit organization settings.
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the relevant organization and modify such permissions.
* View info on the [identity federations](../../organization/concepts/add-federation.md) in an organization and create, modify, and delete such federations.
* View the list of the organization users and info on them, as well as remove such users from the organization.
* View the info on the invites to the organization sent to the users, as well as [send](../../organization/operations/add-account.md#send-invitation) and delete such invites.
* Add and remove federated users.
* View the list of the organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events, as well as edit this list.
* View info on the [certificates](../../organization/concepts/add-federation.md#build-trust) and add, modify, and delete them.
* Configure [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mapping](../../organization/concepts/add-federation.md#group-mapping).
* View the lists of federated user group mappings and info on them, as well as create, edit, and delete such lists.
* View info on the federated user attributes, as well as create, modify, and delete them.
* View info on the organization's [OS Login](../../organization/concepts/os-login.md) settings and modify them.
* View the list of the users' and [service accounts’](../../iam/concepts/users/service-accounts.md) OS Login [profiles](../../organization/concepts/os-login.md#os-login-profiles), as well as create, modify, and delete such profiles.
* View the list of the organization users' SSH keys and info on such keys, as well as create, modify, and delete them.
* View info on [user groups](../../organization/concepts/groups.md), as well as create, modify, and delete them.
* Add users and service accounts to and remove them from groups.
* View info on the access permissions granted for the relevant user groups and modify such permissions.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View and edit the [refresh token](../../iam/concepts/authorization/refresh-token.md) settings in an organization.
* View the info on the refresh tokens of the organization’s federated users, as well as revoke such tokens.
* View info on Cloud Organization quotas.
* View the info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and the info on them, as well as create and close such requests, leave comments, and attach files to them.

{% endcut %}

This role includes the `organization-manager.editor`, `organization-manager.federations.admin`, and `organization-manager.osLogins.admin` permissions.