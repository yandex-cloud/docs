Если клиент потребляет в месяц ресурсов на 120 000 ₽ (из них 20 000 ₽ тратится на ресурсы {{ marketplace-name }}), а также у него [зарезервировано потребление ресурсов](../../billing/concepts/cvos.md) на 10 000 ₽ в месяц на платежном аккаунте, с которого оплачивается техническая поддержка его организации, то стоимость поддержки для него составит:

> {{ sku|RUB|support.organization.business.fixed_consumption.v1|string }} + (120 000 ₽ - 20 000 ₽ + 10 000 ₽)× 0,05 = {% calc [currency=RUB] {{ sku|RUB|support.organization.business.fixed_consumption.v1|number }} + (100 000 + 10 000) × 0,05 %}
>
> Итого: {% calc [currency=RUB] {{ sku|RUB|support.organization.business.fixed_consumption.v1|number }} + (100 000 + 10 000) × 0,05 %}

Где:
* {{ sku|RUB|support.organization.business.fixed_consumption.v1|string }} — фиксированная сумма в месяц.
* 5 500 ₽ — 5 % от стоимости платно потребленных ресурсов, находящихся в организации, в том числе зарезервированного потребления на платежном аккаунте в организации.

Эта сумма будет взиматься с одного платежного аккаунта.