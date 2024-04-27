# Оплата банковской картой для физических лиц

Физические лица могут пополнять лицевой счет и оплачивать потребленные ресурсы с помощью [банковской карты](#debit-card), привязанной к платежному аккаунту.

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

## Привязка банковской карты {#pin-card}

При [создании](../quickstart/index.md) платежного аккаунта необходимо привязать банковскую карту.

{% include [payment-card-validation](../_includes/payment-card-validation.md) %}

Отвязать карту от активного платежного аккаунта нельзя, но вместо этого вы можете [изменить привязанную карту](../operations/pin-card.md). Если вы удалите карту, привязанную к вашему платежному аккаунту {{ yandex-cloud }} из [Яндекс ID](https://passport.yandex.ru/profile), то в момент списания средств, ваш платежный аккаунт может быть заблокирован — переведен в [статус `SUSPENDED`](../concepts/billing-account-statuses.md). Вы сможете [удалить карту](../operations/pin-card.md#remove-card) только после [инактивации платежного аккаунта](../operations/delete-account.md). 

## Пополнение счета {#refill}

{% include [refill-by-card](../_includes/refill-by-card.md) %}

Дополнительную информацию см. в разделе [Цикл оплаты](../payment/billing-cycle-individual.md).


## Списание средств {#write-off}

{% include [pay-by-card](../_includes/pay-by-card.md) %}


<br/>Дополнительную информацию см. в разделе [Цикл оплаты](../payment/billing-cycle-individual.md).



## Сумма списания {#payment-amount}

{% include [payment-amount](../_includes/payment-amount.md) %}
