---
title: Authentication and authorization security checklist
description: This article provides a checklist of measures for authentication, authorization, and {{ yandex-cloud }} resource access control.
---

# Authentication and authorization security checklist

This section provides recommendations for protecting authentication, authorization, and access to {{ yandex-cloud }} resources.

## Accounts {#accounts}

&#x2713; **Protect your Yandex accounts**:

   * Enable [two-factor authentication](https://yandex.ru/support/passport/authorization/twofa.html) for your [Yandex ID](../../iam/concepts/users/accounts.md#passport) and for user accounts within the organization.
   * Store your [OAuth token](../../iam/concepts/authorization/oauth-token.md) in a secret. If your token has been compromised, [revoke it](https://yandex.ru/dev/oauth/doc/dg/reference/token-invalidate-docpage/) and issue a new one. Where possible, use an IAM token: it is valid for {{ iam-token-lifetime }}, whereas an OAuth token, for one year.

&#x2713; **Configure MFA for federated and local accounts**: Enable [multi-factor authentication](../../organization/concepts/mfa.md) (MFA) for [federated](../../iam/concepts/users/accounts.md#saml-federation) and [local](../../iam/concepts/users/accounts.md#local) accounts and set requirements in MFA policies.

&#x2713; **Use an identity federation**: Configure a [SAML-compatible identity federation](../../organization/concepts/add-federation.md) to allow your employees to log in to {{ yandex-cloud }} using external corporate accounts.

&#x2713; **Use user pools for local accounts**: [User pools](../../organization/concepts/user-pools.md) allow you to manage local users, domains, access permissions, and authentication settings in a centralized way.

&#x2713; **Configure SSO for external systems**: Use [{{ org-full-name }} applications](../../organization/concepts/applications.md), if you want {{ yandex-cloud }} to act as an identity provider (IdP) for external services.

## Roles and resources {#resources-and-roles}

&#x2713; **Adhere to the least privilege principle**: [Assign](../../iam/operations/roles/grant.md) service roles instead of primitive ones and grant only those permissions that are currently required. Keep [role inheritance](../../iam/concepts/access-control/index.md#inheritance) in mind and assign the [administrator](../../iam/roles-reference.md#admin), [owner](../../resource-manager/security/index.md#resource-manager-clouds-owner), and `editor` roles only to those users who really need them.

&#x2713; **Use access policies**: Manage permissions for operations in a folder, cloud, or organization for all subject types using [access policies](../../iam/concepts/access-control/access-policies.md).

&#x2713; **Assign `{{ roles-auditor }}` where data access is not required**: This role suits, e.g., external contractors and auditors, helping you observe the least privilege principle.

&#x2713; **Protect privileged roles**: Assign these roles to federated or local accounts but not Yandex acccounts. This way, you can apply MFA and achieve centralized access management.

   * **Limit the use of `billing.accounts.owner`**: Use this role only for initial setup and occasional changes. For day-to-day billing account management, assign the `admin`, `editor`, or `viewer` role to an employee. For a Yandex ID with the `billing.accounts.owner` role, enable 2FA, set a complex password, and use it only if you have to.

   * **Protect `organization-manager.organizations.owner`**: Delegate the role to a federated or local account, then delete the Yandex account with this role from your organization. To protect your reserved Yandex ID, use a complex password and log in only if the federation operates abnormally. See the steps in [Deleting a Yandex account from an organization](../operations/account-deletion.md).

&#x2713; **Audit access permissions on a regular basis**: Check permissions of users and service accounts using [{{ ciem-name }}](../../security-deck/concepts/ciem.md) or the [{{ yandex-cloud }} CLI](../../cli/), revoke excessive roles, and block or delete unused accounts that are over 30 days old.

&#x2713; **Use a correct resource model**:

   * Group resources by purpose and place them in separate folders or, for stricter isolation, separate clouds.
   * Isolate critical resources (e.g., related to payment or personal data) in separate folders or clouds.
   * Place shared resources (e.g., network and security groups) in a separate folder for shared resources.

## Service accounts {#service-accounts}

&#x2713; **Use service accounts for automation**: You can check the date and time of the last authentication on the service account page in the management console.

&#x2713; **Create separate service accounts for different tasks**: This makes it easier to limit roles and revoke access without affecting other processes.

&#x2713; **Use impersonation where possible**: [Impersonation](../../iam/operations/sa/impersonate-sa.md) allows you to temporarily act under a service account without generating static credentials.

&#x2713; **Use IAM tokens**: An [IAM token](../../iam/concepts/authorization/iam-token.md) is valid for {{ iam-token-lifetime }} and, therefore, is more secure than long-lived keys. Compromised or excessive tokens should be [revoked](../../iam/operations/iam-token/revoke-iam-token.md). For more on issuing a token, see [this guide](../../iam/operations/iam-token/create-for-sa.md).

&#x2713; **Control the use of keys**: On the service account page in the [management console]({{ link-console-main }}), track the date and time of the last use of the keys and delete unused ones.

&#x2713; **Limit scopes and validity periods of API keys**: Create keys only with required [scopes](../../iam/concepts/authorization/api-key.md#scoped-api-keys) and minimum validity periods.

&#x2713; **Rotate service account keys regularly**: Make sure you rotate [authorized](../../iam/concepts/authorization/key.md) and [static](../../iam/concepts/authorization/access-key.md) keys without a validity period manually at least every 90 days. Consider using [ephemeral keys](../../iam/concepts/authorization/ephemeral-keys.md) or a [secure token service](../../iam/concepts/authorization/sts.md) to access {{ objstorage-name }}.

&#x2713; **Use workload identity federations**: [Workload identity federations](../../iam/concepts/workload-identity.md) allow you to exchange tokens from external OIDC-compatible systems for IAM tokens without using long-lived credentials.

&#x2713; **Use ID tokens for external systems**: You can use [ID tokens](../../iam/concepts/authorization/id-token.md) to authenticate service accounts in external OIDC-compatible systems.

&#x2713; **Associate a service account with a virtual machine for operations from within the VM**: This way, you will not need to store keys on the VM, and the IAM token will be available via the [metadata service](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).

## Secrets {#secrets}

&#x2713; **Track {{ yandex-cloud }} secrets in public sources**: The service allows detecting API keys, {{ iam-short-name }} cookies, IAM tokens, static access keys, OAuth tokens, and {{ captcha-full-name }} server keys. [Read more](../operations/search-secrets.md).

&#x2713; **Revoke publicly exposed secrets**: Revoke and reissue them, check for unauthorized actions, delete redundant resources, and report incidents to [support]({{ link-console-support }}). [Read more](../../iam/operations/compromised-credentials.md).

&#x2713; **Store keys and tokens in {{ lockbox-name }}**: Store them in [{{ lockbox-name }} secrets](../../lockbox/tutorials/static-key-in-lockbox/index.md) and use the secret payload when accessing them.

&#x2713; **Use {{ oslogin }} for centralized SSH access**: [{{ oslogin }}](../../organization/concepts/os-login.md) enables you to manage access to VMs via {{ iam-full-name }} and store SSH keys in {{ org-full-name }} profiles. To use the service, [enable access](../../organization/operations/os-login-access.md) at the organization level.
