---
title: "Getting started with Yandex.Cloud"
description: "With the help of this article, you will learn how to work with Yandex.Cloud cloud platform. Let's take a closer look at how to create Linux and Windows virtual machines, use Object Storage (S3) storage services, configure networking and load balancers, manage access to resources, and create database clusters."
---

# Getting started

The {{ yandex-cloud }} platform has several user interfaces, such as the [management console]({{ link-console-main }}) and the [command line interface](../cli/). To access any user interface, you will need a _user account_. This can be a personal Yandex account (Yandex ID) or a Yandex.Connect account. For detailed instructions, see Help for [Yandex ID]{% if lang == "ru" %}(https://yandex.ru/support/passport/authorization/registration.html){% endif %}{% if lang == "en" %}(https://yandex.com/support/passport/authorization/registration.html){% endif %} and [Yandex.Connect]{% if lang == "ru" %}(https://yandex.ru/support/connect/personal.html#personal__section_aq5_hcq_23b){% endif %}{% if lang == "en" %}(https://yandex.com/support/connect/personal.html#personal__section_aq5_hcq_23b){% endif %}.

## Creating a billing account {#new-account}

A billing account is required even if you plan to use only free services. When you create the first billing account linked to your user account, you are awarded the [initial grant](../getting-started/usage-grant.md).

{% include [main](../_includes/billing/registration-main.md) %}

{% list tabs %}

- Individual

   * Enter your first, last, and middle name.

   * Link your bank card. Enter the bank card details: the 16-digit number, expiration date, and CVV (on the back of the card).

      {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

      {% include [payment-card-validation](../_includes/billing/payment-card-validation.md) %}

   * Enter your current email address and phone number. Contact details are required not only to reach you, but also to issue payment invoices and send financial documents.

   * If this is your first billing account in {{ yandex-cloud }}, a [trial period](../getting-started/free-trial/concepts/quickstart.md) is available to you.

      {% note info %}

      In some cases, additional verification may be required when you create a billing account with a trial period. On the page of this billing account in the management console, you'll find a message with detailed instructions.

      {% endnote %}

      * When enabling the trial period, remember that after its expiration, your resources will be discontinued. To resume operation, you will need to switch to the [paid version](../billing/operations/activate-commercial.md).
      * If you don't activate the trial period at this stage, your account will be created with paid consumption. In this case, [after using up the initial grant](../getting-started/usage-grant.md), you don't have to upgrade to the paid version.

- Legal entity, individual entrepreneur or non-resident of Russia and Kazakhstan

   * Select a payment method: **Bank card** or **Bank transfer**. You can [change your payment method](../billing/operations/change-payment-method.md) any time after creating a billing account.
   * Enter the legal information of your organization and your contact details.

      {% include [contacts-note](../_includes/billing/contacts-note.md) %}

   * If you select the **Bank card** payment method, link your corporate bank card: Enter the bank card details: the 16-digit number, expiration date, and CVV (on the back of the card). Confirm that the card is corporate and you are authorized to use it.

      {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

      {% include [payment-card-validation](../_includes/billing/payment-card-validation.md) %}

   * If this is your first billing account in {{ yandex-cloud }}, a [trial period](../getting-started/free-trial/concepts/quickstart.md) is available to you.

      {% note info %}

      In some cases, additional verification may be required when you create a billing account with a trial period. On the page of this billing account in the management console, you'll find a message with detailed instructions.

      {% endnote %}

      * When enabling the trial period, remember that after its expiration, your resources will be discontinued. To resume operation, you will need to switch to the [paid version](../billing/operations/activate-commercial.md).
      * If you don't activate the trial period at this stage, your account will be created with paid consumption. In this case, [after using up the initial grant](../getting-started/usage-grant.md), you don't have to upgrade to the paid version.

   * Click **Activate**.

   If you select the **Bank transfer** payment method or if the payer is a non-resident of Russia or Kazakhstan, you will receive an email with further instructions at the email address specified in your user account. In this case, it may take up to three business days to activate your billing account.

   If this is your first payment account in {{ yandex-cloud }}, and you've selected **Bank transfer** as a payment method, the account will be created in the trial period. To continue to use the resources after your trial period ends, make sure to switch to the [paid version](../billing/operations/activate-commercial.md).

{% endlist %}

## FAQ {#qa}

### Questions about a billing account and paid consumption {#billing-account}

#### Why do I need a billing account with a linked bank card?

Billing accounts are used to identify users paying for {{ yandex-cloud }} resources. Even if you plan to use only free services, you still need a billing account: grants and promo codes are credited to it.

To activate a billing account, we require you to link a bank card to make sure that you are a human and not a robot. When linking the card, a small amount will be debited and immediately returned. This way we verify that your card is real.

Payment for {{ yandex-cloud }} services and resources will be debited from your bank card only after you explicitly allow this, that is, after you switch to a paid account.

#### What happens after the trial period ends? Will you start debiting money right away?

{{ yandex-cloud }} doesn't debit money and doesn't invoice you until you have switched your account to paid consumption. Switching to a paid account never happens automatically.

However, if the your [grant](../getting-started/usage-grant.md) expired, access to your resources will be blocked for 30 days or until you switch to a paid account. For more information about trial period expiration, see [{#T}](../getting-started/free-trial/concepts/trial-ending.md).

### Questions about the initial grant {#grant}

#### I accidentally switched to paid consumption. Did I lose my initial grant? Can I get it back?

No, you can't switch back to the trial version, but the grant will not be lost. The initial grant will be spent first. For more information about the order in which funds are spent, see [{#T}](../billing/payment/billing-cycle.md).

#### I haven't used up the entire initial grant, but my cloud is blocked. What should I do?

The cloud may be blocked for a few reasons:

1. Make sure that a valid card is linked to your account. If you linked the card and then deleted it, your account may be blocked.

1. The initial grant is provisionally divided into two parts that can be used at the same time. One part covers payment for the Compute service, the other part — the rest of the {{ yandex-cloud }} services. If you run out of one part, you can continue using the cloud by switching to a paid account. The unspent part of the grant will be preserved. For more information about using the initial grant and switching to a paid period, see [{#T}](../getting-started/free-trial/concepts/upgrade-to-paid.md).

#### I couldn't use up the initial grant in 60 days. Can I use {{ yandex-cloud }}?

When the initial grant expires, the entire unspent amount is reset and access to your resources is suspended for 30 days. To continue using {{ yandex-cloud }}, switch to a paid account.

### Questions about documents {#documents}

#### Is it safe to pay {{ yandex-cloud }}?

The {{ yandex-cloud }} platform meets PCI DSS requirements, so it's safe to use cloud services for payment processing. For more information about PCI DSS certification, see [{#T}](../overview/security/conform.md#pci-dss).

#### Where can I find my agreement with {{ yandex-cloud }}?

{% include [contract-concept](../_includes/billing/contract.md) %}

There is no print form of the offer.

The invoice is not physically provided either, but you can generate it in the console and print it out.

#### I need an agreement signed by both parties, not an offer. Can I get it?

Yes, businesses and individual entrepreneurs may conclude an agreement that is signed by both parties. To do this, submit a request using the [Message]({{ link-console-support }}) form. A {{ yandex-cloud }} manager will contact you to discuss the terms and conditions of signing the agreement.

#### How can I get an invoice for payment?

To get an invoice for payment in the bank, use the instructions on [{#T}](../billing/operations/pay-the-bill.md#legal-entities).

{{ yandex-cloud }} doesn't provide paper documents for payment.

## What's next? {#what-is-next}

Start exploring {{ yandex-cloud }} services.

{% include [quickstart-all-no-billing](../_includes/quickstart-all-no-billing.md) %}