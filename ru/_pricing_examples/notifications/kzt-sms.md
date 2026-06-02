Стоимость обработки 100 событий (для абонентов МТС):

> {{ sku|KZT|cns.notification_events.mts_marketing_event|string }} × 100 = {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 %}

Где:

* {{ sku|KZT|cns.notification_events.mts_marketing_event|string }} — стоимость обработки одного рекламного события для абонентов МТС, до 400 000 шт.
* 100 — количество уведомлений.

Стоимость обработки 70 событий (для разных абонентов Билайн):

> {% calc [currency=KZT] 39,40 %} × 70 = {% calc [currency=KZT] 39,40 × 70 %}

Где:

* {% calc [currency=KZT] 39,40 %} — стоимость обработки одного рекламного события для абонентов Билайн по тарифу «до 2 событий на 1 получателя».
* 70 — количество уведомлений.

Стоимость обработки 30 событий (для одного абонента Билайн):

> * Обработка первого события — {% calc [currency=KZT] 39,40 %}.
> * Обработка второго события — {% calc [currency=KZT] 39,40 %}.
> * При обработке третьего события активируется пакет. Стоимость пакета «от 3 до 4 событий на 1 получателя» — {% calc [currency=KZT] 97,85 %}. Третье и четвертое события включены в пакет.
> * С пятого события тарифицируется каждое событие по цене {% calc [currency=KZT] 39,90 %}.
> 
>   Итоговая стоимость обработки 30 событий одному абоненту:
>   {% calc [currency=KZT] 39,40 %} × 2 + {% calc [currency=KZT] 97,85 %} + {% calc [currency=KZT] 39,90 %} × 25 = {% calc [currency=KZT] 39,40 × 2 + 97,85 + 39,90 × 25 %}

Итоговая стоимость обработки всех 200 событий отправки SMS:

> {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=KZT] 39,40 × 70 %} + {% calc [currency=KZT] 39,40 × 2 + 97,85 + 39,90 × 25 %} = {% calc [currency=KZT] ({{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100) + (39,40 × 70) + (39,40 × 2 + 97,85 + 39,90 × 25) %}
> 
> Итого: {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 + (39,40 × 70) + (39,40 × 2 + 97,85 + 39,90 × 25) %}

Где:

* {% calc [currency=KZT] {{ sku|KZT|cns.notification_events.mts_marketing_event|number }} × 100 %} — стоимость 100 SMS для абонентов МТС.
* {% calc [currency=KZT] 39,40 × 70 %} — стоимость 70 SMS для разных абонентов Билайн.
* {% calc [currency=KZT] 39,40 × 2 + 97,85 + 39,90 × 25 %} — стоимость 30 SMS для одного абонента Билайн.
