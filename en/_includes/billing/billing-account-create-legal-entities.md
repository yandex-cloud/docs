To create a billing account:

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
1. {% include [create-ba-step2](../../billing/_includes/create-ba-step2.md) %}
1. {% include [create-ba-step3](../../billing/_includes/create-ba-step3.md) %}

   {% include [create-additional-ba-ui-notice](../../billing/_includes/create-additional-ba-ui-notice.md) %}

   In the window that opens:

   1. {% include [choose-name-step](../../billing/_includes/choose-name-step.md) %}
   1. {% include [choose-org-step](../../billing/_includes/choose-org-step.md) %}
   1. {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}
  
      {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

   1. {% include [create-ba-choose-ul-step](../../billing/_includes/create-ba-choose-ul-step.md) %}
   1. {% include [create-ba-choose-payment-method-step](../../billing/_includes/create-ba-choose-payment-method-step.md) %}
   1. Click **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
   1. {% include [create-ba-import-egrul-step](../../billing/_includes/create-ba-import-egrul-step.md) %}
   1. {% include [create-ba-ul-bank-card-step](../../billing/_includes/create-ba-ul-bank-card-step.md) %}


   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}

      {% note info %}

      If this is your first {{ yandex-cloud }} billing account, you are eligible for a [trial period](../../billing/concepts/trial-period.md). After it expires, the access to your resources will be suspended. To resume operation, you will need to switch to the [paid version](../../billing/operations/activate-commercial.md).

      {% endnote %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

      If you select the **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}** payment method or if the payer is a non-resident of Russia and Kazakhstan, further instructions will be emailed to you at the address specified in your Yandex or Yandex 360 account. You may also get this email if you select **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_card }}** for payment method in cases where your new billing account requires verification. Once your documents have been verified, you can activate your billing account and start using {{ yandex-cloud }}.

      Email the following documents to [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}):

      
      * Copy in English of the legal entity's or individual entrepreneur's certificate of incorporation or registration.
      * [Billing account](../../billing/concepts/billing-account.md#billing-account-id) ID.


