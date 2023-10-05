# Create a new billing account

Cloud members can create one or more [billing accounts](../concepts/billing-account.md). To do this:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

1. {% include [create-account-button-step](../_includes/create-account-button-step.md) %}

1. {% include [choose-country-step](../_includes/choose-country-step.md) %}

   {% include [billing-account-payers](../_includes/billing-account-payers.md) %}

1. {% include [choose-name-step](../_includes/choose-name-step.md) %}

1. {% include [choose-balance-payer](../_includes/choose-balance-payer.md) %}

1. {% include [choose-type-step](../_includes/choose-type-step.md) %}

1. Fill in the form:

   {% list tabs %}

   - Individuals

      Enter your full name and link a bank card:

      {% include [pin-card-data](../_includes/pin-card-data.md) %}

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

      {% include [payment-card-validation](../_includes/payment-card-validation.md) %}

   - Businesses and individual entrepreneurs

      7.1. Select a payment method (bank card or bank transfer):
      - **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}**.
      <br/>Link your corporate bank card:

         {% include [pin-card-data](../_includes/pin-card-data.md) %}

         {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

         {% include [pin-card-note](../_includes/pin-card-note.md) %}

         {% include [yandex-account](../_includes/payment-card-validation.md) %}
      - **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}**.

      7.1. Enter the legal information of your organization.

   {% endlist %}

1. Make sure that the provided contact details are correct.

   {% include [contacts-note](../_includes/contacts-note.md) %}

1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

   {% include [account-roles](../_includes/account-roles.md) %}


