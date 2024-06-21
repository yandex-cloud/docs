## FAQ {#qa}

### Questions about billing accounts and paid accounts {#billing-account}


#### What happens after the trial period ends? Will you start debiting money right away? {#payment-after-trial}

{{ yandex-cloud }} does not debit money and does not invoice you until you have switched to a paid account. The switching to paid consumption never happens automatically.

However, if your [grant](../usage-grant.md) has expired, access to your resources will be blocked for 30 days or until you switch to paid consumption. For more information about expiry of the trial period, see [{#T}](../free-trial/concepts/trial-ending.md).


### Questions about the initial grant {#grant}

#### I accidentally switched to a paid account. Did I lose my initial grant? Can I get it back? {#accidental-switching-trial}

No, you cannot switch back to the trial version, but the grant will not be lost. The initial grant will be used up first. For more information about the spending sequence, see [Billing cycle for businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md).

#### I have not used up the initial grant, but my cloud is blocked. What should I do? {#cloud-blocked-during-trial}


The initial grant is provisionally divided into two parts that can be used at the same time. One part covers payment for the Compute service, the other part — the rest of the {{ yandex-cloud }} services. If you run out of one part, you can continue using the cloud by switching to a paid account. The unspent part of the grant will be preserved. For more information about using the initial grant and switching to a paid period, see [{#T}](../free-trial/concepts/upgrade-to-paid.md).


#### I could not use up the initial grant in 60 days. Can I use {{ yandex-cloud }}? {#initial-grant-expiring}

When the initial grant expires, the total unused amount is offset, and the access to your resources is suspended for 60 days. To continue using {{ yandex-cloud }}, switch to a paid plan.

### About the documents {#documents}

#### Is it safe to pay in {{ yandex-cloud }}? {#payment-security}

The {{ yandex-cloud }} platform meets the PCI DSS requirements, which makes its cloud services safe for payment processing. For more information about PCI DSS certification, see the [{#T}](../../security/conform.md#pci-dss) section.

#### Where do I find my agreement with {{ yandex-cloud }}? {#offer}

{% include [contract-concept](../../_includes/billing/contract.md) %}

There is no print form of the offer.

The invoice is not physically provided either, but you can generate it in the console and print it out. For more information, see [{#T}](../../billing/operations/download-reporting-docs.md).

#### I need a bilateral contract rather than an offer. Can I get it? {#signed-agreement}

Yes, companies and individual entrepreneurs can sign a bilateral contract. To do this, submit a request using the [Message]({{ link-console-support }}) form. A {{ yandex-cloud }} manager will contact you to discuss the terms.

#### How do I get invoiced? {#invoice}

To get an invoice for a bank payment, follow the steps described in [{#T}](../../billing/operations/pay-the-bill.md#legal-entities).

{{ yandex-cloud }} does not provide paper payment documents.

## What's next? {#what-is-next}

Start exploring {{ yandex-cloud }} services.

{% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}
