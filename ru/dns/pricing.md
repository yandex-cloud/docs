---
editable: false
---

# Правила тарификации для {{ dns-name }}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ dns-name }} не тарифицируется. 

После перехода сервиса в общий доступ начнется учет потребляемых ресурсов, но до **31 октября 2021** включительно потребление ресурсов {{ dns-name }} не будет тарифицироваться. С **1 ноября 2021** потребление станет платным.

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

* Любые запросы имен ВМ в [публичных зонах](concepts/dns-zone.md#public-zones) пользователя из интернета или из {{ yandex-cloud }}.
* Запросы внешних имен в интернете из ВМ {{ yandex-cloud }}. 

Запросы во [внутренние](concepts/dns-zone.md#private-zones) и [сервисные](concepts/dns-zone.md#service-zones) зоны не тарифицируются.

Цена рассчитывается пропорционально потреблению.

> Например, если за месяц было сделано 200 000 запросов (0,2 миллиона), то стоимость составит:
> 0,2 * 20 ₽ = 4 ₽

## DNS-зоны {#dns-zones}

Тарифицируются любые публичные или внутренние DNS-зоны, созданные пользователем. 

[Сервисные зоны](concepts/dns-zone.md#service-zones) не тарифицируются.

{% if region == "ru" %}

{% include [rub-public-dns-zones.md](../_pricing/dns/rub-dns-zones.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-zones.md](../_pricing/dns/kzt-dns-zones.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}

{% endif %}
