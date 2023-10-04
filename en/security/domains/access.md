# Authentication and access control

In {{ yandex-cloud }}, identification, authentication, and access control is performed by [{{ iam-full-name }} ({{ iam-short-name }})](../../iam/) and [{{ org-full-name }}](../../organization/).

The platform works with three categories of users:

* [Yandex accounts](../../iam/concepts/#passport): Accounts in Yandex ID.
* [Federated accounts](../../iam/concepts/#saml-federation): Accounts in a corporate [SAML-compatible identity federation](../../organization/concepts/add-federation.md), such as Active Directory.
* [Service accounts](../../iam/concepts/#sa): Accounts that can be used by a program to manage resources.

Yandex accounts and federated accounts are authenticated in their own systems. {{ yandex-cloud }} has no access to these users' passwords and only authenticates service accounts via {{ iam-short-name }}.

[User access to cloud resources](../../iam/concepts/access-control/) is regulated by [roles](../../iam/concepts/access-control/roles.md). {{ yandex-cloud }} services may provide different levels of granularity while granting permissions: in some cases, a role can be assigned directly to a service resource, in other cases, permissions are only granted at the level of the folder or cloud where the service resource is located.

This ensures interaction of different categories of resources, roles, and users in the {{ yandex-cloud }} infrastructure. Access to resources is managed by {{ iam-short-name }}. {{ iam-short-name }} controls each request and makes sure that all operations with resources are only run by users who have the appropriate permissions.

This section provides recommendations on how to ensure [safe operations](../../iam/best-practices/using-iam-securely.md) with {{ yandex-cloud }} services:

* [Centralized management and identity federations](#saml-federation).
* [Minimum privileges and security policy](#min-privileges).
* [Using service accounts](#sa).
* [Two-factor authentication](#twofa).
* [Managing privileged users](#privileged-users).
* [Providing {{ yandex-cloud }} access to contractors](#contractors).
* [Differentiating access to resources](#resourses).

To simplify and automate role-based access management, the {{ iam-short-name }} module (based on {{ TF }}) was designed. It lets you create permission groups for cloud users and has a number of other convenient features. For more information about the {{ iam-short-name }} module and its use cases, see the [solution](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auth_and_access/iam#identity-and-access-management-iam-terraform-module-for-yandexcloud).

## Centralized management and identity federations {#saml-federation}

[{{ org-full-name }}](../../organization/) is a single service for managing the organizational structure, setting up integration with the employee catalog, and differentiating user access to the organization's cloud resources.

For the purpose of centralized account management, use [SAML-compatible identity federations](../../organization/concepts/add-federation.md). By using identity federations, a company can set up Single Sign-On, which is authentication in {{ yandex-cloud }} via their IdP server. With this approach, employees can use their corporate accounts that are subject to the company's security policies, such as:

* Revoking and blocking accounts.
* Password policies.
* Limiting the number of unsuccessful login attempts.
* Blocking access sessions upon expiry of a preset user's idle time.
* Two-factor authentication.

[Instructions for setting up SAML-based identity federations](../../organization/concepts/add-federation#federation-usage).
[Instructions for setting up SAML-based federations with KeyCloak](https://www.youtube.com/watch?v=m-oe7V9PvC4).

{% note tip %}

Use federated accounts instead of Yandex ID accounts whenever possible.

{% endnote %}

## Minimum privileges and security policy {#min-privileges}

The [principle of minimum privileges](../../iam/best-practices/using-iam-securely.md#restrict-access) requires assigning users the minimum required roles.

We don't recommend using primitive roles like `admin`, `editor`, `member`, and `viewer` that are valid in all services. To ensure more selective access control and implementation of the principle of minimum privileges, use service roles that only contain permissions for a certain type of resources in the specified service.

{% note info %}

When a new user is added to the cloud, they're automatically assigned the [cloud member role](../../iam/concepts/access-control/roles.md#member): `resource-manager.clouds.member`. This role is necessary for working with the cloud and does not give any privileges.

{% endnote %}

## Using service accounts {#sa}

A [service account](../../iam/concepts/users/service-accounts.md) is an account that can be used by a program to manage resources in {{ yandex-cloud }}.
A service account is used to make requests as an application. Do not use employee accounts instead of service accounts. If, for example, an employee quits or moves to a different department, their account permissions are disabled, which may lead to an application failure.

When using service accounts:
* [Assign a service account](../../compute/operations/vm-connect/auth-inside-vm.md) to a VM instance and get a token using the metadata service.
* Set up a local firewall on the VM instance so that only the necessary processes and system users have access to the metadata service (IP address: `169.254.169.254`).

   Example of blocking access for all users except the specified one (in this case, `root`):

   ```
   sudo iptables --append OUTPUT --proto tcp \
   --destination 169.254.169.254 --match owner ! --uid-owner root \
   --jump REJECT
   ```

* Store the service account keys and manage them in compliance with the standard requirements.
* Follow the principle of minimum privileges and [assign to the service account](../../iam/operations/roles/grant.md#access-to-sa) only those roles that are needed to run the application.

   {% note info %}

   You can grant permissions to [use a service account](../../iam/concepts/access-control/roles.md#sa-user) under another user or service account.

   {% endnote %}

* Follow the principle of minimum privileges for the service account as a resource: assign the [roles for using and managing your service accounts](../../iam/operations/sa/set-access-bindings.md) to a minimum number of users who truly require such roles.

## Two-factor authentication {#twofa}

Security standards require two-factor authentication (2FA) for accessing the infrastructure. Therefore, access to the {{ yandex-cloud }} management console is based on 2FA.

To enable two-factor authentication, contact an identity provider that supports 2FA and set up a [SAML-compliant identity federation](#saml-federation).

To set up 2FA for a Yandex ID account, follow the [instructions](https://yandex.com/support/id/authorization/twofa.html).

## Managing privileged users {#privileged-users}

{{ yandex-cloud }} privileged users include accounts with the following roles:
* `billing.accounts.owner`.
* `{{ roles-admin }}` assigned for a billing account.
* `{{ roles-cloud-owner }}`.
* `{{ roles-admin }}` assigned for a cloud.
* `{{ roles-admin }}` assigned for a folder.

The `billing.accounts.owner` role is granted automatically when creating a billing account and cannot be reassigned to another user. The role allows you to perform any action with the billing account. The `billing.accounts.owner` role can only be assigned to a Yandex ID account. An account with the `billing.accounts.owner` role is used when setting up payment methods and adding clouds.

Make sure to properly secure this account, since it has significant privileges and can't be federated with a corporate account.

The most appropriate approach would be to not use this account on a regular basis:
* Only use it for initial setup and updates.
* For the duration that this account is actively used, be sure to enable two-factor authentication (2FA) in Yandex ID.
* After that, if you don't use the bank card payment method (only available for this role), set a strong password for this account (generated using specialized software), disable 2FA, and refrain from using this account unnecessarily.
* Change the password to a newly generated one each time you use the account.

We recommend disabling 2FA only for this account and if it is not assigned to a specific employee. This lets you avoid linking this critical account to a personal device.

To manage a billing account, assign the `{{ roles-admin }}` or `{{ roles-editor }}` role for the billing account to a dedicated employee with a federated account. To view {{ billing-name }} data, assign the `{{ roles-viewer }}` role for the billing account to a dedicated employee with a federated account.

The `{{ roles-cloud-owner }}` role is assigned automatically when you create a cloud. A user with this role can perform any operation with the cloud or its resources and grant cloud access to other users: assign roles and revoke them.

Use the `{{ roles-cloud-owner }}` role with caution:
* Assign it to one or more federated users in your organization.
* Set a strong password for your Yandex ID account that you used to create the cloud. Use the Yandex ID account only when absolutely necessary, for example, if no federation is available.

Be sure to fully protect your federated account with the `{{ roles-cloud-owner }}` role:
* Enable two-factor authentication.
* Disable authentication from devices beyond the company's control.
* Configure login attempt monitoring and set alert thresholds.

To view the list of IDs of the current accounts with the `{{ roles-cloud-owner }}` role, run the following script:

```
yc resource-manager cloud list-access-bindings \
 --id <cloud_ID> \
 --format json | jq -r '.[] | select(.role_id=="resource-manager.clouds.owner") | .subject.id'
```

Assign federated accounts the `{{ roles-admin }}` roles for clouds, folders, and billing accounts. Minimize the number of accounts with these roles and regularly review the expedience of these roles for the accounts they are assigned to.

### Specifics of authentication in managed database services {#mdb-auth}

To use a database at the application level, in addition to {{ iam-short-name }} service roles, a separate user is created: the database owner. The following password policy applies to this user:
* The password must include numbers, uppercase letters, lowercase letters, and special characters.
* It must be at least 8 characters long.

## Providing {{ yandex-cloud }} access to contractors {#contractors}

If you grant third-party contractors access to your clouds, make sure to follow these security measures:
* Assign permissions to contractor employees based on the principle of minimum privileges.
* If possible, create a separate account for third-party employees in your corporate IdP and assign the necessary policies to this account.
* Make sure they handle their account secrets carefully.
* Review the expedience of granting external users access to your cloud infrastructure.

## Resource model {#resourses}

When developing an access model for your infrastructure, we recommend the following approach:
* Place any critical resources in a separate cloud. These include resources related to the processing of payment data, personal data, and trade secret data.
* Host the resource groups that require different administrative permissions in different folders (DMZ, CDE, security, backoffice, and so on).
* Host shared resources (such as network and security groups) in a separate shared resource folder.
