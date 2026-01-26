> (1500 + 700 - 1000) / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|string }} = 1200 / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|string }} = {% calc [currency=RUB] (1500 + 700 - 1000) / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|number }} %}
> 
> Итого: {% calc [currency=RUB] (1500 + 700 - 1000) / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|number }} %} — стоимость отправки 2200 push-уведомлений за месяц.

Где:

* 1500 — мобильные push-уведомления.
* 700 — push-уведомления в браузер.
* 1000 — события без тарификации.
* {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|string }} — стоимость обработки 1000 событий по push-уведомлениям {{ cns-short-name }}, от 1000 до 500 000 уведомлений в месяц.