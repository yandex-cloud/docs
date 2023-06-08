---
title: "Registering an account in {{ yandex-cloud }}"
description: "To use {{ yandex-cloud }} services, create a billing account first. The account is required even if you plan to use only free services."
keywords:
  - how to register in the cloud
  - "how to register in the cloud in {{ yandex-cloud }}"
  - registering in the cloud
  - creating an account in the cloud
---

# Registering an account in {{ yandex-cloud }}

To work with {{ yandex-cloud }} services, a billing account is required. A billing account is required even if you plan to use only free services. The account stores information about the payer and payment details; however, {{ yandex-cloud }} does not debit funds from your bank account and does not invoice you until you switch to the [paid version](../operations/activate-commercial.md).

Under one Yandex account, all payers must be either residents of Russia or Kazakhstan, or residents of other countries. You can learn more about billing accounts [here](../concepts/billing-account.md).

When creating the first billing account, new customers are given the [initial grant](../concepts/bonus-account.md#start). You can use it to pay for any {{ yandex-cloud }} resources.

In addition, a trial period is available to new customers. The [trial period](../concepts/trial-period.md) allows you to discover the possibilities of the cloud infrastructure for free with some limitations. To be able to use the resources in full, after your trial period ends, you need to switch to the paid version.

{% list tabs %}

- Individual

   To create a billing account:

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

   1. Log in to your Yandex ID or Yandex 360 account. If you do not have an account yet, sign up and create your first cloud in the management console. If you use a social network profile to log in to Yandex, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1).

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. On the **Accounts** page, click **Create account**. Fill in your information:

      * Select the payer's country.
      * Enter the name of the billing account. The name is displayed in the list of your billing accounts and helps you select the one you need.

   1. If in the **Payers** section you see a list of available payers, you can select one of them or add a new one.

      To add a payer:

      * Select the payer type: **Individual**.
      * Enter your first, last, and middle name.

      {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

   1. Enter your current email address and phone number. Contact details are required not only to reach you, but also to issue payment invoices and send financial documents.

   1. If this is your first billing account in {{ yandex-cloud }}, a trial period is available to you.

         
      {% note info %}

      In some cases, additional verification may be required when you create a billing account with a trial period. On the page of this billing account in the management console, you'll find a message with detailed instructions.

      {% endnote %}

      * When enabling the trial period, remember that after its expiration, your resources will be suspended. To resume operation, you will need to switch to the [paid version](../operations/activate-commercial.md).
      * If you do not activate the trial period at this stage, your account will be created with paid consumption. In this case, [after using up the initial grant](../../getting-started/usage-grant.md), you will not have to upgrade to the paid version.

   1. Click **Create**.

- Legal entity, individual entrepreneur, or non-resident of Russia and Kazakhstan

   To create a billing account:

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

   1. Log in to your Yandex ID or Yandex 360 account. If you do not have an account yet, sign up and create your first cloud in the management console. If you use a social network profile to log in to Yandex, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1).

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. On the **Accounts** page, click **Create account**. Fill in your information:

      * Select the payer's country.
      * Enter the name of the billing account. The name is displayed in the list of your billing accounts and helps you select the one you need.

   1. If in the **Payers** section you see a list of available payers, you can select one of them or add a new one.

   1. Select the payer type: **Business or individual entrepreneur**.

   1. Select a payment method: **Bank card** or **Bank transfer**. You can [change your payment method](../operations/change-payment-method.md) any time after creating a billing account.

   1. Enter the legal information of your organization and your contact details.

      {% include [contacts-note](../../_includes/billing/contacts-note.md) %}

   1. If you select the **Bank card** payment method, link your corporate bank card:

      {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}

      * Confirm that this is a corporate bank card and you are authorized to use it.

      {% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}

      {% include [yandex-account](../../_includes/billing/payment-card-validation.md) %}

   1. If this is your first billing account in {{ yandex-cloud }}, a trial period is available to you.

      * When enabling the trial period, remember that after its expiration, your resources will be suspended. To resume operation, you will need to switch to the [paid version](../operations/activate-commercial.md).
      * If you do not activate the trial period at this stage, your account will be created with paid consumption. In this case, [after using up the initial grant](../../getting-started/usage-grant.md), you will not have to upgrade to the paid version.

   1. Click **Create**.

      
      If you select the **Bank transfer** payment method or if the payer is a non-resident of Russia or Kazakhstan, you will receive an email with further instructions at the email address specified in your Yandex or Yandex 360 account. It may take up to three business days to activate your billing account.




{% endlist %}

{% include [account-roles](../_includes/account-roles.md) %}

### Learn more

- [Billing accounts](../concepts/billing-account.md)
- [Trial period](../../getting-started/free-trial/concepts/quickstart.md)

### Get started with {{ yandex-cloud }} {#start}

{% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}
