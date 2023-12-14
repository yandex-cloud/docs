# Adding a customer

To add and pin a customer, you should switch to paid consumption mode.

{% note info %}

If you have not spent the [initial grant](../../billing/concepts/bonus-account.md#start) yet, it will remain at your disposal after you switch to paid consumption mode. Your personal account in {{ yandex-cloud }} will not be debited after you switch to paid consumption mode until you spend the whole of the initial grant.

{% endnote %}

## Creating a customer record {#create}

To add a new customer, create a customer record on the partner portal.

{% list tabs %}

- Partner portal

   1. Log in to the [partner portal]({{ link-cloud-partners }}) with the Yandex ID to which your partner account in {{ yandex-cloud }} is linked. If you have no access, it means the account you use to log in has no partner status assigned.
   1. In the top-right corner, click **Add customer**.
   1. Complete the **New customers** form with your customer's information.
   1. Click **Add**. This will add a new customer record to the list of customers on the partner portal.

   Once created, the customer record gets the `Verification required` status.

{% endlist %}

## Confirming partnership {#apply}

A customer with the `Verification required` status must confirm their readiness to work with the partner. This happens in several stages:

1. An email with the subject line saying <q>Confirm that you are ready to work with the integrator in {{ yandex-cloud }}</q> is automatically sent to the customer's `@yandex.ru` email address the {{ yandex-cloud }} account is registered to.

1. As soon as the customer confirms their readiness to work with the partner by answering this email, the customer's status on the partner portal changes to `Active`.

{% note warning %}

The email is only sent once.
If the customer does not follow the link provided in the email or cannot find the email, the partner can, on their own, create a partnership confirmation link and send it to the customer. To do this, in the `https://partners.cloud.yandex.ru/invite/accept/subaccount_ID` link, replace `subaccont_ID` with the partner ID in `dn2...` format.
The partnership will be confirmed when the customer logs in to their account using this link.

{% endnote %}

When creating a customer record on the partner portal, a [subaccount](../terms.md#subaccount) and a new [organization](../../organization/) named `For subaccount 'Customer_name'` are created. The following roles are granted by default:

* To the partner: `billing.accounts.owner` for the subaccount and `{{ roles-organization-owner }}` for the organization.
* To the customer: `{{ roles-admin }}` for the subaccount and `{{ roles-organization-owner }}` for the organization.

A customer can view their partner subaccount in the [**Billing**]({{ link-console-billing }}) section of the management console and either [create a new cloud](../../resource-manager/operations/cloud/create.md) or [add an existing one](#bing).

## Adding an existing cloud {#bing}

If the customer has previously used any {{ yandex-cloud }} resources and has an existing [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), link this cloud to the partner subaccount.

{% note alert %}

If you do not link the customer's cloud, the customer will pay for this cloud separately in {{ yandex-cloud }}, and it will not be related to the partner.

{% endnote %}

You can link a customer's cloud to a partner subaccount on the partner portal or using the management console. For the partner to be able to link existing customer clouds, make sure the partner is [granted access to them](access/grant.md).

{% list tabs %}

- Management console

   To link a cloud on the customer side:

   1. In the [management console]({{ link-console-main }}), click ![image](../../_assets/console-icons/dots-9.svg) **All services**.
   1. Select ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
   1. Select an account from the list.
   1. Go to the **Account data** page.
   1. Under **Clouds**, click **Link cloud**.
   1. Select the cloud from the list.
   1. Click **Link** and the added cloud will appear on the list.
   1. If you transferred a cloud, pay any outstanding charges on the old account.

   To prevent the partner from linking a customer's cloud on their own, revoke the roles for resources from the partner. Learn more about [roles in {{ yandex-cloud }}](../../resource-manager/security/).

- Partner portal

   On the partner side, a customer's cloud can be linked on the partner's management console home page as described in the **Management console** tab or through the customer's billing account.

   To link a cloud using the customer billing account:

   1. Log in to the [partner portal]({{ link-cloud-partners }}) with the Yandex ID to which your partner account in {{ yandex-cloud }} is linked.
   1. In the left-hand panel, select ![icon](../../_assets/console-icons/layout-header-side-content.svg) **Dashboard**.
   1. Select the customer's account from the list and click it.
   1. In the window that opens, click **Create cloud**. You will be redirected to the customer's billing account page in {{ billing-name }}.
   1. Under **Clouds**, click **Link cloud**.
   1. Select the cloud from the list. The cloud you need may not be on the list if:

      * Too little time has passed since the role was assigned to the partner in the customer console.
      * You need to change the role for this cloud.

   1. Click **Link** and the added cloud will appear on the list.

{% endlist %}
