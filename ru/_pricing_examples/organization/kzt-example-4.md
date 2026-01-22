> (400 - 15) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc 400 - 15 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc [currency=KZT] (400 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}
> Итого: {% calc [currency=KZT] (400 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} — в месяц.

Где:

* 400 — новый лимит платных пользователей.
* 15 — нетарифицируемое количество пользователей.
* {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.

Текущий месяц уже оплачен, поэтому после уменьшения лимита не будет списания.

В начале каждого следующего месяца будет списываться {% calc [currency=KZT] (400 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.