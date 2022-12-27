# Create a new billing account

Cloud members can create one or more [billing accounts](../concepts/billing-account.md). {% if product == "yandex-cloud" %}To do this:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

1. {% include [create-account-button-step](../_includes/create-account-button-step.md) %}

1. {% include [choose-country-step](../_includes/choose-country-step.md) %}

   {% include [billing-account-payers](../_includes/billing-account-payers.md) %}

1. {% include [choose-name-step](../_includes/choose-name-step.md) %}

1. {% include [choose-balance-payer](../_includes/choose-balance-payer.md) %}

1. {% include [choose-type-step](../_includes/choose-type-step.md) %}

1. Fill in the form:

   {% list tabs %}

    - Individual

       Enter your full name and link a bank card:

         {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

        {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

        {% include [payment-card-validation](../_includes/payment-card-validation.md) %}

    - Business or individual entrepreneur

      7.1. Select a payment method (bank card or bank transfer):
      - **Bank card**
      <br/>Link your corporate bank card:

        {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

        {% include [pin-card-note](../_includes/pin-card-note.md) %}

        {% include [yandex-account](../_includes/payment-card-validation.md) %}
      - **Bank transfer**

      7.2. Enter the legal information of your organization.

   {% endlist %}



1. Make sure that the provided contact details are correct.

    {% include [contacts-note](../_includes/contacts-note.md) %}

1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

    {% include [account-roles](../_includes/account-roles.md) %}

{% endif %}

{% if product == "cloud-il" %}

{% list tabs %}

- Individual

  To create a billing account:

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

   1. Log in to your Google account, that is used in {{ yandex-cloud }}.

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. On the **Accounts** page, click **Create account** button.

   1. Specify the name of the billing account that will be displayed in the list of billing accounts.

   1. To add a new payer:

      * Select **Individual**.
      * Enter your first and last name.
      * Enter your Teudat zehut and post address.

   1. Link the card.

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      * In the **Bank card** section click **Bind**.
      * Enter the bank card details: the 16-digit number, I.D. Number, expiration date and CVV (on the back of the card).
      * Click **Pay now**.

      {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

      {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

   1. Enter your current email address. Contact details are required not only to reach you, but also to issue payment invoices and send financial documents.

   1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

      {% include [account-roles](../_includes/account-roles.md) %}

- Company

  To create a billing account:

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

   1. Log in to your Google account, that is used in {{ yandex-cloud }}.

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. On the **Accounts** page, click **Create account** button.

   1. Specify the name of the billing account that will be displayed in the list of billing accounts.

   1. To add a new payer:

      * Select **Company**.
      * Enter the legal information of your organization.

   1. Link the card.

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      * In the **Bank card** section click **Bind**.
      * Enter the bank card details: the 16-digit number, I.D. Number, expiration date and CVV (on the back of the card).
      * Click **Pay now**.

      {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

      {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

   1. Enter your current email address. Contact details are required not only to reach you, but also to issue payment invoices and send financial documents.

   1. Confirm that the card is corporate and you are authorized to use it.

   1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

      {% include [account-roles](../_includes/account-roles.md) %}

{% endlist %}

{% endif %}