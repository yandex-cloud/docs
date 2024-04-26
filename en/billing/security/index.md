---
title: "Access management in Billing"
description: "Billing account access is provided through the {{ billing-name }} service. The operations a user can perform on a billing account are determined by the role assigned to them."
---

# Access management in {{ billing-name }}

## Billing account access {#billing-account}

[Billing account](../concepts/billing-account.md) access is provided through the {{ billing-name }} service. A billing account can be created by users with a registered Yandex or Yandex 360 account:

* If you have not created an account for yourself or an employee yet, create one in [Yandex](https://passport.yandex.ru/registration) or [Yandex 360](https://yandex.com/support/business/add-users.html).
* If you use a social network profile to log in to Yandex, [create a username and password](https://passport.yandex.ru/passport?mode=postregistration&create_login=1).

The operations a user can perform on a billing account are determined by the role assigned to them. Roles can be assigned to a Yandex account, a [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), a [user group](../../organization/operations/manage-groups.md), or a [system group](../../iam/concepts/access-control/system-group.md).

{% note info %}

Access can only be granted to a user whose billing account has a cloud linked in [{{ iam-name }}](../../iam/).

{% endnote %}

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### billing.accounts.owner {#billing-accounts-owner}

{% include [billing.accounts.owner](../../_roles/billing/accounts/owner.md) %}

#### billing.accounts.viewer {#billing-accounts-viewer}

{% include [billing.accounts.viewer](../../_roles/billing/accounts/viewer.md) %}

#### billing.accounts.accountant {#billing-accounts-accountant}

{% include [billing.accounts.accountant](../../_roles/billing/accounts/accountant.md) %}

#### billing.accounts.editor {#billing-accounts-editor}

{% include [billing.accounts.editor](../../_roles/billing/accounts/editor.md) %}

#### billing.accounts.admin {#billing-accounts-admin}

{% include [billing.accounts.admin](../../_roles/billing/accounts/admin.md) %}

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

{% include [billing.accounts.varwithoutdiscounts](../../_roles/billing/accounts/varWithoutDiscounts.md) %}

#### billing.partners.editor {#billing-partners-editor}

{% include [billing.partners.editor](../../_roles/billing/partners/editor.md) %}

### Primitive roles {#primitive-roles}

Primitive roles are aggregator roles that define user permissions to access services. In {{ billing-name }}, these roles match the following `billing.accounts.*` roles:

* `auditor`: Same as `billing.accounts.viewer` with some limitations.
* `viewer`: Same as `billing.accounts.viewer`.
* `editor`: Same as `billing.accounts.editor`.
* `admin`: Same as `billing.accounts.admin`.

Primitive roles can only be assigned to users in the **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}** list.

### Available operations {#available-operations}

The table below provides a list of operations available to each role type.

| Operations | `owner` | `viewer` | `accountant` | `editor` | `admin` |
|---------------------------------------------------------|---------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|
| Displaying a billing account in the list of all user accounts | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing billing account information | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing and receiving usage notifications | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing and downloading reporting (closing) documents | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing and downloading generated reconciliation reports | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Checking expenses | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Accessing usage details | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Topping up your personal account using a bank account | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Generating a new reconciliation report | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Activating promo codes | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Linking clouds to billing accounts | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Creating details export | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Creating budget | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Resource allocation | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Assigning roles to billing accounts | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing and editing roles | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Renaming a billing account | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Changing payer contact information | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Changing billing details | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Changing bank cards | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Changing payment methods | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Activating trial period | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Activating paid version | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Topping up your personal account using a bank card | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |

## Adding a user {#set-member-role}

The steps for adding a new billing account user depend on whether this billing account is added to your organization.

{% list tabs %}

- For accounts added to an organization

   [Assign](#set-role) the required role for the billing account to a user or service account in your organization.

- For accounts not added to an organization

   {% note info %}

   To add a new billing account user, you need to have the `billing.accounts.owner` or `billing.accounts.admin` role.

   {% endnote %}

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_users }}** page.
   1. At the top right, click **{{ ui-key.yacloud_billing.billing.account.users.button_add }}**.
   1. Select a user from the drop-down list. The list shows users whose clouds are linked to your billing account.
   1. Click **{{ ui-key.yacloud_billing.billing.account.user-dialog.button_submit }}**.

   The user or service account is assigned the `billing.accounts.member` role and added to the **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}** list. To grant billing account access, assign them the required role.

{% endlist %}

## Assigning roles {#set-role}

The steps for assigning a billing account role depend on whether this billing account is added to your organization.

{% list tabs %}

- For accounts added to an organization

   Users with the `billing.accounts.admin` role can grant access to the billing account to any user or service account within the same organization. To do this:

   1. [Make sure](../../organization/operations/users-get.md) that the user you need belongs to your organization. If not, [add them](../../organization/operations/add-account.md).
   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_users }}** page.
   1. At the top right, click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**. In the window that opens:

      1. Click ![image](../../_assets/create.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
      1. Select a user or service account from the list or use the search bar.
      1. Click ![image](../../_assets/create.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the required role.
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

   {% note info %}

   If you assign the {{ billing-name }} service role to an organization, all billing accounts within this organization will also assume this role.

   {% endnote %}

- For accounts not added to an organization

   Users with the `billing.accounts.admin` role can grant access to the billing account to any user or service account on the **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}** list. To do this:

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_users }}** page.
   1. Find the user or service account in the list.
   1. In the line with the user or service account you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_billing.billing.account.users.button_tune-role }}**.
   1. Click ![image](../../_assets/create.svg) **{{ ui-key.yacloud_billing.billing.account.users.popup-tune-role_add-button }}**.
   1. Select a role from the list.

{% endlist %}

The role will be assigned without expiration.

## Revoking roles {#delete-role}

The steps for revoking a billing account role depend on whether this billing account is added to your organization.

{% list tabs %}

- For accounts added to an organization

   A user with the `billing.accounts.admin` role can revoke a billing account role from users or service accounts in their organization at any time. To do this:

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_users }}** page.
   1. Select a user or service account from the list or use filtering by users.
   1. In the line with the user or service account you need, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
   1. Click ![image](../../_assets/cross.svg) next to the role to be invoked.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**. The role will be revoked.

- For accounts not added to an organization

   A user with the `billing.accounts.admin` role can revoke a billing account role from users or service accounts on the list at any time. To do this:

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_users }}** page.
   1. Find the user or service account in the list.
   1. In the line with the user or service account you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_billing.billing.account.users.button_tune-role }}**.
   1. Click ![image](../../_assets/console-icons/xmark.svg) next to the role to be invoked. The role will be revoked.

   {% note info %}

   If the `billing.accounts.member` role is revoked from a user, they will not be able to access the billing account.

   {% endnote %}

{% endlist %}

## Deleting users {#delete-user}

You can only delete users from those billing accounts that are not added to an organization. To do this:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
1. Select a billing account.
1. Find the user or service account in the list.
1. In the line with the user or service account you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_billing.billing.account.users.button_remove-user }}**.
1. This deletes the user from the list of the billing account users.

If the billing account is added to an organization, you can simply [revoke](#delete-role) the required role from a user or service account. You can [remove a user from the organization](../../organization/edit-account) to prevent them from accessing any of its clouds or resources.
