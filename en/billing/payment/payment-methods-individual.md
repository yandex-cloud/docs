# Bank card payments{% if product == "yandex-cloud" %} for individuals{% endif %}

{% if product == "yandex-cloud" %}Individuals{% endif %}{% if product == "cloud-il" %}{{ yandex-cloud }} clients{% endif %} can{% if product == "yandex-cloud" %} top up their personal account and{% endif %} pay for the resources they use with a [bank card](#debit-card) linked to their billing account.

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

## Linking a bank card {#pin-card}

{% if product == "yandex-cloud" %}Individuals{% endif %}{% if product == "cloud-il" %}{{ yandex-cloud }} clients{% endif %} are required to link a bank card to their billing account when [creating](../quickstart/index.md) it.

{% include [payment-card-validation](../_includes/payment-card-validation.md) %}

{% if product == "yandex-cloud" %}

## Personal account top-up {#refill}

{% include [refill-by-card](../_includes/refill-by-card.md) %}

For more information, see [Billing cycle](../payment/billing-cycle-individual.md).

{% endif %}

## Debiting funds {#write-off}

{% include [pay-by-card](../_includes/pay-by-card.md) %}

{% if product == "yandex-cloud" %}

<br/>For more information, see [Billing cycle](../payment/billing-cycle-individual.md).

{% endif %}

{% if product == "yandex-cloud" %}

## Charged amount {#payment-amount}

{% include [payment-amount](../_includes/payment-amount.md) %}

{% endif %}