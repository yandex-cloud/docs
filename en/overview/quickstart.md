---
title: "Getting started with Yandex.Cloud"
description: "From this article you will learn how to work with the Yandex.Cloud platform. We will tell you in more detail how to create Linux and Windows virtual machines, use services for storing data like Object Storage (S3), configure the network and load balancers, manage access to resources and create a cluster of different databases."
---

# Getting started

The {{ yandex-cloud }} platform has several user interfaces, such as the [management console]({{ link-console-main }}) and the [command line interface](../cli/). To access any user interface, you will need a _user account_. This can be a personal Yandex account (Yandex ID) or a Yandex.Connect account. For detailed instructions, see Help for [Yandex ID](https://yandex.com/support/passport/authorization/registration.html) and [Yandex.Connect](https://yandex.com/support/connect/personal.html#personal__section_aq5_hcq_23b).

## Creating a billing account {#new-account}

A billing account is required even if you plan to use only free services. After you create the first billing account linked to your user account, you are awarded the initial grant. For more information about the initial grant, see [{#T}](../billing/concepts/bonus-account.md).

If you already have a user account, log in to the management console and create a [billing account](../billing/concepts/billing-account.md):

1. Make sure that your current phone number is linked to your user account.
1. Log in to the management console with a user account and go to [Billing]({{ link-console-billing }}).
1. On the **List of accounts** page, click **Create account**. Fill in your information:
   * Select the payer's country.
   * Specify the name of the billing account, which will be displayed in the list of billing accounts and help you identify it.
1. If in the **Payers** section you see a list of available payers, you can select one of them or add a new one.
1. To add a new payer, select **Payer type**:
   * **Individual** is intended for residents of Russia and Kazakhstan.
   * **Legal entity or Sole Proprietor** is intended for residents and non-residents of Russia and Kazakhstan.

   For more information about the types of payment accounts and their limitations, see [Overview of payment accounts](https://cloud.yandex.com/en/docs/billing/concepts/billing-account#ba-types).

   {% note info %}

   Within one user account, all payers must be either residents of Russia, residents of Kazakhstan, or non-residents.

   {% endnote %}

 {% list tabs %}

   - Individual
      * Enter your first, last, and middle name.

      {% include [pin-card-data](../_includes/billing/pin-card-data.md) %}

      {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

      {% include [payment-card-validation](../_includes/billing/payment-card-validation.md) %}

   - Legal entity, individual entrepreneur, or non-resident of Russia and Kazakhstan

     If the payer is a non-resident of Russia or Kazakhstan, only one payer type is available: **Business (non-resident of Russia)**.

      * Select a payment method: **Bank card** or **Bank transfer**. You can [change your payment method](../billing/operations/change-payment-method.md) any time after creating a billing account.
      * Enter the legal information of your organization.

        {% include [contacts-note](../_includes/billing/contacts-note.md) %}

     * If you select the **Bank card** payment method, link your corporate bank card:

         {% include [pin-card-data](../_includes/billing/pin-card-data.md) %}
         * Confirm that the card is corporate and you are authorized to use it.

         {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

         {% include [yandex-account](../_includes/billing/payment-card-validation.md) %}

     * Click **Activate**.

     If you select the **Bank transfer** payment method or if the payer is a non-resident of Russia or Kazakhstan, you will receive an email with further instructions at the email address specified in your user account. In this case, it may take up to three business days to activate your billing account.

   {% endlist %}

## What's next? {#what-is-next}

Start exploring {{ yandex-cloud }} services.

{% include [quickstart-all-no-billing](../_includes/quickstart-all-no-billing.md) %}

