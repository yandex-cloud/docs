# Questions about working with non-residents of Russia and Kazakhstan


#### Can I become a {{ yandex-cloud }} customer if I am a non-resident of Russia and Kazakhstan? {#non-resident}

Yes, but only if your legal status is a business.

#### Will you provide an agreement for the provision and payment of services? {#contract}

{% include [contract-qa](../../billing/_includes/contract-qa.md) %}

#### What payment methods can I use? {#payment-types}

Businesses that are non-residents of Russia and Kazakhstan can top up their accounts and pay for resources using a [wire transfer](../../billing/payment/payment-methods-business.md).

#### In what currency can non-residents of Russia and Kazakhstan pay for {{ yandex-cloud }} services? {#currency}

Non-residents of Russia and Kazakhstan can pay for {{ yandex-cloud }} services only in US dollars ($), whatever their country of residence.

#### What documents do I get after I pay for the services? {#documents}

{{ yandex-cloud }} issues a [payment invoice](../../billing/concepts/bill.md) for non-resident businesses of Russia and Kazakhstan. A copy of the payment invoice will be sent to the email address of the billing account owner at the beginning of the next reporting period.


#### What is the procedure for taxes when paying for services? {#taxes}

Taxes and fees of the country of registration of a non-resident legal entity of Russia and Kazakhstan are not added to cost of services on the [usage details](../../billing/operations/check-charges.md) page or payment invoice total.

Non-residents of Russia and Kazakhstan must pay all the taxes and fees themselves under the laws of their country of residence.

#### Why was my billing account created with the PAYMENT_NOT_CONFIRMED status? {#pending-status}

To activate a billing account, non-residents of Russia and Kazakhstan need to have it approved by {{ yandex-cloud }} representatives. 

Clicking **{{ ui-key.yacloud.common.create }}** on the **{{ ui-key.yacloud_billing.billing.account.create-new.label_title }}** page will create a billing account with the `PAYMENT_NOT_CONFIRMED` status. Further instructions will be emailed to you at the address specified in your Yandex or Yandex 360 account. It may take up to three business days to activate your account.

#### I received no email with instructions on what to do after creating a billing account. Why? {#account-notification}

For your billing account to be activated, you must have your documents and data checked. With that done, your billing account can be activated and you can start using {{ yandex-cloud }}.
If you still get no email, inquire at [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}).

In the request, specify the full organization name and the [billing account ID](../../billing/concepts/billing-account.md#billing-account-id), and attach a copy of the certificate of incorporation (translated into English or Russian).