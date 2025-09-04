Если клиент потребляет в месяц ресурсов на 500 000,00 ₸, а также у него [зарезервировано потребление ресурсов](../../billing/concepts/cvos.md) на 50 000,00 ₸ в месяц на платежном аккаунте, с которого оплачивается техническая поддержка его организации, то стоимость поддержки для него составит:

> {{ sku|KZT|support.organization.business.fixed_consumption.v1|string }} + (500 000,00 ₸ + 50 000,00 ₸) × 0,05 = {% calc [currency=KZT] {{ sku|KZT|support.organization.business.fixed_consumption.v1|number }} + (500 000,00 + 50 000,00)× 0,05 %}
>
> Итого: {% calc [currency=KZT] {{ sku|KZT|support.organization.business.fixed_consumption.v1|number }} + (500 000,00 + 50 000,00) × 0,05 %}

Где:
* {{ sku|KZT|support.organization.business.fixed_consumption.v1|string }} — фиксированная сумма в месяц.
* 27 500,00 ₸ — 5 % от стоимости платно потребленных ресурсов, находящихся в организации, в том числе зарезервированного потребления на платежном аккаунте в организации.

Эта сумма будет взиматься с одного платежного аккаунта.