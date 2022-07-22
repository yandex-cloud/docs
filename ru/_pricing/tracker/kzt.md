Для крупных организаций стоимость {{ tracker-name }} [рассчитывается по ступенчатому тарифу](../../tracker/pricing#sec_calculate). Для первых 100 пользователей полный доступ к {{ tracker-name }} стоит {{ sku|KZT|b2b.tracker.license.v1|pricingRate.6|int|string }} за пользователя в месяц. Если к {{ tracker-name }} уже подключены 100 сотрудников организации, для следующих 150 пользователей цена будет ниже — {{ sku|KZT|b2b.tracker.license.v1|pricingRate.100|int|string }} за пользователя в месяц. Если подключены более 250 сотрудников, цена за каждого нового пользователя — {{ sku|KZT|b2b.tracker.license.v1|pricingRate.250|int|string }} в месяц.

| Количество пользователей <br>с полным доступом| Стоимость {{ tracker-full-name }} <br>за одного пользователя, <br>в месяц * |
| ----- | ----- |
| не более 5 | {{ sku|KZT|b2b.tracker.license.v1|int|string }} |
| 6–100 | {{ sku|KZT|b2b.tracker.license.v1|pricingRate.6|int|string }} |
| 101–250 | {{ sku|KZT|b2b.tracker.license.v1|pricingRate.100|int|string }} |
| 250+ | {{ sku|KZT|b2b.tracker.license.v1|pricingRate.250|int|string }} |

\* Цена указана с учетом НДС. При использовании промокодов могут применяться пониженные тарифы.
