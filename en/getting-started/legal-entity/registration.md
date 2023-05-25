---
title: "Instructions for businesses on how to create a billing account in {{ yandex-cloud }}"
description: "In this tutorial, you'll learn how to create a business's billing account in {{ yandex-cloud }}. Find the answers to FAQs about a billing account and paid consumption, the initial grant, and documents."
---

# Getting started for businesses

{% include notitle [start](../_includes/quickstart-start.md) %}

## Creating a billing account {#new-account}

A billing account is required even if you plan to use only free services. When you create the first billing account linked to your user account, you are awarded the [initial grant](../usage-grant.md).

{% list tabs %}

- Trial period

   ![quickstart](../../_assets/overview/legal-entity-trial-period.svg)

- Paid version

   ![quickstart](../../_assets/overview/legal-entity-paid-version.svg)

{% endlist %}

{% include [main](../../_includes/billing/registration-main.md) %}

Provide details to create a billing account:

1. Select a payment method: **Bank card** or **Bank transfer**. You can [change your payment method](../../billing/operations/change-payment-method.md) any time after creating a billing account.

{% list tabs %}

- Bank card

   1. Enter the legal information of your organization.

      {% include [contacts-note](../../_includes/billing/contacts-note.md) %}

   1. Link your corporate bank card:

      {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}

      * Confirm the card is a corporate one and you are authorized to use it.

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      {% include [yandex-account](../../_includes/billing/payment-card-validation.md) %}

   1. Enter your current email address and phone number. Contact details are required not only to reach you, but also to issue payment invoices and send financial documents.

   1. If this is your first billing account in {{ yandex-cloud }}, a [trial period](../free-trial/concepts/quickstart.md) is available to you.

      {% note info %}

      In some cases, additional verification may be required when you create a billing account with a trial period. On the page of this billing account in the management console, you'll find a message with detailed instructions.

      {% endnote %}

      * When enabling the trial period, remember that after its expiration, your resources will be suspended. To resume operation, you will need to switch to the [paid version](../free-trial/concepts/upgrade-to-paid.md).
      * If you do not activate the trial period at this stage, your account will be created with paid consumption. In this case, [after using up the initial grant](../usage-grant.md), you will not have to upgrade to the paid version.

   1. Click **Create**.

- Bank transfer

   1. Enter the legal information of your organization and your contact details.

      {% include [contacts-note](../../_includes/billing/contacts-note.md) %}

   1. Click **Create**.

   You will receive an email with further instructions at the email address specified in your user account. It may take up to three business days to activate your billing account.

   If this is your first billing account in {{ yandex-cloud }}, it's created with the trial period enabled. To continue using the resources after your trial period ends, make sure to switch to the [paid version](../../billing/operations/activate-commercial.md).

{% endlist %}


{% include [start](../_includes/quickstart-qa-whats-next.md) %}