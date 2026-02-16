> (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc 130 - 15 %} × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}
> Итого: {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.

Где:

* 130 — лимит платных пользователей.
* 15 — нетарифицируемое количество пользователей.
* {{ sku|RUB|identity-hub.users.101-500|string }} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.


Сразу после увеличения лимита будет списано {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.

В начале каждого следующего месяца будет списываться так же {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.