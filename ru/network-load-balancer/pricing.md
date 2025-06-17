---
title: Правила тарификации для {{ network-load-balancer-full-name }}
description: В статье содержатся правила тарификации сервиса {{ network-load-balancer-name }}.
editable: false
---

# Правила тарификации для {{ network-load-balancer-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


В рамках {{ network-load-balancer-full-name }} оплачиваются объем входящего и исходящего трафика, обработанного балансировщиком, и количество сетевых балансировщиков.

Для сетевого балансировщика с публичным IP-адресом исходящий трафик в интернете дополнительно тарифицируется аналогично другим сервисам [{{ yandex-cloud }}](../vpc/pricing.md#prices-traffic). В состав исходящего трафика также включается трафик ответов целевых ресурсов на проверки состояния.


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Входящий и исходящий трафик {#prices-traffic}

Тарифицируется трафик, поступающий на пару из IP-адреса и порта, указанную в качестве обработчика сетевого балансировщика. Остальной трафик, поступающий на балансировщик, не принимается и не тарифицируется.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/network-load-balancer/rub-traffic.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/network-load-balancer/kzt-traffic.md) %}

{% endlist %}




### Сетевые балансировщики {#network-load-balancers}

Сетевые балансировщики нагрузки тарифицируются, если у них есть обработчик и подключенная непустая целевая группа.

Если у сетевого балансировщика нет подключенных целевых групп, но есть обработчик, то публичный IP-адрес обработчика тарифицируется как [неактивный публичный IP-адрес](../vpc/pricing.md#prices-public-ip).


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/network-load-balancer/rub-balancer.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/network-load-balancer/kzt-balancer.md) %}

{% endlist %}



