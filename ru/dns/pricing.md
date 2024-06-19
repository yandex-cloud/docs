---
title: "Правила тарификации для {{ dns-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ dns-name }}."
editable: false
---

# Правила тарификации для {{ dns-name }}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



## Публичные DNS-запросы {#public-dns-requests}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-public-dns-requests](../_pricing/dns/rub-public-dns-requests.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-public-dns-requests](../_pricing/dns/kzt-public-dns-requests.md) %}

{% endlist %}




Тарифицируются:
* Авторитетные запросы — любые запросы DNS-записей в [публичных зонах](concepts/dns-zone.md#public-zones) пользователя из интернета или из {{ yandex-cloud }}.
* Рекурсивные запросы — запросы внешних доменных имен в интернете из виртуальных машин {{ yandex-cloud }}.

  {% note tip %}

  Рекомендуем использовать [кеширующие резолверы](tutorials/local-dns-cache.md), например, `systemd-resolved`, `dnsmasq`, `unbound`. С их помощью можно снизить количество запросов внешних доменных имен, таким образом уменьшить расходы.

  {% endnote %}

Не тарифицируются:
* Запросы из ВМ во [внутренние](concepts/dns-zone.md#private-zones) и [сервисные](concepts/dns-zone.md#service-zones) зоны.

**С 6 декабря 2021 года не тарифицируются**:
* Каждый месяц — первый миллион (1 000 000) рекурсивных запросов из ВМ.

  После того как вы израсходуете этот нетарифицируемый объем, начнет взиматься плата в соответствии с тарифом.

  Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.
* Запросы доменных имен сервисов {{ yandex-cloud }} (например, `{{ api-host }}`)и Яндекса (например, `mail.yandex.ru`) — как из ВМ, так и из интернета.

Стоимость публичных DNS-запросов рассчитывается пропорционально потреблению.


Например, стоимость 50 тыс. авторитетных запросов к вашей публичной DNS-зоне за месяц составит:



{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-calculations](../_pricing/dns/rub-calculations.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-calculations](../_pricing/dns/kzt-calculations.md) %}

{% endlist %}



## DNS-зоны {#dns-zones}

Тарифицируются [публичные](concepts/dns-zone.md#public-zones) или [внутренние](concepts/dns-zone.md#private-zones) DNS-зоны, созданные пользователем.

[Сервисные зоны](concepts/dns-zone.md#service-zones) не тарифицируются.

Тарификация посекундная. Стоимость рассчитывается пропорционально потреблению.

> Например, стоимость владения 2 DNS-зонами в течение 360 часов будет такой же, как стоимость владения 1 DNS-зоной в течение 720 часов.


### За 1 пользовательскую зону DNS в месяц {#zone-month}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-dns-zones-month](../_pricing/dns/rub-dns-zones-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-dns-zones-month](../_pricing/dns/kzt-dns-zones-month.md) %}

{% endlist %}



### За 1 пользовательскую зону DNS в час {#zone-hour}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-dns-zones-hour](../_pricing/dns/rub-dns-zones-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-dns-zones-hour](../_pricing/dns/kzt-dns-zones-hour.md) %}

{% endlist %}




