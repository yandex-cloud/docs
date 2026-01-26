Стоимость обработки 100 событий (для абонентов МТС):

> {{ sku|RUB|cns.notification_events.mts_marketing_event|string }} × 100 = {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %}

Где:

* {{ sku|RUB|cns.notification_events.mts_marketing_event|string }} — стоимость обработки одного рекламного события для абонентов МТС, до 400 000 шт.
* 100 — количество уведомлений.

Стоимость обработки 70 событий (для разных абонентов Билайн):

> {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|string }} × 70 = {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}

Где:

* {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|string }} — стоимость обработки одного рекламного события для абонентов Билайн по тарифу «до 2 событий на 1 получателя».
* 70 — количество уведомлений.

Стоимость обработки 30 событий (для одного абонента Билайн):

> * Обработка первого события — {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|string }}.
> * Обработка второго события — {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|string }}.
> * При обработке третьего события активируется пакет. Стоимость пакета «от 3 до 5 событий на получателя» — {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_1|string }}. Четвертое и пятое события включены в пакет.
> * При обработке шестого события активируется пакет. Стоимость пакета «от 6 до 10 событий на получателя» — {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_2|string }}.
> * При обработке одиннадцатого события активируется пакет. Стоимость пакета «от 11 до 20 событий на получателя» — {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3|string }}.
> * С двадцать первого события тарифицируется каждое событие по цене — {{ sku|RUB|cns.notification_events.vimpelcom_marketing_2|string }}.
> 
>   Итоговая стоимость обработки 30 событий одному абоненту:
>   {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|string }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_1|string }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_2|string }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3|string }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_2|string }} × 10 = {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %}

Итоговая стоимость обработки всех 200 событий отправки SMS:

> {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} + {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %} = {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70 + ({{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_2|number }} × 10) %}
> 
> Итого: {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70 + ({{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_2|number }} × 10) %}

Где:

* {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %} — стоимость 100 SMS для абонентов МТС.
* {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} — стоимость 70 SMS для разных абонентов Билайн.
* {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %} — стоимость 30 SMS для одного абонента Билайн.
