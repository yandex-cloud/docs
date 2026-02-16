> (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc 600 - 130 %} × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc [currency=RUB] (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}
> Итого: {% calc [currency=RUB] (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|number }} %} — разовое списание.

> (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc 600 - 15 %} × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc [currency=RUB] (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}
> Итого: {% calc [currency=RUB] (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|number }} %} — в месяц.

Где:

* 600 — новый лимит платных пользователей.
* 130 — старый лимит платных пользователей.
* 15 — нетарифицируемое количество пользователей.
* {{ sku|RUB|identity-hub.users.501-1000|string }} — стоимость за пользователя в месяц для количества от 501 до 1000 пользователей.

Сразу после увеличения лимита будет списано {% calc [currency=RUB] (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}.

В начале каждого следующего месяца будет списываться {% calc [currency=RUB] (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}.