### Only trusted administrators have privileged roles {#check-privileged-roles}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.check-privileged-roles ||
|#

#### Description

{% note warning "**Manual verification**" %}

This rule automatically finds accounts with any of these roles assigned:

* `billing.accounts.owner`
* `admin` assigned for a billing account
* `organization-manager.organizations.owner`
* `organization-manager.admin`
* `resource-manager.clouds.owner`
* `admin` and `editor` assigned for an organization
* `admin` and `editor` assigned for a cloud
* `admin` and `editor` assigned for a folder
* `resource-manager.clouds.editor`

This rule requires an additional manual check. Upon completion, please change the rule's status.

{% endnote %}

When creating your billing account, you get the `billing.accounts.owner` role automatically. Any user with the `billing.accounts.owner` role can remove this role from the billing account creator and change the owner. The role allows you to perform any action with the billing account.

The `billing.accounts.owner` role can only be assigned to a Yandex ID account. An account with the `billing.accounts.owner` role is used when setting up payment methods and adding clouds.

Make sure to properly secure this account: it offers significant privileges and cannot be federated with a corporate account.

The most appropriate approach would be to not use this account on a regular basis:

* Only use it for initial setup and updates.
* When actively using this account, enable two-factor authentication (2FA) in Yandex ID.
* After that, if you do not use the bank card payment method (only available for this role), set a strong password for this account (generated using specialized software), disable 2FA, and refrain from using this account unnecessarily.
* Change the password to a newly generated one each time you use the account.

We recommend disabling 2FA only for this account and if it is not assigned to a specific employee. Thus you can avoid linking this critical account to a personal device.

To manage a billing account, assign the `admin` or `editor` role for the billing account to a dedicated employee with a federated account.

To view billing data, assign the `viewer` role for the billing account to a dedicated employee with a federated account.

By default, the `organization-manager.organizations.owner` role is granted to the user who creates an organization: the organization owner. The role allows you to appoint organization owners and use all the administrator privileges.

The `resource-manager.clouds.owner` role is assigned automatically when you create your first cloud in the organization. A user with this role can perform any operation with the cloud or its resources and grant cloud access to other users: assign roles and revoke them.

Assign the `resource-manager.clouds.owner` and `organization-manager.organizations.owner` roles to one or more employees with a federated account. Set a strong password for the Yandex ID account that was used to create the cloud, and use it only when absolutely necessary (for example, if the federated access fails).

Make sure to fully protect your federated account that is granted one of the privileged roles listed above:

* Enable two-factor authentication.
* Disable authentication from devices beyond the company's control.
* Configure login attempt monitoring and set alert thresholds.

Assign federated accounts the `admin` roles for clouds, folders, and billing accounts. Minimize the number of accounts with these roles and regularly review the expedience of these roles for the accounts they are assigned to.

#### Guides and solutions to use

**Guides and solutions to use:**

Check access rights for the Yandex Cloud Billing service:

1. Go to [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts).
2. In the left-hand panel, select **Access management**.
3. Check which users have the `billing.accounts.owner` and `admin` roles.

Check access rights for an organization:

1. Go to [Yandex Identity Hub](https://center.yandex.cloud/organization)
2. In the left-hand panel, select **Access bindings**.
3. Check which users have the `admin`, `organization-manager.organizations.owner`, `organization-manager.admin`, and `resource-manager.clouds.owner` roles.

Check access rights for a cloud or a folder:

1. In the [management console](https://console.yandex.cloud), select the cloud or folder to check access permissions in.
2. Click the **Access permissions** tab.
3. Check which users have the `admin`, `editor`, `resource-manager.clouds.owner`, and `resource-manager.clouds.editor` roles.

Make sure all the privileged roles are granted to trusted administrators. If any roles granted to untrusted administrators are found, investigate why and remove the respective permissions.
