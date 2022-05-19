## FAQ {#qa}

### Questions about billing accounts and paid accounts {#billing-account}

#### Why do I need a billing account with a linked bank card?

Billing accounts are used to identify users paying for {{ yandex-cloud }} resources. Even if you plan to use only free services, you still need a billing account: grants and promo codes are credited to it.

To activate a billing account, we require you to link a bank card to make sure that you are a human and not a robot. When linking the card, a small amount will be debited and immediately returned. That is how we verify that your card is real.

Payment for {{ yandex-cloud }} services and resources will be debited from your bank card only after you explicitly allow this, that is, after you switch to a paid account.

#### What happens after the trial period ends? Will you start debiting money right away?

{{ yandex-cloud }} doesn't debit money and doesn't invoice you until you have switched to a paid account. Switching to a paid account never happens automatically.

However, if your [grant](../usage-grant.md) has expired, access to your resources will be blocked for 30 days or until you switch to a paid account. For more information about trial period expiration, see [{#T}](../free-trial/concepts/trial-ending.md).

### Questions about the initial grant {#grant}

#### I accidentally switched to a paid account. Did I lose my initial grant? Can I get it back?

No, you can't switch back to the trial version, but the grant will not be lost. The initial grant will be spent first. For more information about the order in which funds are spent, see [{#T}](../../billing/payment/billing-cycle.md).

#### I haven't used up the entire initial grant, but my cloud is blocked. What should I do?

The cloud may be blocked for a few reasons:

1. Make sure that a valid card is linked to your account. If you linked the card and then deleted it, your account may be blocked.

1. The initial grant is provisionally divided into two parts that can be used at the same time. One part covers payment for the Compute service, the other part — the rest of the {{ yandex-cloud }} services. If you run out of one part, you can continue using the cloud by switching to a paid account. The unspent part of the grant will be preserved. For more information about using the initial grant and switching to a paid period, see [{#T}](../free-trial/concepts/upgrade-to-paid.md).

#### I couldn't use up the initial grant in 60 days. Can I use {{ yandex-cloud }}?

When the initial grant expires, the entire unspent amount is reset and access to your resources is suspended for 30 days. To continue using {{ yandex-cloud }}, switch to a paid account.

### Questions about documents {#documents}

#### Is it safe to pay {{ yandex-cloud }}?

The {{ yandex-cloud }} platform meets PCI DSS requirements, so it's safe to use cloud services for payment processing. For more information about PCI DSS certification, see [{#T}](../../security/conform.md#pci-dss).

#### Where can I find my agreement with {{ yandex-cloud }}?

{% include [contract-concept](../../_includes/billing/contract.md) %}

There is no print form of the offer.

The invoice is not physically provided either, but you can generate it in the console and print it out.

#### I need an agreement signed by both parties, not an offer. Can I get it?

Yes, businesses and individual entrepreneurs may conclude an agreement that is signed by both parties. To do this, submit a request using the [Message]({{ link-console-support }}) form. A {{ yandex-cloud }} manager will contact you to discuss the terms and conditions of signing the agreement.

#### How can I get an invoice for payment?

To get an invoice for payment in the bank, use the instructions on [{#T}](../../billing/operations/pay-the-bill.md#legal-entities).

{{ yandex-cloud }} doesn't provide paper documents for payment.

## What's next? {#what-is-next}

Start exploring {{ yandex-cloud }} services.

{% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}