# Bank card payments for individuals

{% include [individual-nonresidents](../../_includes/billing/individual-nonresidents.md) %}

Individuals can top up their personal account and pay for the resources they use with a [bank card](#debit-card) linked to their billing account.

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

## Linking a bank card {#pin-card}

When [creating](../quickstart/index.md) a billing account, you need to link a bank card.

{% include [payment-card-validation](../_includes/payment-card-validation.md) %}

You cannot unlink a bank card from an active billing account. Instead, you can [change the linked card](../operations/pin-card.md). If you delete the card linked to your {{ yandex-cloud }} billing account from [Yandex ID](https://passport.yandex.com/profile), your billing account may get locked (by changing its [status to `SUSPENDED`](../concepts/billing-account-statuses.md)) when debiting. You can [delete the card](../operations/pin-card.md#remove-card) only after you [inactivate the billing account](../operations/delete-account.md).

## Personal account top-up {#refill}

{% include [refill-by-card](../_includes/refill-by-card.md) %}

For more information, see [Billing cycle](../payment/billing-cycle-individual.md).


## Debiting funds {#write-off}

{% include [pay-by-card](../_includes/pay-by-card.md) %}


<br/>For more information, see [Billing cycle](../payment/billing-cycle-individual.md).



## Charged amount {#payment-amount}

{% include [payment-amount](../_includes/payment-amount.md) %}
