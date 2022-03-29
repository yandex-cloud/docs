# Registration

To access the [Marketplace partner account]({{ link-cloud-partners }}), you need to have a user account. This can be a Yandex ID or a Yandex.Connect account. The user account must have a [billing account](../../billing/concepts/billing-account.md#ba-types) of a legal entity that is a resident of the Russian Federation or the Republic of Kazakhstan. {{ marketplace-name }} doesn't cooperate with individuals and non-residents of the Russian Federation or the Republic of Kazakhstan.

{% note info %}

If you use an existing billing account to pay for {{ yandex-cloud }} service usage, we recommend that you create a new billing account for the same user.

{% endnote %}

If you already have a user account, log in to the management console and create a [billing account](../../billing/concepts/billing-account.md):

1. Make sure that your current phone number is linked to your user account.
1. In the management console, go to [Billing]({{ link-console-billing }}).
1. On the **List of accounts** page, click **Create account**. Fill in your information:
   * Select the payer's country.
   * Specify the name of the billing account that will be displayed in the list of billing accounts.
1. If in the **Payers** section you see a list of available payers, you can select one of them or add a new one.
1. To add a new payer, select **Payer type** — **Legal entity**.

   * Select a payment method: **Bank card** or **Bank transfer**. You can [change your payment method](../../billing/operations/change-payment-method.md) any time after creating a billing account.
   * Enter the legal information of your organization.

      {% include [billing-note](../../_includes/marketplace/billing-note.md) %}

   * If you select the **Bank card** payment method, link your corporate bank card:

      {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}

      * Confirm that the card is corporate and you are authorized to use it.

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      {% include [yandex-account](../../_includes/billing/payment-card-validation.md) %}

   * Click **Activate**.

   If you select the **Bank transfer** payment method, you will receive an email with further instructions at the email address specified in your user account. In this case, it may take up to three business days to activate your billing account.