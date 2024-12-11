Если клиент потребляет в месяц ресурсов на 100 000,00 ₽, стоимость поддержки для него составит:

> {{ sku|RUB|support.organization.business.fixed_consumption.v1|string }} + 100 000,00 ₽ × 0,05 = {% calc [currency=RUB] {{ sku|RUB|support.organization.business.fixed_consumption.v1|number }} + 100 000,00 × 0,05 %}
>
> Итого: {% calc [currency=RUB] {{ sku|RUB|support.organization.business.fixed_consumption.v1|number }} + 100 000,00 × 0,05 %}

Где:
* {{ sku|RUB|support.organization.business.fixed_consumption.v1|string }} — фиксированная сумма в месяц.
* 5 000,00 ₽ — 5% от стоимости платно потребленных ресурсов, находящихся в организации.

Эта сумма будет взиматься с одного платежного аккаунта.