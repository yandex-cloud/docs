# Правила тарификации для {{ cns-full-name }}



## Из чего складывается стоимость использования {{ cns-name }} {#rules}

При использовании сервиса оплачиваются услуги:

* Обработка событий отправки push-уведомлений — [мобильных](concepts/push.md) и уведомлений в [браузере](concepts/browser.md).
* Обработка запросов на регистрацию и сопровождение регистрации [индивидуальных имен отправителей](concepts/sms.md#individual-sender) для рассылки SMS у операторов Билайн, МегаФон, МТС и Т2.
* Обработка событий отправки [SMS-уведомлений](concepts/sms.md) по РФ.

{% note info %}

По умолчанию в сервисе действуют лимиты на отправку уведомлений. Подробнее см. [{#T}](concepts/limits.md). Если вы хотите отправлять больше уведомлений, обратитесь в [службу поддержки]({{ link-console-support }}).

{% endnote %}

Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.


### События отправки push-уведомлений {#push}

Push-уведомления отправляются на мобильные платформы (Google Android, Apple iOS и др.) и в браузеры по протоколу WebPush.

Мобильные и браузерные push-уведомления при тарификации суммируются.

#### Пример расчета стоимости {#push-example}

В течение месяца обработано 1500 событий отправки мобильных push-уведомлений и 700 — в браузер.

Тарификации подлежат 1500 + 700 = 2200 событий. За первые 1000 событий плата не взимается. Стоимость следующих 1200 составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > (1500 + 700 - 1000) / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|string }} = 1200 / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|string }} = {% calc [currency=RUB] (1500 + 700 - 1000) / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|number }} %}
  > 
  > Итого: {% calc [currency=RUB] (1500 + 700 - 1000) / 1000 × {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|number }} %} — стоимость отправки 2200 push-уведомлений за месяц.
  
  Где:
  
  * 1500 — мобильные push-уведомления.
  * 700 — push-уведомления в браузер.
  * 1000 — события без тарификации.
  * {{ sku|RUB|cns.notification_events.push_event.v2|pricingRate.1|string }} — стоимость обработки 1000 событий по push-уведомлениям {{ cns-short-name }}, от 1000 до 500 000 уведомлений в месяц.

