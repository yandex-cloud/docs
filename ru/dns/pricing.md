---
editable: false
---

# Правила тарификации для {{ dns-name }}

## Публичные DNS-запросы {#public-dns-requests}

{% if region == "ru" %}

{% include [rub-public-dns-requests.md](../_pricing/dns/rub-public-dns-requests.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-requests.md](../_pricing/dns/kzt-public-dns-requests.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}

{% endif %}

Тарифицируются: 

* Авторитетные запросы — любые запросы DNS-записей в [публичных зонах](concepts/dns-zone.md#public-zones) пользователя из интернета или из {{ yandex-cloud }}.

* Рекурсивные запросы — запросы внешних доменных имен в интернете из ВМ {{ yandex-cloud }}.

    {% note tip %}

    Рекомендуем использовать [кеширующие резолверы](tutorials/local-dns-cache.md), например, `systemd-resolved`,
    `dnsmasq`, `unbound`. С их помощью можно снизить количество запросов внешних доменных имен и тем самым уменьшить
    расходы.

    {% endnote %}

Не тарифицируются:
* Запросы из ВМ во [внутренние](concepts/dns-zone.md#private-zones) и [сервисные](concepts/dns-zone.md#service-zones) зоны.

**С 6 декабря 2021 года не тарифицируются**:
* Каждый месяц — первый миллион (1 000 000) рекурсивных запросов из ВМ. 

  После того как вы израсходуете этот нетарифицируемый объем, начнет взиматься плата в соответствии с тарифом.

  Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.
* Запросы доменных имен сервисов {{ yandex-cloud }} (например, `api.cloud.yandex.net`) и Яндекса (например, `mail.yandex.ru`) — как из ВМ, так и из интернета.

Стоимость публичных DNS-запросов рассчитывается пропорционально потреблению.

{% if region == "ru" %}

> Например, если цена за 1 млн. авторитетных запросов в месяц составляет 20 ₽, а за месяц к вашей публичной DNS-зоне 
> было сделано 50 тыс. запросов, то стоимость за месяц составит:
> (50 000 / 1 000 000) × 20 ₽ = 0,05 × 20 ₽ = 1 ₽

> Например, если цена за 1 млн. рекурсивных запросов в месяц составляет 20 ₽, а с 6 по 31 декабря 2021 с ваших ВМ было 
> сделано 1,2 млн. запросов внешних DNS-имен, то стоимость за месяц составит:
> (1,2 − 1,0) × 20 ₽ = 0,2 × 20 ₽ = 4 ₽
> т.к. первый миллион рекурсивных запросов не тарифицируется начиная с 6 декабря 2021.

{% endif %}

{% if region == "kz" %}

> Например, если цена за 1 млн. авторитетных запросов в месяц составляет 120,0000 ₸, а за месяц к вашей публичной DNS-зоне было сделано 50 тыс. запросов, то стоимость за месяц составит:
> (50 000 / 1 000 000) × 120,0000 ₸ = 0,05 × 120,0000 ₸ = 6 ₸

> Например, если цена за 1 млн. рекурсивных запросов в месяц составляет 120,0000 ₸, а с 6 по 31 декабря 2021 с ваших ВМ было сделано 1,2 млн. запросов внешних DNS-имен, то стоимость за месяц составит:
> (1,2 − 1,0) × 120,0000 ₸ = 0,2 × 120,0000 ₸ = 24 ₸
> т.к. первый миллион рекурсивных запросов не тарифицируется начиная с 6 декабря 2021.

{% endif %}

{% if region == "int" %}

> E.g. if price of 1 million authoritative requests is ₽20, and 50000 queries to your were made during this month,
> the monthly cost will be:
> (50 000 / 1 000 000) × ₽20 = 0,05 × ₽20 = ₽1

> E.g. if price of 1 million recursive requests is ₽20, and 1.2 million recursive queries were made from your VMs 
> between December 6, 2021 and December 31, 2021, the monthly cost will be:
> (1,2 − 1,0) × ₽20 = 0,2 × ₽20 = ₽4
> because first million recursive requests are provided free of charge, starting December 6, 2021.

{% endif %}

## DNS-зоны {#dns-zones}

Тарифицируются [публичные](concepts/dns-zone.md#public-zones) или [внутренние](concepts/dns-zone.md#private-zones) DNS-зоны, созданные пользователем.

[Сервисные зоны](concepts/dns-zone.md#service-zones) не тарифицируются.

Тарификация посекундная. Стоимость рассчитывается пропорционально потреблению.

> Например, стоимость владения 2 DNS-зонами в течение 360 часов будет такой же, как стоимость владения 1 DNS-зоной 
> в течение 720 часов.

{% if region == "ru" %}

{% include [rub-public-dns-zones.md](../_pricing/dns/rub-dns-zones.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-zones.md](../_pricing/dns/kzt-dns-zones.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}

{% endif %}
