To create a billing account:

1. {% include [create-ba-step2](../../billing/_includes/create-ba-step2.md) %}

   When creating an organization, specify its name, e.g., `Example organization`. The organization will automatically get a new folder named `default`.

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
1. {% include [create-ba-step3](../../billing/_includes/create-ba-step3.md) %}

   {% include [create-additional-ba-ui-notice](../../billing/_includes/create-additional-ba-ui-notice.md) %}

   In the window that opens:

   1. In the **{{ ui-key.yacloud_billing_account.create-account.section_account_type }}** field, select **Individual**.
   1. {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}

      {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. Select **{{ ui-key.yacloud_billing_account.create-account.section_payment_method }}**: linked credit/debit card or manual top-up:

      * Link your credit or debit card. If the user account already has credit/debit cards linked to it, you can select one of them without adding a new one.

        After successfully adding your card, you will receive an [initial grant](../../billing/concepts/bonus-account.md) provided you are a first-time user of {{ yandex-cloud }}. The grant is valid for 60 days, but it does not cover GPU clusters, paid support plans, or {{ marketplace-short-name }} products.

        {% include [no-card](create-ba-without-card.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}
                
        {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

      * **{{ ui-key.yacloud_billing_account.create-account.label_option_card }}**: Top up your balance manually as needed.
   
   1. Click **{{ ui-key.yacloud.common.create }}**.

   {% note warning %}

   Note that for individuals an established verification procedure applies, which may result in the account activation being declined.

   {% endnote %}
