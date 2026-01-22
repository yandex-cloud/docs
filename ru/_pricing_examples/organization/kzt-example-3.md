> (600 - 130) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc 600 - 130 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc [currency=KZT] (600 - 130) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}
> Итого: {% calc [currency=KZT] (600 - 130) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} — разовое списание.

> (600 - 15) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc 600 - 15 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc [currency=KZT] (600 - 15) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}
> Итого: {% calc [currency=KZT] (600 - 15) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} — в месяц.

Где:

* 600 — новый лимит платных пользователей.
* 130 — старый лимит платных пользователей.
* 15 — нетарифицируемое количество пользователей.
* {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} — стоимость за пользователя в месяц для количества от 501 до 1000 пользователей.

Сразу после увеличения лимита будет списано {% calc [currency=KZT] (600 - 130) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}.

В начале каждого следующего месяца будет списываться {% calc [currency=KZT] (600 - 15) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}.