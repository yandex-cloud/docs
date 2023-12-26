---
title: "Getting started with {{ yandex-cloud }}"
description: "In this article, you will learn how to get started with {{ yandex-cloud }}. Find out how to create Linux and Windows VMs, use {{ objstorage-name }} services for data storage (S3), set up a network and load balancers, manage access to resources, and create clusters in a variety of databases."
---

# Getting started with {{ yandex-cloud }}


The {{ yandex-cloud }} platform has several user interfaces, e.g., the [management console]({{ link-console-main }}) and the [command line interface](../cli/). To access any user interface, you will need a _user account_. This can be a personal Yandex account (Yandex ID) or a {{ yandex-360 }} account. For detailed instructions, see the Help for [Yandex ID](https://yandex.com/support/passport/authorization/registration.html) and [Yandex 360](https://yandex.com/support/business/add-users.html).

## Creating a billing account {#new-account}

When you create the first billing account linked to your user account, you are awarded the [initial grant](../getting-started/usage-grant.md).

{% include [main](../_includes/billing/registration-main.md) %}

{% list tabs %}

- Individuals

   * Enter your first, last, and middle name.

   * Link your bank card. Specify your card details: 16-digit number, expiration date, and CVV (you can find it on the back side of your card).

      {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

      {% include [payment-card-validation](../_includes/billing/payment-card-validation.md) %}

   * Enter your current email address and phone number. Contact details are required not only to reach you, but also to issue payment invoices and send financial documents.

   * If this is your first billing account in {{ yandex-cloud }}, a [trial period](../getting-started/free-trial/concepts/quickstart.md) is available to you.

      {% note info %}

      Sometimes, additional verification may be required when you create a billing account with a trial period. You will find a message with detailed instructions on the billing account page in the management console.

      {% endnote %}

      * When enabling the trial period, remember that after its expiration, your resources will be suspended. To resume operation, you will need to switch to the [paid version](../billing/operations/activate-commercial.md).
      * If you do not activate the trial period at this stage, your account will be created as a paid account. In this case, [after using up the initial grant](../getting-started/usage-grant.md), you will not have to upgrade to the paid version.

- Legal entities, individual entrepreneurs, or non-residents of Russia and Kazakhstan {#businesses-entrepreneurs}

   * Select a payment method: **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}** or **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}**. You can [change your payment method](../billing/operations/change-payment-method.md) any time after creating a billing account.
   * Enter the legal information of your organization and your contact details.

      {% include [contacts-note](../_includes/billing/contacts-note.md) %}

   * If you select the **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}** payment method, link your corporate bank card. Specify your card details: 16-digit number, expiration date, and CVV (you can find it on the back side of your card). Confirm the card is a corporate one and you are authorized to use it.

      {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

      {% include [yandex-account](../_includes/billing/payment-card-validation.md) %}

   * If this is your first billing account in {{ yandex-cloud }}, a [trial period](../getting-started/free-trial/concepts/quickstart.md) is available to you.

      {% note info %}

      Sometimes, additional verification may be required when you create a billing account with a trial period. You will find a message with detailed instructions on the billing account page in the management console.

      {% endnote %}

      * When enabling the trial period, remember that after its expiration, your resources will be suspended. To resume operation, you will need to switch to the [paid version](../billing/operations/activate-commercial.md).
      * If you do not activate the trial period at this stage, your account will be created as a paid account. In this case, [after using up the initial grant](../getting-started/usage-grant.md), you will not have to upgrade to the paid version.

   * Click **{{ ui-key.yacloud.common.create }}**.

   If you select the **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}** payment method or if the payer is a non-resident of Russia or Kazakhstan, you will receive an email with further instructions at the email address specified in your user account. In this case, it may take up to three business days to activate your billing account.

   If this is your first payment account in {{ yandex-cloud }}, and you have selected **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}** as a payment method, the account will be created in the trial period. To continue using the resources after your trial period ends, make sure to switch to the [paid version](../billing/operations/activate-commercial.md).

{% endlist %}

## FAQ {#qa}

### Questions about billing accounts and paid accounts {#billing-account}

#### Why do I need a billing account with a linked bank card?

Billing accounts are used to identify users paying for {{ yandex-cloud }} resources. Even if you plan to use only free services, you still need a billing account: grants and promo codes are credited to it.

To activate a billing account, we require you to link a bank card to make sure that you are a human and not a robot. When linking the card, a small amount will be debited and immediately returned. That is how we verify that your card is real.

Payment for {{ yandex-cloud }} services and resources will be debited from your bank card only after you explicitly allow this, that is, after you switch to a paid account.

#### What happens after the trial period ends? Will you start debiting money right away?

{{ yandex-cloud }} doesn't debit money and doesn't invoice you until you have switched to a paid account. The switching to paid consumption never happens automatically.

However, if your [grant](../getting-started/usage-grant.md) has expired, access to your resources will be blocked for 30 days or until you switch to paid consumption. For more information about expiry of the trial period, see [{#T}](../getting-started/free-trial/concepts/trial-ending.md).

### Questions about the initial grant {#grant}

#### I accidentally switched to a paid account. Did I lose my initial grant? Can I get it back?

No, you cannot switch back to the trial version, but the grant will not be lost. The initial grant will be spent first. For more information about the order in which funds are spent, see [Billing cycle for individuals](../billing/payment/billing-cycle-individual.md) and [Billing cycle for businesses and individual entrepreneurs](../billing/payment/billing-cycle-business.md).

#### I have not used up the initial grant fully, but my cloud is blocked. What should I do?

The cloud may be blocked for a few reasons:

1. Make sure that a valid card is linked to your account. If you linked the card and then deleted it, your account may be blocked.

1. The initial grant is provisionally divided into two parts that can be used at the same time. One part covers payment for the Compute service, the other part — the rest of the {{ yandex-cloud }} services. If you run out of one part, you can continue using the cloud by switching to a paid account. The unspent part of the grant will be preserved. For more information about using the initial grant and switching to a paid period, see [{#T}](../getting-started/free-trial/concepts/upgrade-to-paid.md).

#### I couldn't use up the initial grant in 60 days. Can I use {{ yandex-cloud }}?

When the initial grant expires, the total unused amount is offset, and the access to your resources is suspended for 30 days. To continue using {{ yandex-cloud }}, switch to a paid plan.

### About the {#documents} documents

#### Is it safe to pay to {{ yandex-cloud }}?

The {{ yandex-cloud }} platform meets the PCI DSS requirements; this is why it is safe to use the cloud services for payment processing. For more information about PCI DSS certification, see [{#T}](../security/conform.md#pci-dss).

#### Where do I find my agreement with {{ yandex-cloud }}?

{% include [contract-concept](../_includes/billing/contract.md) %}

No printed offer is provided.

No physical invoice is provided, but you can generate and print it out from the console.

#### I need a bilateral contract rather than an offer. Can I have it?

Yes, companies and individual entrepreneurs can sign a bilateral contract. Send a request using the [Message]({{ link-console-support }}) form. A {{ yandex-cloud }} manager will contact you to discuss the terms.

#### How do I get invoiced?

To get an invoice for paying at a bank office, use instructions at [{#T}](../billing/operations/pay-the-bill.md#legal-entities).

{{ yandex-cloud }} doesn't provide paper payment documents.

## Getting started with services {#what-is-next}

Start exploring {{ yandex-cloud }} services.

{% include [quickstart-all-no-billing](../_includes/quickstart-all-no-billing.md) %}



{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
