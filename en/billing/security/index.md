---
title: Access management in {{ billing-name }}
description: Billing account access is provided through {{ billing-name }}. The operations a user can perform on a billing account depend on the assigned role.
---

# Access management in {{ billing-name }}

## Billing account access {#billing-account}

[Access](../concepts/billing-account.md) to the billing account can be provided via the [{{ billing-name }} interface]({{ link-console-billing }}) or the [{{ yandex-cloud }} API](../api-ref/authentication.md). A billing account can be created by users with a registered Yandex or Yandex 360 account:

* If you or your employee have no account yet, create one on [Yandex](https://passport.yandex.ru/registration) or [Yandex 360](https://yandex.com/support/business/add-users.html).
* If using a social network profile to log in to Yandex, [create a username and password](https://passport.yandex.ru/passport?mode=postregistration&create_login=1).

The operations a user can perform on a billing account depend on the assigned role. You can assign roles to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md).

{% note info %}

Access can only be granted to a user whose billing account has a cloud linked in [{{ iam-name }}](../../iam/).

{% endnote %}

## Roles this service has {#roles-list}

### Service roles {#service-roles}

#### billing.accounts.member {#billing-accounts-member}

{% include [billing.accounts.member](../../_roles/billing/accounts/member.md) %}

#### billing.accounts.viewer {#billing-accounts-viewer}

{% include [billing.accounts.viewer](../../_roles/billing/accounts/viewer.md) %}

#### billing.accounts.accountant {#billing-accounts-accountant}

{% include [billing.accounts.accountant](../../_roles/billing/accounts/accountant.md) %}

#### billing.partners.editor {#billing-partners-editor}

{% include [billing.partners.editor](../../_roles/billing/partners/editor.md) %}

#### billing.accounts.editor {#billing-accounts-editor}

{% include [billing.accounts.editor](../../_roles/billing/accounts/editor.md) %}

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

{% include [billing.accounts.varwithoutdiscounts](../../_roles/billing/accounts/varWithoutDiscounts.md) %}

#### billing.accounts.admin {#billing-accounts-admin}

{% include [billing.accounts.admin](../../_roles/billing/accounts/admin.md) %}

#### billing.accounts.owner {#billing-accounts-owner}

{% include [billing.accounts.owner](../../_roles/billing/accounts/owner.md) %}

### Primitive roles {#primitive-roles}

Primitive roles are aggregator roles that define user permissions to access services. In {{ billing-name }}, these roles match the following `billing.accounts.*` roles:

* `auditor`: Same as `billing.accounts.viewer` (with some limitations).
* `viewer`: Same as `billing.accounts.viewer`.
* `editor`: Same as `billing.accounts.editor`.
* `admin`: Same as `billing.accounts.admin`.

Primitive roles can only be assigned to users in the **{{ ui-key.yacloud_components.notify-subs.label_users }}** list.

### Available operations {#available-operations}

The table below provides a list of operations available to each role type.

| Operations                                                | `owner`                                | `viewer`                               | `accountant`                           | `editor`                               | `admin`                                |
|---------------------------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|
| Displaying a billing account in the list of all user accounts       | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing billing account information                     | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing and receiving usage notifications          | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing and downloading reporting (closing) documents | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing and downloading generated reconciliation reports  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Checking expenses                                       | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Accessing usage details                                    | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Topping up your personal account using a bank account    | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Generating a new reconciliation report                            | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Activating promo codes                                    | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Linking a cloud organization and other entities to a billing account | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Link with a cloud organization                           | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Creating details export                           | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Creating budget                                        | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Resource allocation                                 | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Renaming a billing account                      | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Viewing commercial offers                  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Assigning roles to billing accounts                       | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | 
| Viewing and editing roles                         | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | 
| Managing technical support plan                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | 
| Changing payer contact details                         | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Changing billing details                          | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Changing bank cards                              | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Changing payment methods                                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Activating paid version                                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Topping up your personal account using a credit or debit card    | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Accepting commercial offers                      | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |

## Adding a user {#set-member-role}

The steps for adding a new billing account user depend on whether the billing account is associated with an organization.

{% list tabs group=instructions %}

- Accounts associated with an organization {#organization}

  [Assign](#set-role) the required role for the billing account to a user or service account in your organization.

- Accoounts associated with no organization {#no-organization}

  {% note info %}

  To add a new billing account user, you need the `billing.accounts.owner` or `billing.accounts.admin` role.

  {% endnote %}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_users }}** page.
  1. At the top right, click **{{ ui-key.yacloud_billing.billing.account.users.button_add }}**.
  1. Select a user from the drop-down list. The list shows users whose clouds are linked to your billing account.
  1. Click **{{ ui-key.yacloud_billing.billing.account.user-dialog.button_submit }}**.

  The user or service account will get the `billing.accounts.member` role and included in the **{{ ui-key.yacloud_components.notify-subs.label_users }}** list. To grant billing account access, assign them the required role.

{% endlist %}

## Assigning roles {#set-role}

The steps for assigning a role for a billing account depend on whether the billing account is linked to the organization.

{% list tabs group=instructions %}

- Accounts associated with an organization {#organization}

  A user with the `billing.accounts.admin` role can grant access to the billing account to any user or service account within the same organization. To do this:

  1. [Make sure](../../organization/operations/users-get.md) that the user you need belongs to your organization. If not, [add them](../../organization/operations/add-account.md).
  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_billing.billing.account.switch_users }}**.
  1. At the top right, click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**. In the window that opens, do the following:

     1. Select a user, service account, or user group. If required, use the search bar.
     1. Click ![image](../../_assets/create.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the role.
     1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

  {% note info %}

  If you assign the {{ billing-name }} service role to an organization, all billing accounts within this organization will also assume this role.

  {% endnote %}

- Accoounts associated with no organization {#no-organization}

  A user with the `billing.accounts.admin` role can grant access to the billing account to any user or service account on the **{{ ui-key.yacloud_components.notify-subs.label_users }}** list. To do this:
 
  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_billing.billing.account.switch_users }}**.
  1. Find the required user, service account, or user group in the users list or use the filter. 
  1. In the line with the required user, service account, or group, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_billing.common.resource-acl.button_assign-binding }}**. In the window that opens, do the following:
  
      1. Click ![image](../../_assets/create.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}**.
      1. Select a role from the list.
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

