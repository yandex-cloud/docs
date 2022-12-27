# Оплата банковской картой{% if product == "yandex-cloud" %} для физических лиц{% endif %}

{% if product == "yandex-cloud" %}Физические лица{% endif %}{% if product == "cloud-il" %}Пользователи {{ yandex-cloud }}{% endif %} могут{% if product == "yandex-cloud" %} пополнять лицевой счет и{% endif %} оплачивать потребленные ресурсы с помощью [банковской карты](#debit-card), привязанной к платежному аккаунту.

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

## Привязка банковской карты {#pin-card}

{% if product == "yandex-cloud" %}Физические лица{% endif %}{% if product == "cloud-il" %}Пользователи {{ yandex-cloud }}{% endif %} обязаны привязать банковскую карту к платежному аккаунту при его [создании](../quickstart/index.md).

{% include [payment-card-validation](../_includes/payment-card-validation.md) %}

{% if product == "yandex-cloud" %}

## Пополнение счета {#refill}

{% include [refill-by-card](../_includes/refill-by-card.md) %}

Дополнительную информацию см. в разделе [Цикл оплаты](../payment/billing-cycle-individual.md).

{% endif %}

## Списание средств {#write-off}

{% include [pay-by-card](../_includes/pay-by-card.md) %}

{% if product == "yandex-cloud" %}

<br/>Дополнительную информацию см. в разделе [Цикл оплаты](../payment/billing-cycle-individual.md).

{% endif %}

{% if product == "yandex-cloud" %}

## Сумма списания {#payment-amount}

{% include [payment-amount](../_includes/payment-amount.md) %}

{% endif %}