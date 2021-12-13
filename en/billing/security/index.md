---
title: Billing access management
description: "Access to Billing is provided to users with a registered account on Yandex or Yandex.Connect. Access to a billing account is provided through the Billing service. Operations that a user can perform with a billing account are determined by the role assigned to him."
---
# Access management

## Access to Billing {#billing}

{% include [yandex-account](../_includes/yandex-account.md) %}

## Billing account access {#billing-account}

[Billing account](../concepts/billing-account.md) access is provided through the Billing service. The operations that a user can perform on a billing account are determined by the role assigned to them.

{% note info %}

Access can only be granted to users who were added to a cloud in [{{ iam-name }}](../../iam/).

{% endnote %}

## Billing account roles {#role-list}

Billing has the following roles:

{% list tabs %}

- Service roles

  Service roles are roles that provide access to cloud Billing:
  * `billing.accounts.member` is granted automatically when you add a user to Billing. <br/>All users except billing account owners require this role to access cloud Billing. This role doesn't allow you to perform any actions with the billing account and is only used in combination with the `viewer` and `editor` role.
  * `billing.accounts.owner` is automatically granted when you create a billing account and can't be reassigned to another user. The role lets you perform any action with the billing account.

- Primitive roles

  Primitive roles are roles that provide access to a cloud billing account:
  * `viewer` is granted by a billing account owner and lets a user view some billing account information.
  * `editor` is granted by a billing account owner and lets a user view and edit some billing account information.
  * `admin` is granted by a billing account owner and lets a user view and edit some billing account information as well as assign and revoke additional user privileges.

  Primitive roles can only be assigned to users in the **Users** list.

{% endlist %}

A list of operations available to each role is given in the table below.

| Operations | `member` | `owner` | `viewer` | `editor` | `admin` |
| ----- | ----- | ----- | ----- | ----- | ----- |
| Activate the trial period | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Activate the paid version | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Check expenses | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Access usage details | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Activate promo codes | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Top up your personal account using a bank card | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Top up your personal account using a bank account | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| View billing account information | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Rename a billing account | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change payer contact information | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change billing details | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change bank cards | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change payment methods | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Assign roles to billing accounts | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| View and edit roles | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Link clouds to billing accounts | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Create budget | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| View and receive usage notifications | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |

## Adding a user {#set-member-role}

The owner of a billing account can expand the **Users** list to include any {{ yandex-cloud }} user with the `billing.accounts.member` role to the cloud that is linked to the billing account. To add a user:

1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) in the upper left-hand corner of the page, and go to **Billing**.
1. Select an account on the **List of accounts** page.
1. Go to **Access control**.
1. Click **Add user**.
1. Enter your Yandex ID or Yandex.Connect login. The drop-down list will display the users who meet the search conditions. Select the one you need.
1. Click **Add**.

The user with the specified username is assigned the `billing.accounts.member` role and added to the **Users** list. To grant billing account access, assign the user the desired role.

## Assigning roles {#set-role}

The owner can grant access to the billing account to any user on the **Users** list. To do this:

1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) in the upper left-hand corner of the page, and go to **Billing**.
1. Go to **Access control**.
1. Find the user in the list.
1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure roles**.
1. Click **Assign role**.
1. Select a role from the list. The role is assigned without expiration.

## Revoking a role {#delete-role}

The billing account owner can revoke roles from users on the list at any time. To do this:

1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) in the upper left-hand corner of the page, and go to **Billing**.
1. Go to **Access control**.
1. Find the user in the list.
1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure roles**.
1. Click ![image](../../_assets/cross.svg). The role is revoked.

{% note info %}

If the `billing.accounts.member` role is revoked in Billing for a user, they won't be able to access the billing account.

{% endnote %}

