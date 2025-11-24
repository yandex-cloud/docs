---
title: Adding a customer
description: Follow this guide to add a customer.
---

# Adding a customer

To add a new customer:

1. [Create a customer subaccount on the partner portal](#client-entry).
1. [Wait until the customer confirms partnership](#confirm-partnership).
1. [Create a new cloud for your customer](#create-cloud).

## Creating a customer subaccount {#client-entry}

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Log in to the [partner portal]({{ link-cloud-partners }}) with the Yandex ID linked to your partner account in {{ yandex-cloud }}. If you have no access, it means the account you are using to log in has no partner status assigned.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/credit-card.svg) **Subaccounts**.
  1. In the top-right corner, click ![image](../../_assets/console-icons/plus.svg) **Create subaccount**.
  1. In the subaccount creation form, select an existing account in the search bar or click ![image](../../_assets/console-icons/plus.svg) to [create](../operations/create-account.md) a new one.
  1. Fill out the remaining fields with your customer information.
  1. Click **Create**. A new customer record with the `Acceptance required` status will appear on the **Subaccounts** page.

{% endlist %}

Once you confirm the partnership, a new [organization](../../organization/) named `For 'Customer_name' subaccount` will be created.

In this case, users are assigned different roles for accessing the created subaccount and organization by default.

* Users and service accounts with the `billing.accounts.owner` [role](../security/index.md#billing-accounts-owner):
   * The `billing.accounts.owner` [role](../security/index.md#billing-accounts-owner) for the subaccount.
   * The `organization-manager.organizations.owner` [role](../../iam/roles-reference.md#organization-manager-organizations-owner) for the organization.

* Users and service accounts that created a subaccount for a customer:
   * The `billing.accounts.admin` [role](../security/index.md#billing-accounts-admin) for the subaccount.
   * The `admin` [role](../../iam/roles-reference.md#admin) for the organization.

* Users whose email addresses were specified when creating a subaccount:
   * The `billing.accounts.admin` [role](../security/index.md#billing-accounts-admin) for the subaccount.
   * The `admin` [role](../../iam/roles-reference.md#admin) for the organization.

{% note info %}

Only users with a Yandex account receive roles at the organization level, this does not apply to federated users.

{% endnote %}

## Confirming partnership {#confirm-partnership}

A customer with the `Verification required` status must confirm their readiness to work with the partner. This is a multiple-step process:

1. An email with the subject line saying _Confirm that you are ready to work with the integrator in {{ yandex-cloud }}_ is automatically sent to the customer's `@yandex.ru` email address that refers to their {{ yandex-cloud }} account.

1. As soon as the customer confirms their readiness to work with the partner by replying to this email, the customer's status on the partner portal changes to `Active`.

{% note warning %}

If the customer fails to follow the link provided in the email or cannot find the email, you can:

* Resend the partnership confirmation email to the customer.
* Copy the link on the subaccount page and send it to the customer. The partnership will be confirmed when the customer logs in to their account using this link.

{% endnote %}

## Creating a cloud for a customer {#create-cloud}

The [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) will contain resources used by the customer.

{% list tabs group=instructions %}


- Partner portal {#partner}

  1. Log in to the [partner portal]({{ link-cloud-partners }}) with the Yandex ID linked to your partner account in {{ yandex-cloud }}.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/layout-header-side-content.svg) **Dashboard**.
  1. Select the customer's account from the list and click it.
  1. Under **Clouds**, click ![icon](../../_assets/console-icons/plus.svg) **Create cloud**.
  1. Enter a name for the cloud.
  1. In the **Organization** field, select the [organization](../../organization/quickstart.md) named `For 'Customer_name' subaccount`.
  1. Click **Create**.

{% endlist %}
