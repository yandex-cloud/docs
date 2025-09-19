# Registration

To access the [Marketplace partner account]({{ link-cloud-partners }}), you need to have a user account. This can be a Yandex ID or a Yandex 360 account. Your user account must have a [billing account](../../billing/concepts/billing-account.md#ba-types) of a legal entity residing in Russia or Kazakhstan. {{ marketplace-name }} is not available to individuals and non-residents of Russia or Kazakhstan.

{% note info %}

If you use an existing billing account to pay for {{ yandex-cloud }} service usage, we recommend that you create a new billing account for the same user.

{% endnote %}

If you already have a user account, create a [billing account](../../billing/concepts/billing-account.md):

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

      {% include [billing-note](../../_includes/marketplace/billing-note.md) %}

   1. {% include [create-ba-ul-bank-card-step](../../billing/_includes/create-ba-ul-bank-card-step.md) %}
   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. Click **{{ ui-key.yacloud.common.create }}**.

   If you select the `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_invoice }}` payment method, further instructions will be emailed to you at the address specified in your user account. Once your documents have been verified, you can activate your billing account and start using {{ yandex-cloud }}.