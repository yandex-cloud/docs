---
title: Adding a customer
description: Follow this guide to add a customer.
---

# Adding a customer

To add a new customer:

1. [Create a customer record on the partner portal](#client-entry).
1. [Wait until the customer confirms partnership](#confirm-partnership).
1. [Create a new cloud for your customer](#create-cloud).

## Creating a customer record {#client-entry}

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Log in to the [partner portal]({{ link-cloud-partners }}) with the Yandex ID linked to your partner account in {{ yandex-cloud }}. If you have no access, it means the account you use to log in has no partner status assigned.
  1. In the top-right corner, click **Add customer**.
  1. Complete the **New customers** form with your customer's information.
  1. Click **Add**. A new customer record with the `Verification required` status will appear on the partner portal.

     {% note info %}

     You can edit all subaccount fields except the **Name** field: only the contact person specified in the account fields can edit it. Updates do not affect the roles assigned for the subaccount and organization.

     {% endnote %}

{% endlist %}

When creating a customer record on the partner portal, a [subaccount](../terms.md#sub-account) and a new [organization](../../organization/) named `For subaccount 'Customer_name'` are created. You can delete the subaccount if the customer has not [confirmed](#apply) it on time.

The following roles are granted by default:

* To the partner: `billing.accounts.owner` for the subaccount and `{{ roles-organization-owner }}` for the organization.
* To the customer: `{{ roles-admin }}` for the subaccount and `{{ roles-organization-owner }}` for the organization.

## Confirming partnership {#confirm-partnership}

A customer with the `Verification required` status must confirm their readiness to work with the partner. This happens in several stages:

1. An email with the subject line saying <q>Confirm that you are ready to work with the integrator in {{ yandex-cloud }}</q> is automatically sent to the customer's `@yandex.ru` email address their {{ yandex-cloud }} account is registered to.

1. As soon as the customer confirms their readiness to work with the partner by answering this email, the customer's status on the partner portal changes to `Active`.

{% note warning %}

If the customer fails to follow the link provided in the email or cannot find the email, you can:

* Resend to the customer the partnership confirmation link email.
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
  1. In the **Organization** field, select the [organization](../../organization/quickstart.md) named `For subaccount 'Customer_name'`.
  1. Click **Create**.

{% endlist %}
