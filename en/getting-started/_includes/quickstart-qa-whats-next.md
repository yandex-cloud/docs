## FAQ {#qa}

### Questions about billing accounts and paid use {#billing-account}

#### Why do I need a billing account with a linked bank card? {#linked-bank-card}

Billing accounts are used to identify users paying for {{ yandex-cloud }} resources. Even if you plan to use only free services, you still need a billing account: grants and promo codes are credited to it.

To activate a billing account, we require you to link a bank card to make sure that you are a human and not a robot. When linking the card, a small amount will be debited and immediately returned. That is how we verify that your card is real.

Payment for {{ yandex-cloud }} services and resources will be debited from your bank card only after you explicitly allow this, that is, after you switch to paid use.

#### What happens after the trial period ends? Will you start debiting money right away? {#payment-after-trial}

{{ yandex-cloud }} does not debit money and does not invoice you until you have switched to paid use. The transition to paid use never happens automatically.

However, if your [grant](../usage-grant.md) has expired, access to your resources will be blocked for 30 days or until you switch to paid use. For more information about the end of the trial period, see [{#T}](../free-trial/concepts/trial-ending.md).

To activate a billing account, we require you to link a bank card to make sure that you are a human and not a robot. When linking the card, a small amount will be debited and immediately returned. That is how we verify that your card is real.

### Questions about the initial grant {#grant}

#### I accidentally switched to paid use. Did I lose my initial grant? Can I get it back? {#accidental-switching-trial}

No, you cannot switch back to the trial version, but the grant will not be lost. The initial grant will be used up first. For more information about the spending sequence, see [Billing cycle for businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md).

#### I have not used up the initial grant, but my cloud is blocked. What should I do? {#cloud-blocked-during-trial}

The cloud may be blocked for a few reasons:

1. Make sure that a valid card is linked to your account. If you linked the card and then deleted it, your account may be blocked.

1. The initial grant is provisionally divided into two parts that can be used at the same time. One part covers payment for the Compute service, the other part — the rest of the {{ yandex-cloud }} services. If you run out of one part, you can continue using the cloud by switching to paid use. The unspent part of the grant will be preserved. For more information about using the initial grant and switching to a paid period, see [{#T}](../free-trial/concepts/upgrade-to-paid.md).

#### I could not use up the initial grant in 60 days. Can I use {{ yandex-cloud }}? {#initial-grant-expiring}

When the initial grant period ends, its unused amount expires and the access to your resources is suspended for 60 days. To continue using {{ yandex-cloud }}, switch to paid use. 

### Questions about documents {#documents}

#### Is it safe to pay to {{ yandex-cloud }}? {#payment-security}

The {{ yandex-cloud }} platform meets the PCI DSS requirements, which makes its cloud services safe for payment processing. For more information about PCI DSS certification, see [{#T}](../../security/conform.md#pci-dss).

#### Where do I find my agreement with {{ yandex-cloud }}? {#offer}

{% include [contract-concept](../../_includes/billing/contract.md) %}

There is no printed form of the offer.

The invoice is not physically provided either, but you can generate it in the console and print it out. For more information, see [{#T}](../../billing/operations/download-reporting-docs.md).

#### I need an agreement signed by both parties, not an offer. Can I get it? {#signed-agreement}

Yes, companies and individual entrepreneurs can sign a bilateral contract. To do this, submit a request using the [Message]({{ link-console-support }}) form. A {{ yandex-cloud }} manager will contact you to discuss the terms.

#### How do I get invoiced? {#invoice}

To get an invoice for a bank payment, follow the steps described in [{#T}](../../billing/operations/pay-the-bill.md#legal-entities).

{{ yandex-cloud }} does not provide paper payment documents.

## What's next? {#what-is-next}

Start exploring {{ yandex-cloud }} services.

{% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}
