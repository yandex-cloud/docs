---
editable: false
---
# Правила тарификации для {{ network-load-balancer-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ network-load-balancer-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

В рамках {{ network-load-balancer-full-name }} оплачиваются объем входящего трафика, обработанного балансировщиком, и количество сетевых балансировщиков.

Исходящий трафик тарифицируется аналогично другим сервисам {{ yandex-cloud }}, например, [Compute Cloud](../compute/pricing.md#prices-traffic). В состав исходящего трафика также включается трафик ответов целевых ресурсов на проверки состояния.

## Цены {#prices}

### Входящий и исходящий трафик {#prices-traffic}

{% if product == "yandex-cloud" %}

{% note warning %}

С 12 августа 2022 г. меняются цены на обработку трафика сетевыми балансировщиками. 

{% endnote %}

{% endif %}

Тарифицируется трафик, поступающий на пару из IP-адреса и порта, указанную в качестве обработчика сетевого балансировщика. Остальной трафик, поступающий на балансировщик, не принимается и не тарифицируется.

{% if region == "ru"%}

{% include [rub.md](../_pricing/network-load-balancer/rub-traffic.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/network-load-balancer/kzt-traffic.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/network-load-balancer/usd-traffic.md) %}

{% endif %}

### Сетевые балансировщики {#network-load-balancers}

{% if product == "yandex-cloud" %}

{% note warning %}

С 12 августа 2022 г. функциональность внутреннего балансировщика нагрузки становится [общедоступной](../overview/concepts/launch-stages.md) и начнет тарифицироваться. 

{% endnote %}

{% endif %}

Сетевые балансировщики нагрузки тарифицируются, если у них есть обработчик и подключенная непустая целевая группа.

Если у сетевого балансировщика нет подключенных целевых групп, но есть обработчик, то публичный IP-адрес обработчика тарифицируется как [неактивный публичный IP-адрес](../vpc/pricing.md#prices-public-ip).

{% if region == "ru"%}

{% include [rub.md](../_pricing/network-load-balancer/rub-balancer.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/network-load-balancer/kzt-balancer.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/network-load-balancer/usd-balancer.md) %}

{% endif %}

{% endif %}