- Расчет в тенге {#prices-kzt}

  > (1500 + 700 - 1000) / 1000 × {{ sku|KZT|cns.notification_events.push_event.v2|pricingRate.1|string }} = 1200 / 1000 × {{ sku|KZT|cns.notification_events.push_event.v2|pricingRate.1|string }} = {% calc [currency=KZT] (1500 + 700 - 1000) / 1000 × {{ sku|KZT|cns.notification_events.push_event.v2|pricingRate.1|number }} %}
  > 
  > Итого: {% calc [currency=KZT] (1500 + 700 - 1000) / 1000 × {{ sku|KZT|cns.notification_events.push_event.v2|pricingRate.1|number }} %} — стоимость отправки 2200 push-уведомлений за месяц.
  
  Где:
  
  * 1500 — мобильные push-уведомления.
  * 700 — push-уведомления в браузер.
  * 1000 — события без тарификации.
  * {{ sku|KZT|cns.notification_events.push_event.v2|pricingRate.1|string }} — стоимость обработки 1000 событий по push-уведомлениям {{ cns-short-name }}, от 1000 до 500 000 уведомлений в месяц.

{% endlist %}




### Регистрация индивидуальных имен отправителей {#registration}

{% note info %}

Зарегистрировать индивидуальное имя отправителя могут юридические лица или ИП.

{% endnote %}

[Индивидуальное имя отправителя](concepts/sms.md#individual-sender) позволяет обрабатывать события отправки SMS-уведомлений от имени, отличного от имени {{ yandex-cloud }} ([общий отправитель](concepts/sms.md#common-sender)). Имя регистрируется у операторов РФ: Билайн, МегаФон, МТС и T2.

Плата за регистрацию индивидуального имени отправителя взимается ежемесячно, пока имя не будет дерегистрировано по запросу клиента.

Стоимость фиксирована за месяц и не зависит от количества дней использования, обработанных уведомлений и отправленных SMS. Оплата взимается, даже если не было отправлено ни одного уведомления.


#### Пример расчета стоимости {#registration-example}

Индивидуальный отправитель для обработки событий отправки SMS был зарегистрирован 20 января, а дерегистрирован 5 марта.

Тарифицируются 3 месяца использования — январь, февраль, март.

Расчет стоимости использования зарегистрированного имени:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > {{ sku|RUB|cns.notifications.sender_name_registration_event|string }} × 3 = {% calc [currency=RUB] {{ sku|RUB|cns.notifications.sender_name_registration_event|number }} × 3 %}
  > 
  > Итого: {% calc [currency=RUB] {{ sku|RUB|cns.notifications.sender_name_registration_event|number }} × 3 %}
  
  Где:
  
  * {{ sku|RUB|cns.notifications.sender_name_registration_event|string }} — стоимость регистрации имени отправителя {{ cns-short-name }} на 1 месяц.
  * 3 — количество месяцев.

- Расчет в тенге {#prices-kzt}

  > {{ sku|KZT|cns.notifications.sender_name_registration_event|string }} × 3 = {% calc [currency=KZT] {{ sku|KZT|cns.notifications.sender_name_registration_event|number }} × 3 %}
  > 
  > Итого: {% calc [currency=KZT] {{ sku|KZT|cns.notifications.sender_name_registration_event|number }} × 3 %}
  
  Где:
  
  * {{ sku|KZT|cns.notifications.sender_name_registration_event|string }} — стоимость регистрации имени отправителя {{ cns-short-name }} на 1 месяц.
  * 3 — количество месяцев.

{% endlist %}




### События отправки SMS-уведомлений {#sms}

Сообщения можно отправлять только по РФ. Оплата взимается за каждое обработанное событие отправки сообщения. Если сообщение превышает 140 байт (70 символов кириллицей или 160 — латиницей), оно при отправке разбивается на несколько частей. Каждая из частей подлежит оплате.

Стоимость обработки события зависит от типа SMS: рекламное, авторизационное, сервисное или транзакционное. По умолчанию все SMS считаются рекламными. Чтобы событие тарифицировалось как событие другого типа, необходимо предварительно завести [шаблон](concepts/sms.md#templates) соответствующего типа.

Для некоторых операторов тарификация может выполняться пакетами. Пакеты рассчитываются индивидуально для каждого абонента, для которого получены события отправки SMS-уведомлений. Подробнее — в [примере расчета](#sms-example).

Сообщения, отправленные в песочнице (канал SMS-уведомлений находится в состоянии Sandbox), также оплачиваются в соответствии с указанными тарифами.

#### Пример расчета стоимости {#sms-example}

От общего имени отправителя обработано 100 событий отправки SMS абонентам МТС и 100 событий абонентам Билайн (из них 30 — одному абоненту, а остальные 70 — разным).

Если не были зарегистрированы шаблоны, все события считаются рекламными.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

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
  > * При обработке третьего события активируется пакет. Стоимость пакета «от 3 до 4 событий на 1 получателя» — {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|string }}. Третье и четвертое события включены в пакет.
  > * С пятого события тарифицируется каждое событие по цене {{ sku|RUB|cns.notification_events.vimpelcom_marketing_from_5|string }}.
  > 
  >   Итоговая стоимость обработки 30 событий одному абоненту:
  >   {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|string }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|string }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_from_5|string }} × 25 = {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %}
  
  Итоговая стоимость обработки всех 200 событий отправки SMS:
  
  > {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} + {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %} = {% calc [currency=RUB] ({{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100) + ({{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70) + ({{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25) %}
  > 
  > Итого: {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 + ({{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70) + ({{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25) %}
  
  Где:
  
  * {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.mts_marketing_event|number }} × 100 %} — стоимость 100 SMS для абонентов МТС.
  * {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} — стоимость 70 SMS для разных абонентов Билайн.
  * {% calc [currency=RUB] {{ sku|RUB|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|RUB|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|RUB|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %} — стоимость 30 SMS для одного абонента Билайн.

- Расчет в тенге {#prices-kzt}

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

{% endlist %}




## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Оплата взимается за отправку push-уведомлений на мобильные устройства и в браузер. Стоимость отправки SMS зависит от мобильного оператора и типа SMS.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |