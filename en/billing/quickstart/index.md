---
title: Registering an account in Yandex.Cloud
description: To use cloud services {{ yandex-cloud }}, register and create a billing account. An account is required even if you plan to use only free services.
keywords:
  - how to register in the cloud
  - how to register in the Yandex cloud
  - registration in the cloud
  - creating an account in the cloud
---

# Registering an account in {{ yandex-cloud }}

To use {{ yandex-cloud }} services, create a billing account.

A billing account is required even if you plan to use only free services. When creating a billing account, you need to enter payer details, but {{ yandex-cloud }} doesn't debit funds from your bank card and doesn't invoice you until you switch to the [paid version](../operations/activate-commercial.md).

Under one Yandex account, all payers must be either residents of the Russian Federation or non-residents. Learn more about [billing accounts](../concepts/billing-account.md).

{% list tabs %}

- Applying as an individual

   To create a billing account:

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

   1. Log in to your Yandex or Yandex.Connect account. If you don't have an account yet, sign up.
      - Your phone number must be linked to this account. For detailed instructions, see Help for [Yandex.Passport](https://yandex.com/support/passport/authorization/registration.html) and [Yandex.Connect](https://yandex.com/support/connect/personal.html#personal__section_aq5_hcq_23b).
      - If you use a social network profile to log in to Yandex, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1).

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. On the **Account list** page, click **Create an account**. Fill in your information:

      - Select the payer's country.
      - Enter the name of the billing account. The name is displayed in the list of your billing accounts and helps you select the one you need.

   1. If in the **Payers** section you see a list of available payers, you can select one of them or add a new one.

      To add a payer:
      
      - Select the payer type: **Individual**.
      - Enter your first, last, and middle name.

        {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../_includes/payment-card-types.md) %}

        {% include [payment-card-validation](../_includes/payment-card-validation.md) %}

   1. Click **Activate**.

- Legal entity, individual entrepreneur or non-resident of Russia

   To create a billing account:

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

   1. Log in to your Yandex or Yandex.Connect account. If you don't have an account yet, sign up.
   
      - Your phone number must be linked to this account. For detailed instructions, see Help for [Yandex.Passport](https://yandex.com/support/passport/authorization/registration.html) and [Yandex.Connect](https://yandex.com/support/connect/personal.html#personal__section_aq5_hcq_23b).
      - If you use a social network profile to log in to Yandex, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1).

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. On the **Account list** page, click **Create an account**. Fill in your information:

      - Select the payer's country.
      - Enter the name of the billing account. The name is displayed in the list of your billing accounts and helps you select the one you need.

   1. If in the **Payers** section you see a list of available payers, you can select one of them or add a new one.

      To add a payer:

        - Select the payer type: **Business or entrepreneur**.

          If the payer is a non-resident of Russia, only one payer type is available: **Business (non-resident of Russia)**.

        - Select a payment method: **Bank card** or **Bank transfer**. You can [change your payment method](../operations/change-payment-method.md) any time after creating a billing account.

        - Enter the legal information of your organization.

          {% include [contacts-note](../_includes/contacts-note.md) %}

        - If you select the **Bank card** payment method, link your corporate bank card:

          {% include [pin-card-data](../_includes/pin-card-data.md) %}
	    
            - Confirm that the card is corporate and you are authorized to use it.

              {% include [payment-card-types](../_includes/payment-card-types.md) %}

              {% include [yandex-account](../_includes/payment-card-validation.md) %}

   1. Click **Activate**.

      If you select the **Bank transfer** payment method or if the payer is a non-resident of Russia, you receive an email with further instructions at the email address specified in your Yandex or Yandex.Connect account. In this case, it may take up to three business days to activate your billing account.

{% endlist %}

{% include [account-roles](../_includes/account-roles.md) %}

### Learn more

- [Billing account](../concepts/billing-account.md).
- [Trial period](../../free-trial/concepts/quickstart.md).

### Get started with {{ yandex-cloud }} {#start}

   {% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}

Testing nanov94
111dd
fv
