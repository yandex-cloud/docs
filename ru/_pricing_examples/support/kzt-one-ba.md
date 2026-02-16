Если клиент потребляет в месяц ресурсов на 500 000,00 ₸, стоимость поддержки для него составит:

> {{ sku|KZT|support.organization.business.fixed_consumption.v1|string }} + 500 000,00 ₸ × 0,05 = {% calc [currency=KZT] {{ sku|KZT|support.organization.business.fixed_consumption.v1|number }} + 500 000,00 × 0,05 %}
>
> Итого: {% calc [currency=KZT] {{ sku|KZT|support.organization.business.fixed_consumption.v1|number }} + 500 000,00 × 0,05 %}

Где:
* {{ sku|KZT|support.organization.business.fixed_consumption.v1|string }} — фиксированная сумма в месяц.
* 25 000,00 ₸ — 5% от стоимости платно потребленных ресурсов, находящихся в организации.

Эта сумма будет взиматься с одного платежного аккаунта.