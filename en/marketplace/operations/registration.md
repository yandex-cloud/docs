# Registration

To access the [Marketplace partner account]({{ link-cloud-partners }}), you need to have a user account. This can be a Yandex ID or a Yandex 360 account. Your user account must have a [billing account](../../billing/concepts/billing-account.md#ba-types) of a legal entity that is a resident of Russia or Kazakhstan. {{ marketplace-name }} is not available to individuals and non-residents of Russia or Kazakhstan.

{% note info %}

If you use an existing billing account to pay for {{ yandex-cloud }} service usage, we recommend that you create a new billing account for the same user.

{% endnote %}

If you already have a user account, log in to the management console and create a [billing account](../../billing/concepts/billing-account.md):

1. Make sure that your current phone number is linked to your user account.
1. In the management console, go to [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}).
1. On the **{{ ui-key.yacloud_billing.billing.title_accounts }}** page, click **{{ ui-key.yacloud_billing.billing.accounts.main-banner_button_create }}**. Fill in your information:
   * Select the payer country.
   * Specify the name of the billing account to be displayed in the list of billing accounts.
1. If you see a list of available payers in the **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_persons }}** section, you can select one of them or add a new one.
1. To add a new payer, select **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_person-type }}**: `Legal entity or individual entrepreneur`.

   * Select a payment method: `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_card }}` or `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_invoice }}`. You can [change your payment method](../../billing/operations/change-payment-method.md) any time after creating a billing account.
   * Enter the legal information of your organization.

     {% include [billing-note](../../_includes/marketplace/billing-note.md) %}

   * If you select the `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_card }}` payment method, link your corporate bank card:

     {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}

      * Confirm that the card is a corporate one and you are authorized to use it.

     {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

     {% include [yandex-account](../../_includes/billing/payment-card-validation.md) %}

   * Click **{{ ui-key.yacloud.common.create }}**.

   If you select the `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_invoice }}` payment method, further instructions will be emailed to you at the address specified in your user account. Once your documents have been verified, you can activate your billing account and start using {{ yandex-cloud }}.