> (130 - 15) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc 130 - 15 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}
> Итого: {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.

Где:

* 130 — лимит платных пользователей.
* 15 — нетарифицируемое количество пользователей.
* {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.


Сразу после увеличения лимита будет списано {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.

В начале каждого следующего месяца будет списываться так же {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.