---
title: Authentication and authorization security checklist
description: This article provides a checklist of measures for authentication, authorization, and {{ yandex-cloud }} resource access control.
---

# Authentication and authorization security checklist

This section provides recommendations on how to make the best use of {{ yandex-cloud }} services for secure authentication, authorization, and resource access control.

## Accounts {#accounts}

&#x2713; **Yandex account protection**:

   * Enable [two-factor authentication](https://yandex.ru/support/passport/authorization/twofa.html) for your Yandex ID and for user accounts within your organization.
   * Keep your [OAuth token](../../iam/concepts/authorization/oauth-token.md) confidential. If someone might have discovered your OAuth token, [invalidate it](https://yandex.ru/dev/oauth/doc/dg/reference/token-invalidate-docpage/) and issue a new one. Avoid using your OAuth token for authentication if you can use an IAM token. OAuth tokens are valid for 1 year while IAM tokens are valid for {{ iam-token-lifetime }}.

&#x2713; **Identity federation (Single Sign-On, SSO)**: For the purpose of centralized account management, use [SAML-compatible identity federations](../../organization/concepts/add-federation.md). By using identity federations, a business can set up Single Sign-On to {{ yandex-cloud }} via their IdP server. This will allow your employees to use their corporate accounts for accessing {{ yandex-cloud }} services and enable you to manage users via the {{ yandex-cloud }} management console. Configure two-factor authentication on the identity provider side.

## Roles and resources {#resources-and-roles}

&#x2713; **Least privilege principle**: [Assign service roles (e.g., `compute.images.user`) instead of primitive ones (e.g., `auditor`, `viewer`, `editor`, or `admin`). See the [list of all roles](../../iam/roles-reference.md) for details.

   * Assign only roles you need right now. Do not assign roles you may only need in the future.
   * Note that when you assign a role for a folder, cloud, or organization, [all the nested resources will inherit](../../iam/concepts/access-control/index.md#inheritance) this role's permissions.
   * Assign the [admin](../../iam/roles-reference.md#admin) role only to users whose duties involve managing access to resources. 
   * Assign the cloud or organization [owner](../../resource-manager/security/index.md#resource-manager-clouds-owner) role only to users whose duties involve performing any actions with resources. An administrator can take away another administrator's access permissions, and an owner can revoke another owner's role.
   * Assign users service and primitive level `editor` roles to enable them to create and delete resources.
   * Use [impersonation](../../iam/concepts/access-control/index.md#impersonation) to allow users to manage cloud resources on behalf of a service account. Use service accounts with the required roles rather than assigning roles to specific users. This approach temporarily expands user permissions without generating static credentials for the user.

&#x2713; **Using the {{ roles-auditor }} role to prevent access to user data**: Assign the `{{ roles-auditor }}` role (the role with least privilege and without access to service data) to users who need no access to data, such as external contractors or auditors. To control access more selectively and implement the principle of least privilege, use the `{{ roles-auditor }}` role by default.

&#x2713; **billing.accounts.owner protection**: After completing the initial operations, do not use an account with this role. To manage a billing account, assign the `admin`, `editor`, or `viewer` role for the billing account to a dedicated employee with a federated account.

&#x2713; **organization-manager.organizations.owner protection**: Grant the `organization-manager.organizations.owner` role to a federated account and then delete the passport account with this role from your organization. To mitigate the risks of possible federation failures, follow the steps described in [Deleting a passport account from an organization](../operations/account-deletion.md).

&#x2713; **Using a correct resource model**: When developing an access model for your infrastructure, use the following approach:

   * Group resources by purpose and store them in separate folders. To ensure the strictest isolation, place them in a separate cloud.
   * Place any critical resources in a separate folder or cloud. These include resources related to the processing of payment data, personal data, and trade secret data.
   * Put shared resources (e.g., network and security groups) into a separate shared resource folder (if you separate components into folders).

## Service accounts {#service-accounts}

&#x2713; **Using impersonation where feasible**: [Impersonation](../../iam/operations/sa/set-access-bindings.md#impersonation) allows a user to perform actions under a service account and to temporarily extend user permissions without generating static credentials for the user.

&#x2713; **Using a service account for operations from within a virtual machine**: [Link a service account to the VM](../../compute/operations/vm-connect/auth-inside-vm.md). Thus, you will no longer need to store your service account keys on the VM for authentication: your IAM token will be available via a [metadata service link](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).

&#x2713; **Using an IAM token for authentication**: If you need to use static credentials, consider using an [IAM token](../../iam/concepts/authorization/iam-token.md). Keys have an unlimited lifetime, while IAM tokens are valid for {{ iam-token-lifetime }}. If the IAM token has been [compromised](../../iam/operations/compromised-credentials.md) or you no longer plan to use it, [revoke](../../iam/operations/iam-token/revoke-iam-token.md) it.

&#x2713; **Using service accounts**: Use [service accounts](../../iam/concepts/users/service-accounts.md) to automate your work with {{ yandex-cloud }}. You can check the date and time of the last authentication on the service account information page in the management console: this information allows you to track cases of unauthorized use of service accounts.

&#x2713; **Dedicated service accounts for different tasks**: This will enable you to assign to service accounts only the roles you really need. You can revoke roles from a service account or delete it without affecting other service accounts.

&#x2713; **Key usage monitoring**: In the [management console]({{ link-console-main }}), the page with the service account information shows the last use date and time for each key. This information allows you to track down unauthorized use of keys and to delete unused keys without the risk of disrupting {{ yandex-cloud }} services.

&#x2713; **Storing service account keys in secrets**: If using static keys, [store them in {{ lockbox-name }} secrets](../../lockbox/tutorials/static-key-in-lockbox.md).

&#x2713; **Periodic rotation of service account keys**: Keys with no expiration date ([authorized keys](../../iam/concepts/authorization/key.md) and [static keys](../../iam/concepts/authorization/access-key.md)) require [manual rotation](../../iam/operations/compromised-credentials.md#key-reissue). You can check out the date when a key was created in its properties. Perform key rotation at least once in 90 days.

## Secrets {#secrets}

&#x2713; **Scanning for {{ yandex-cloud }} secrets in public sources**: {{ yandex-cloud }} can scan open sources for multiple types of secrets: API keys, {{ iam-short-name }} cookies, {{ iam-short-name }} tokens, static access keys, OAuth tokens and {{ captcha-name }} server keys. You can learn more about scanning for various types of secrets [here](../operations/search-secrets.md).

&#x2713; **Handling compromised secrets**: If secrets were compromised, revoke them and issue new ones; check for unauthorized actions and delete unauthorized resources. Report the incident to the [support]({{ link-console-support }}) team and protect your secrets against vulnerabilities. You can learn more about action plan for handling compromised secrets [here](../../iam/operations/compromised-credentials.md).

&#x2713; **Using {{ lockbox-name }} secrets for storing access keys and tokens**: Store keys and tokens in [{{ lockbox-name }} secrets](../../lockbox/tutorials/static-key-in-lockbox.md) and use their payload when you need to apply a key or token.

&#x2713; **Using API keys with limited access**: Create [API keys with limited scope and validity period](../../iam/concepts/authorization/api-key.md#scoped-api-keys) for working with the list of required services to lower the risk of unauthorized use of the keys.
