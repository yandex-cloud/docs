# Adding a customer

To add and pin a customer, you should switch to paid consumption mode.

{% note info %}

If you haven't spent the initial grant yet, it remains after switching to the paid version. Your personal account in {{ yandex-cloud }} won't be debited after you switch to paid consumption mode until you spend the entire amount of the initial grant.

{% endnote %}

## Creating a customer record {#create}

To add a new customer, create their record in the partner portal.

{% list tabs %}

- Partner portal

   To create a customer record:

   1. Log on to the [partner portal](https://partners.cloud.yandex.ru/) with the Yandex ID the partner account in {{ yandex-cloud }} is linked to. If you don't have access to it, this means that the account you use to log in has no partner status assigned.
   1. On the **Customers** tab, click **Add customer**.
   1. Complete the **New customers** form with your customer's information.
   1. Click **Add**. This adds a new customer record to the list of customers in the partner portal.

   Once created, a client record is given the `SUBACCOUNT-ACCEPTANCE-REQUIRED` status.

{% endlist %}

## Confirming partnership {#apply}

A customer that has the `SUBACCOUNT-ACCEPTANCE-REQUIRED` status must confirm his or her willingness to work with the partner. This happens in several stages:

1. An email with the subject <q>Confirm your willingness to work with the integrator in {{ yandex-cloud }}</q> is automatically sent to the customer's `@yandex.ru` email address that the {{ yandex-cloud }} account is registered to.

1. Once the customer confirms their willingness to work with the partner via this email, the customer's status in the partner portal changes to `Active`.

{% note warning %}

The email is only sent once.

If the customer does not follow the link provided in the email or cannot find the email, the partner can, on their own, create a partnership confirmation link and send it to the customer. To do this, use the `https://partners.cloud.yandex.ru/invite/accept/subaccount_ID` link, where `subaccount_ID` is the partner ID in the `dn...` format.
By clicking this link under their account, the customer confirms the partnership.

{% endnote %}

Creating a client record also creates a subaccount with no clouds or folders on the partner portal.

A customer can view his or her partner subaccount in the [Billing]({{ link-console-billing }}) section of the management console and either create a new cloud on their own or add an existing one.

## Adding an existing cloud {#bing}

If the customer has previously used any {{ yandex-cloud }} resources and has an existing cloud, link this cloud to the partner subaccount.

{% note alert %}

If you don't link the customer's cloud, the customer will pay for this cloud separately in {{ yandex-cloud }}, and it won't be linked to the partner.

{% endnote %}

You can link the customer's cloud to the partner subaccount from the partner or customer's console.

For the partner to be able to link existing customer clouds, make sure the partner is granted access to them. Learn more about setting up access to a customer's cloud in this [section](access/grant.md).

{% list tabs %}

- Customer console

   To link a cloud on the customer's side:

   1. Open the [management console]({{ link-console-main }}) homepage.
   1. Click ![image](../../_assets/options.svg) in the partner subaccount.
   1. Select **Link cloud**.
   1. In the drop-down list, select the cloud that you want to link.

   To prevent the partner from linking a customer's cloud on their own, revoke the roles for resources from the partner. Learn more about [roles in {{ yandex-cloud }}](../../resource-manager/security/).


- Partner console

   On the partner side, a customer's cloud can be linked from the partner's management console homepage as described on the **Customer console** tab or through the customer's billing account.

   To link a cloud using the customer billing account:

   1. In the management console, go to the **Billing** tab, select and click the customer's account.
   1. In the resulting window, click **Link cloud**.
   1. Select the cloud you need from the drop-down list. The desired cloud may not be on the list if:
      * Too little time has passed since the role was assigned to the partner in the client console.
      * You need to change the role for this cloud.

{% endlist %}
