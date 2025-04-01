The `organization-manager.admin` role enables managing organization settings, organization users and their groups, and the users' access permissions to the organization and its resources.

Users with this role can:
* Link a [billing account](../../billing/concepts/billing-account.md) to an [organization](../../organization/concepts/organization.md).
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the organization and its [user groups](../../organization/concepts/groups.md) and modify such permissions.
* View the list of the organization user groups and info on such groups, as well as view and modify the lists of users that are members of such groups.
* Configure user group [mapping](../../organization/concepts/add-federation.md#group-mapping).
* View the list of the organization [users](../../overview/roles-and-resources.md#users) and remove users from the organization.
* View the info on the invites to the organization sent to the users, as well as [send](../../organization/operations/add-account.md#send-invitation) and delete such invites.
* View info on the organization's [OS Login](../../organization/concepts/os-login.md) settings and modify them.
* View the lists of the organization federated users’ refresh tokens.
* View the list of the organization users' OS Login profiles, as well as create, modify, and delete OS Login profiles.
* View the list of the organization users' SSH keys and info on such keys, as well as create, modify, and delete them.
* View the info on the effective tech support [service plan](../../support/pricing.md#effective-plans).

This role also includes the `organization-manager.viewer` and `organization-manager.osLogins.admin` permissions.