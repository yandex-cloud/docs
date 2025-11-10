---
title: Правила тарификации для {{ cns-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cns-name }}.
editable: false
---

# Правила тарификации для {{ cns-full-name }}



{% note warning %}

Цены на ресурсы {{ cns-name }} действуют с 20 ноября 2025 года.

{% endnote %}


## Из чего складывается стоимость использования {{ cns-name }} {#rules}

При использовании сервиса оплачиваются услуги:

* Обработка событий отправки push-уведомлений — мобильных push-уведомлений и push-уведомлений в браузере.
* Обработка запросов, передача оператору для регистрации индивидуальных имен отправителей для отправки SMS — ежемесячная плата за регистрацию и использование индивидуальных имен отправителей у четырех операторов: Билайн, МегаФон, МТС и T2.
* Обработка событий отправки SMS-уведомлений по РФ.

{% note info %}

По умолчанию в сервисе действуют лимиты на отправку уведомлений. Подробнее см. [{#T}](concepts/limits.md).

{% endnote %}

{% include [vat](../_includes/vat.md) %}


### События отправки push-уведомлений {#push}

Push-уведомления отправляются на мобильные платформы (Google Android, Apple iOS и др.) и в браузеры по протоколу WebPush. Оплата производится за каждые 1000 обработанных событий отправки уведомлений.

Отправка мобильных push-уведомлений и уведомлений в браузеры суммируется при тарификации.


#### Пример расчета стоимости {#push-example}

В течение месяца получено 1500 событий отправки мобильных push-уведомлений и 700 push-уведомлений в браузер.

Тарификации подлежат 2200 событий. За первые 1000 событий плата не взимается. Стоимость следующих 1200 составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-push](../_pricing_examples/notifications/rub-push.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-push](../_pricing_examples/notifications/kzt-push.md) %}

{% endlist %}




### Регистрация индивидуальных имен отправителей {#registration}

Индивидуальное имя отправителя позволяет обрабатывать события доставки SMS-уведомлений от имени, отличного от имени {{ yandex-cloud }}. Имя регистрируется у следующих операторов (в РФ): Билайн, МегаФон, МТС и T2.

Плата за регистрацию индивидуального имени отправителя взимается ежемесячно, пока имя не будет дерегистрировано по запросу клиента.

Стоимость не зависит от того, сколько дней в месяце имя было зарегистрировано. Также стоимость не зависит от количества обработанных уведомлений и отправленных SMS от этого имени и взимается, даже если не было отправлено ни одного уведомления.


#### Пример расчета стоимости {#registration-example}

Индивидуальный отправитель для обработки событий отправки SMS был зарегистрирован 20 января, а дерегистрирован — 5 марта.

Тарифицируются 3 месяца использования этого отправителя — январь, февраль, март.

Расчет стоимости использования зарегистрированного имени:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-registration](../_pricing_examples/notifications/rub-registration.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-registration](../_pricing_examples/notifications/kzt-registration.md) %}

{% endlist %}




### События отправки SMS-уведомлений {#sms}

Сообщения можно отправлять только по РФ. Оплата производится за каждое отправленное событие (сообщение). Если сообщение превышает 140 байт (70 символов кириллицей или 160 — латиницей), оно при отправке разбивается на несколько частей. Каждая из частей подлежит оплате.

Стоимость обработки события для отправки сообщения зависит от его типа (рекламное, авторизационное, сервисное или транзакционное). По умолчанию все обрабатываемые события (сообщения) считаются рекламными. Чтобы событие тарифицировалось как событие другого типа, необходимо предварительно завести шаблон. На данный момент для регистрации шаблона нужно отправить в [службу поддержки]({{ link-console-support }}) примеры шаблонизированных сообщений, чтобы определить возможность шаблонизации и дальнейшей регистрации шаблона.

Для обработки событий отправки SMS абонентам некоторых операторов тарификация может быть реализована пакетами. Пакеты рассчитываются индивидуально для каждого абонента, для которого получено событие отправки SMS-уведомлений. Подробнее — в [примере расчета](#sms-example).

Уведомления, отправленные в песочнице (когда канал SMS-уведомлений находится в состоянии Sandbox), тарифицируются в соответствии с ценами на сервис.


#### Пример расчета стоимости {#sms-example}

От общего имени отправителя было 100 событий отправки SMS абонентам МТС и 100 событий абонентам Билайн (из них 30 штук одному и тому же абоненту, а остальные 70 разным абонентам).

Если не были зарегистрированы шаблоны, все события считаются рекламными.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-sms](../_pricing_examples/notifications/rub-sms.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-sms](../_pricing_examples/notifications/kzt-sms.md) %}

{% endlist %}




## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Тарификация push-уведомлений {#prices-push}

Оплата взимается за отправку push-уведомлений на мобильные устройства и в браузер.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-push](../_pricing/notifications/rub-push.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-push](../_pricing/notifications/kzt-push.md) %}

{% endlist %}




### Тарификация регистрации индивидуальных имен отправителей {#prices-registration}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-registration](../_pricing/notifications/rub-registration.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-registration](../_pricing/notifications/kzt-registration.md) %}

{% endlist %}




### Тарификация SMS-уведомлений {#prices-sms}

Стоимость отправки SMS зависит от мобильного оператора и типа SMS.


#### Билайн {#sms-beeline}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-sms-beeline](../_pricing/notifications/rub-sms-beeline.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-sms-beeline](../_pricing/notifications/kzt-sms-beeline.md) %}

{% endlist %}




#### МегаФон {#sms-megafon}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-sms-megafon](../_pricing/notifications/rub-sms-megafon.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-sms-megafon](../_pricing/notifications/kzt-sms-megafon.md) %}

{% endlist %}




#### МТС {#sms-mts}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-sms-mts](../_pricing/notifications/rub-sms-mts.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-sms-mts](../_pricing/notifications/kzt-sms-mts.md) %}

{% endlist %}



#### Т2 {#sms-tele2}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-sms-tele2](../_pricing/notifications/rub-sms-tele2.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-sms-tele2](../_pricing/notifications/kzt-sms-tele2.md) %}

{% endlist %}




#### Другие операторы {#sms-others}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-sms-others](../_pricing/notifications/rub-sms-others.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-sms-others](../_pricing/notifications/kzt-sms-others.md) %}

{% endlist %}



{% note info %}

Если вы хотите отправлять больше уведомлений, обратитесь в [службу поддержки]({{ link-console-support }}).

{% endnote %}

