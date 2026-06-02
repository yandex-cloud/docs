Стоимость обработки 100 событий (для абонентов МТС):

> {{ sku|RUB|cns.notification_events.mts_marketing_event|string }} × 100 = {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %}

Где:

* {{ sku|RUB|cns.notification_events.mts_marketing_event|string }} — стоимость обработки одного рекламного события для абонентов МТС, до 400 000 шт.
* 100 — количество уведомлений.

Стоимость обработки 70 событий (для разных абонентов Билайн):

> {% calc [currency=RUB] 7,88 %} × 70 = {% calc [currency=RUB] 7,88 × 70 %}

Где:

* {% calc [currency=RUB] 7,88 %} — стоимость обработки одного рекламного события для абонентов Билайн по тарифу «до 2 событий на 1 получателя».
* 70 — количество уведомлений.

Стоимость обработки 30 событий (для одного абонента Билайн):

> * Обработка первого события — {% calc [currency=RUB] 7,88 %}.
> * Обработка второго события — {% calc [currency=RUB] 7,88 %}.
> * При обработке третьего события активируется пакет. Стоимость пакета «от 3 до 4 событий на 1 получателя» — {% calc [currency=RUB] 19,57 %}. Третье и четвертое события включены в пакет.
> * С пятого события тарифицируется каждое событие по цене {% calc [currency=RUB] 7,98 %}.
> 
>   Итоговая стоимость обработки 30 событий одному абоненту:
>   {% calc [currency=RUB] 7,88 %} × 2 + {% calc [currency=RUB] 19,57 %} + {% calc [currency=RUB] 7,98 %} × 25 = {% calc [currency=RUB] 7,88 × 2 + 19,57 + 7,98 × 25 %}

Итоговая стоимость обработки всех 200 событий отправки SMS:

> {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=RUB] 7,88 × 70 %} + {% calc [currency=RUB] 7,88 × 2 + 19,57 + 7,98 × 25 %} = {% calc [currency=RUB] ({{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100) + (7,88 × 70) + (7,88 × 2 + 19,57 + 7,98 × 25) %}
> 
> Итого: {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 + (7,88 × 70) + (7,88 × 2 + 19,57 + 7,98 × 25) %}

Где:

* {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %} — стоимость 100 SMS для абонентов МТС.
* {% calc [currency=RUB] 7,88 × 70 %} — стоимость 70 SMS для разных абонентов Билайн.
* {% calc [currency=RUB] 7,88 × 2 + 19,57 + 7,98 × 25 %} — стоимость 30 SMS для одного абонента Билайн.
