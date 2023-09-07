---
title: "Instructions for businesses on how to create a billing account in {{ yandex-cloud }}"
description: "In this tutorial, you will learn how to create a billing account for a business in {{ yandex-cloud }}. Find the answers to FAQs about a billing account and paid consumption, the initial grant, and documents."
---

# Getting started for businesses

{% include notitle [start](../_includes/quickstart-start.md) %}

## Creating a billing account {#new-account}

A billing account is required even if you are going to use only free services. When you create the first billing account linked to your user account, you are awarded the [initial grant](../usage-grant.md).

{% list tabs %}

- Trial period

   ![quickstart](../../_assets/overview/legal-entity-trial-period.svg)

- Paid version

   ![quickstart](../../_assets/overview/legal-entity-paid-version.svg)

{% endlist %}

{% include [main](../../_includes/billing/registration-main.md) %}

Provide details to create a billing account:

1. Select a payment method: **{{ ui-key.yacloud.billing.account.overview.payment-type_label_card }}** or **{{ ui-key.yacloud.billing.account.overview.payment-type_label_invoice }}**. You can [change your payment method](../../billing/operations/change-payment-method.md) any time after creating a billing account.

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

      Sometimes, additional verification may be required when you create a billing account with a trial period. If this is the case, you will find a message with detailed instructions on the billing account page in the management console.

      {% endnote %}

      * When enabling the trial period, remember that after its expiration, your resources will be suspended. To resume operation, you will need to switch to the [paid version](../free-trial/concepts/upgrade-to-paid.md).
      * If you do not activate the trial period at this stage, your account will be created as a paid account. In this case, [after using up the initial grant](../usage-grant.md), you will not have to upgrade to the paid version.

   1. Click **{{ ui-key.yacloud.common.create }}**.

- Bank transfer

   1. Enter the legal information of your organization and your contact details.

      {% include [contacts-note](../../_includes/billing/contacts-note.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

   You will receive an email with further instructions at the email address specified in your user account. It may take up to three business days to activate your billing account.

   If this is your first billing account in {{ yandex-cloud }}, it's created with the trial period enabled. To continue using the resources after your trial period ends, make sure to switch to the [paid version](../../billing/operations/activate-commercial.md).

{% endlist %}


{% include [start](../_includes/quickstart-qa-whats-next.md) %}