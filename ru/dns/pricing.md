---
editable: false
---

# Правила тарификации для {{ dns-name }}

В сервисе ведется учет потребляемых ресурсов, но до **31 октября 2021** включительно потребление ресурсов {{ dns-name }} не тарифицируется. С **1 ноября 2021** потребление станет платным.

## Публичные DNS-запросы {#public-dns-requests}


{% include [rub-public-dns-requests.md](../_pricing/dns/rub-public-dns-requests.md) %}



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


{% include [rub-public-dns-zones.md](../_pricing/dns/rub-dns-zones.md) %}


