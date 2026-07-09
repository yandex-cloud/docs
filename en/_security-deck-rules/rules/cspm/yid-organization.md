### Yandex ID accounts are used only in exceptional cases {#yid-organization}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | yid-organization ||
|#

#### Description

**How the rule works**: The rule is considered violated if even one Yandex ID account has been found in the organization.

**Risks when not complying with the rule**:

* Yandex ID accounts cannot be subject to any security policies. These latter include revoking and suspending accounts, limiting the number of unsuccessful login attempts, password policies, etc. * No centralized access revocation is possible when an employee resigns. If an employee resigns, their Yandex ID account continues existing independently of the organization. * The session lifetime cannot be managed. A long-term session on a compromised workstation enables attackers to act on behalf of the user without re-authenticating. * The OAuth token can be leaked. The OAuth token of a Yandex ID account is valid for one year.

[Federated accounts](https://yandex.cloud/en/docs/iam/concepts/users/accounts#saml-federation) offer more security than Yandex ID accounts.

Using an identity federation is the best way to reduce risks related to unauthorized access.

* Corporate security policies (password policies, suspension, 2FA) apply in a centralized and enforced fashion. * The account lifecycle is managed in IdP, and an employee's resignation automatically ends their access to Yandex Cloud. * The session lifetime is limited at the organization level. * Privileged roles are assigned to accounts protected with corporate tools for monitoring and device management. * Audit and incident response are carried out in a unified corporate system, rather than scattered across employees' accounts.

#### Instructions and solutions

Delete all Yandex ID accounts from your organization, apart from cases that qualify as allowed exceptions. For the remaining Yandex ID accounts, [set up 2FA](https://yandex.com/support/id/en/authorization/twofa.html).

The following exceptions are allowed:

* Account with the `billing.accounts.owner` permissions (technically, only a Yandex ID account can have this role at the moment). * Account with the `organization-manager.organizations.owner` and `resource-manager.clouds.owner` permissions, if used in emergencies only, e.g., when the configuration of your federation fails. If you need to, you can [delete](https://yandex.cloud/en/docs/security/operations/account-deletion) a privileged [Yandex account](https://yandex.cloud/en/docs/iam/concepts/users/accounts#passport) with the `organization-manager.organizations.owner` role from an organization. * External accounts, such as those of your contract partners or contractors, which, for whatever reason, you cannot register in your federation.
