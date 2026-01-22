> (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc 400 - 15 %} × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc [currency=RUB] (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}
> Итого: {% calc [currency=RUB] (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %} — в месяц.

Где:

* 400 — новый лимит платных пользователей.
* 15 — нетарифицируемое количество пользователей.
* {{ sku|RUB|identity-hub.users.101-500|string }} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.

Текущий месяц уже оплачен, поэтому после уменьшения лимита не будет списания.

В начале каждого следующего месяца будет списываться {% calc [currency=RUB] (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.