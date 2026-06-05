
The `organization-manager.osLogins.admin` role enables managing the organization's {{ oslogin }} settings, as well as the users' {{ oslogin }} profiles and SSH keys.

Users with this role can:
* View info on the organization's [{{ oslogin }}](../../../organization/concepts/os-login.md) settings and modify them.
* View the list of the [organization](../../../organization/concepts/organization.md) users' and [service accounts’](../../../iam/concepts/users/service-accounts.md) {{ oslogin }} [profiles](../../../organization/concepts/os-login.md#os-login-profiles), as well as create, modify, and delete such profiles.
* View the list of the organization users' SSH keys and info on such keys, as well as create, modify, and delete them.

This role includes the `organization-manager.osLogins.viewer` permissions.