To create a billing account:

1. {% include [create-ba-step2](../../billing/_includes/create-ba-step2.md) %}

   When creating an organization, specify its name, e.g., `Example organization`. The organization will automatically get a new folder named `default`.
   
1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
1. {% include [create-ba-step3](../../billing/_includes/create-ba-step3.md) %}

   {% include [create-additional-ba-ui-notice](../../billing/_includes/create-additional-ba-ui-notice.md) %}

   In the window that opens:

   1. {% include [create-ba-choose-ul-step](../../billing/_includes/create-ba-choose-ul-step.md) %}
   1. {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}

      {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. {% include [create-ba-import-egrul-step](../../billing/_includes/create-ba-import-egrul-step.md) %}
   1. Select **{{ ui-key.yacloud_billing_account.create-account.section_payment_method }}**: wire transfer or linked credit or debit card.

      The payment method you select will affect the size of the [initial grant](../../billing/concepts/bonus-account.md) and [its terms of use](../../getting-started/usage-grant.md#business).

      * Select **{{ ui-key.yacloud_billing_account.create-account.label_payment_invoice }}**. After you create an account, you will get an email with verification instructions. Until you pass the verification, paid resources will be unavailable.

      * Link a corporate bank card you are authorized to use. If the user account already has bank cards linked to it, you can select one of them without adding a new one.

        {% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}

        {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

If you select the **{{ ui-key.yacloud_billing_account.create-account.label_payment_invoice }}** payment method or if the payer is a non-resident of Russia and Kazakhstan, further instructions will be emailed to you at the address specified in your Yandex or Yandex 360 account. You may also get this email if you select **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_card }}** for payment method in cases where your new billing account requires verification. Once your documents have been verified, you can activate your billing account and start using {{ yandex-cloud }}.

Email the following documents to [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}):


* Copy in English of the legal entity's or individual entrepreneur's certificate of incorporation or registration.
* [Billing account](../../billing/concepts/billing-account.md#billing-account-id) ID.