The role will be assigned without expiration.

## Revoking roles {#delete-role}

The steps for revoking a role for a billing account depend on whether the billing account is linked to the organization.

{% list tabs group=instructions %}

- Accounts associated with an organization {#organization}

  A user with the `billing.accounts.admin` role can revoke a billing account role from a user or service account in their organization at any time. To do this:

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_billing.billing.account.switch_users }}**.
  1. Find the required user, service account, or user group in the users list or use the filter.
  1. In the line with the required user, service account, or group, click ![image](../../_assets/horizontal-ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_billing.common.resource-acl.button_assign-binding }}**. In the window that opens, do the following:

      1. Click ![image](../../_assets/cross.svg) to the right of the role you want to revoke.
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**. The role will be revoked.

- Accoounts associated with no organization {#no-organization}

  A user with the `billing.accounts.admin` role can revoke a billing account role from a user or service account on the list at any time. To do this:

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_billing.billing.account.switch_users }}**.
  1. Find the required user, service account, or user group in the users list or use the filter. 
  1. In the line with the required user, service account, or group, click ![image](../../_assets/horizontal-ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_billing.common.resource-acl.button_assign-binding }}**. In the window that opens, do the following:

      1. Click ![image](../../_assets/cross.svg) to the right of the role you want to revoke.
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**. The role will be revoked.

  {% note info %}

  If the `billing.accounts.member` role is revoked, the user will not be able to access the billing account.

  {% endnote %}

{% endlist %}

## Deleting a billing account user {#delete-user}

You can only delete users from billing accounts not linked to the organization. To do this:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
1. Select a billing account.
1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_billing.billing.account.switch_users }}** and find the user or service account in the list that opens.

    Optionally, use the filter in the right part of the screen.
1. In the line with the user or service account, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_billing.billing.account.users.button_remove-user }}**.
1. This will delete the user from the list of the billing account users.

If the billing account is linked to the organization, simply [revoke](#delete-role) the role from the user or service account. You can also [delete a user from the organization](../../organization/operations/edit-account.md) to revoke access to all its clouds and resources.

You can also [deactivate](../../organization/operations/user-pools/deactivate-user.md) a [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) user. As a result, the user will lose access to the organization's resources until [reactivated](../../organization/operations/user-pools/activate-user.md).