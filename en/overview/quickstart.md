---
title: "Getting started with {{ yandex-cloud }}"
description: "In this article, you will learn how to get started with {{ yandex-cloud }}. Find out how to create Linux and Windows VMs, use {{ objstorage-name }} services for data storage (S3), set up a network and load balancers, manage access to resources, and create clusters in a variety of databases."
---

# Getting started with {{ yandex-cloud }}



The {{ yandex-cloud }} platform has several user interfaces, e.g., the [management console]({{ link-console-main }}) and the [command line interface](../cli/). To access any user interface, you will need a _user account_. This can be a personal Yandex account (Yandex ID) or a Yandex 360 account. For detailed instructions, see help for [Yandex ID](https://yandex.com/support/passport/authorization/registration.html) and [Yandex 360](https://yandex.com/support/business/add-users.html).

## Creating a billing account {#new-account}

When creating your first billing account linked to your user account, you will get your [initial grant](../getting-started/usage-grant.md).

{% list tabs group=customers %}

- Individuals {#individuals}

   {% include [start-for-individuals](../_includes/billing/billing-account-create-individual.md) %}

- Legal entities, individual entrepreneurs, or non-residents of Russia and Kazakhstan {#businesses-entrepreneurs}

   {% include [start-for-legal-entities](../_includes/billing/billing-account-create-legal-entities.md) %}

{% endlist %}

## FAQ {#qa}

### Questions about billing accounts and paid accounts {#billing-account}

#### Why do I need a billing account with a linked bank card?

Billing accounts are used to identify users paying for {{ yandex-cloud }} resources. Even if you plan to use only free services, you still need a billing account: grants and promo codes are credited to it.

To activate a billing account, we require you to link a bank card to make sure that you are a human and not a robot. When linking the card, a small amount will be debited and immediately returned. That is how we verify that your card is real.

Payment for {{ yandex-cloud }} services and resources will be debited from your bank card only after you explicitly allow this, that is, after you switch to a paid account.

#### What happens after the trial period ends? Will you start debiting money right away?

{{ yandex-cloud }} does not debit money and does not invoice you until you have switched to a paid account. The switching to paid consumption never happens automatically.

However, if your [grant](../getting-started/usage-grant.md) has expired, access to your resources will be blocked for 60 days or until you switch to paid consumption. For more information about expiry of the trial period, see [{#T}](../getting-started/free-trial/concepts/trial-ending.md).

### Questions about the initial grant {#grant}

#### I accidentally switched to a paid account. Did I lose my initial grant? Can I get it back?

No, you cannot switch back to the trial version, but the grant will not be lost. The initial grant will be spent first. For more information about the order in which funds are spent, see [Billing cycle for individuals](../billing/payment/billing-cycle-individual.md) and [Billing cycle for businesses and individual entrepreneurs](../billing/payment/billing-cycle-business.md).

#### I have not used up the initial grant, but my cloud is blocked. What should I do?

The cloud may be blocked for a few reasons:

1. Make sure that a valid card is linked to your account. If you linked the card and then deleted it, your account may be blocked.

1. The initial grant is provisionally divided into two parts that can be used at the same time. One part covers payment for the Compute service, the other part — the rest of the {{ yandex-cloud }} services. If you run out of one part, you can continue using the cloud by switching to a paid account. The unspent part of the grant will be preserved. For more information about using the initial grant and switching to a paid period, see [{#T}](../getting-started/free-trial/concepts/upgrade-to-paid.md).

#### I could not use up the initial grant in 60 days. Can I use {{ yandex-cloud }}?

When the initial grant expires, the total unused amount is offset, and the access to your resources is suspended for 30 days. To continue using {{ yandex-cloud }}, switch to a paid plan.

### About the {#documents} documents

#### Is it safe to pay to {{ yandex-cloud }}?

The {{ yandex-cloud }} platform meets the PCI DSS requirements, which makes its cloud services safe for payment processing. For more information about PCI DSS certification, see the [{#T}](../security/conform.md#pci-dss) section.

#### Where do I find my agreement with {{ yandex-cloud }}?

{% include [contract-concept](../_includes/billing/contract.md) %}

No printed offer is provided.

No physical invoice is provided, but you can generate and print it out from the console.

#### I need a bilateral contract rather than an offer. Can I have it?

Yes, companies and individual entrepreneurs can sign a bilateral contract. To do this, submit a request using the [Message]({{ link-console-support }}) form. A {{ yandex-cloud }} manager will contact you to discuss the terms.

#### How do I get invoiced?

To get an invoice for paying at a bank office, use instructions at [{#T}](../billing/operations/pay-the-bill.md#legal-entities).

{{ yandex-cloud }} does not provide paper payment documents.

## Getting started with services {#what-is-next}

Start exploring {{ yandex-cloud }} services.

{% include [quickstart-all-no-billing](../_includes/quickstart-all-no-billing.md) %}



{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
