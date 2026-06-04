Стоимость обработки 100 событий (для абонентов МТС):

> {{ sku|KZT|cns.notification_events.mts_marketing_event|string }} × 100 = {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 %}

Где:

* {{ sku|KZT|cns.notification_events.mts_marketing_event|string }} — стоимость обработки одного рекламного события для абонентов МТС, до 400 000 шт.
* 100 — количество уведомлений.

Стоимость обработки 70 событий (для разных абонентов Билайн):

> {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|string }} × 70 = {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}

Где:

* {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|string }} — стоимость обработки одного рекламного события для абонентов Билайн по тарифу «до 2 событий на 1 получателя».
* 70 — количество уведомлений.

Стоимость обработки 30 событий (для одного абонента Билайн):

> * Обработка первого события — {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|string }}.
> * Обработка второго события — {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|string }}.
> * При обработке третьего события активируется пакет. Стоимость пакета «от 3 до 4 событий на 1 получателя» — {{ sku|KZT|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|string }}. Третье и четвертое события включены в пакет.
> * С пятого события тарифицируется каждое событие по цене {{ sku|KZT|cns.notification_events.vimpelcom_marketing_from_5|string }}.
> 
>   Итоговая стоимость обработки 30 событий одному абоненту:
>   {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|string }} × 2 + {{ sku|KZT|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|string }} + {{ sku|KZT|cns.notification_events.vimpelcom_marketing_from_5|string }} × 25 = {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|KZT|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|KZT|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %}

Итоговая стоимость обработки всех 200 событий отправки SMS:

> {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} + {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|KZT|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|KZT|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %} = {% calc [currency=KZT] ({{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100) + ({{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 70) + ({{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|KZT|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|KZT|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25) %}
> 
> Итого: {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 + ({{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 70) + ({{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|KZT|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|KZT|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25) %}

Где:

* {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 %} — стоимость 100 SMS для абонентов МТС.
* {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} — стоимость 70 SMS для разных абонентов Билайн.
* {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|KZT|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|KZT|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %} — стоимость 30 SMS для одного абонента Билайн.
