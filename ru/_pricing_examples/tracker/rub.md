Например, в июле действовали тарифы:
 
* для первых 100 пользователей — {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|string }} за пользователя в месяц;

* для следующих 150 пользователей — {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|string }} за пользователя в месяц;

* для всех пользователей свыше 250 — {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|string }} за пользователя в месяц.

Количество сотрудников, имеющих полный доступ к {{ tracker-name }}, в июле изменялось так:

* 14 дней было 245 сотрудников.

* 7 дней — 270 сотрудников.

* остальные 10 дней — 260 сотрудников.

Максимальное количество пользователей, которые одновременно имели доступ к {{ tracker-name }} в течение месяца, равно 270.

Сумма оплаты за 270 пользователей будет рассчитана по формуле:

> 100 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|string }} + 150 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|string }} + 20 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|string }}
