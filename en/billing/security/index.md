---
title: Billing access management
description: "Access to Billing is provided to users with a registered account on Yandex or Yandex.Connect. Access to a billing account is provided through the Billing service. Operations that a user can perform with a billing account are determined by the role assigned to him."
---

# Access management

## Billing access {#billing}

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

  Service roles are roles that provide access to cloud Billing:
  * `billing.accounts.member` is automatically issued when a user is added to Billing. <br/>All users except billing account owners require this role to access cloud Billing. This role doesn't allow you to perform any actions with the billing account and is only used in combination with the `viewer` and `editor` role.
  * `billing.accounts.owner` is automatically issued when you create a billing account and can't be reassigned to another user. The role lets you perform any action with the billing account.

- Primitive roles

  Primitive roles are roles that provide access to the cloud billing account:
  * `viewer` is issued by the owner of the billing account and lets the user view billing account information.
  * `editor` is issued by the owner of the billing account and lets the user view and edit billing account information.
  * `admin` is issued by the owner of the billing account and lets the user view and edit billing account information, assign and revoke the roles of other user.

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
| Top up balance | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| View billing account information | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Rename billing account | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change payer contacts | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change billing details | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change bank cards | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Change payment methods | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
| Assign roles to billing accounts | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| View and edit roles | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Link clouds to billing accounts | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |

## Adding users {#set-member-role}

The billing account owner can add any Yandex.Cloud user to the **Users** list. To add a user:

1. In the [management console](https://console.cloud.yandex.com/billing), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.
1. Select the account on the **List of accounts** page.
1. Go to **Access management**.
1. Click **Add user**.
1. Enter a Yandex.Passport or Yandex.Connect username. <br/>Usernames that match the search are displayed in the list. Select the appropriate one.
1. Click **Add**.

The user with the specified username is assigned the `billing.accounts.member` role and added to the **Users** list. To grant billing account access, assign the user the desired role.

## Assigning roles {#set-role}

The owner can grant billing account access to any user who was added to the list and granted the `billing.accounts.member` role. To do this:

1. In the [management console](https://console.cloud.yandex.com/billing), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.
1. Go to **Access management**.
1. Find the user in the list.
1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure roles**.
1. Click **Assign role**.
1. Select a role from the list. The role is assigned without expiration.

## Revoking roles {#delete-role}

The billing account owner can revoke roles from users on the list at any time. To do this:

1. In the [management console](https://console.cloud.yandex.com/billing), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.
1. Go to **Access management**.
1. Find the user in the list.
1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure roles**.
1. Click ![image](../../_assets/cross.svg) next to the role you want to revoke. The role is revoked.

{% note info %}

If the `billing.accounts.member` role is revoked in Billing for a user, they won't be able to access the billing account.

{% endnote %}

