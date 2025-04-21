---
title: Правила тарификации для {{ managed-k8s-full-name }}
description: В статье содержатся правила тарификации сервиса {{ managed-k8s-name }}.
editable: false
---


# Правила тарификации для {{ managed-k8s-name }}

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=816ab5d70fb9#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.





{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

В рамках сервиса {{ managed-k8s-name }} тарифицируется использование [мастера](concepts/index.md#master) и исходящий трафик.

Узлы тарифицируются по [правилам тарификации {{ compute-full-name }}](../compute/pricing.md).



## Цены для региона Россия {#prices}


{% note warning %}

С 1 мая 2025 года увеличатся цены на ресурсы {{ managed-k8s-full-name }} в регионе Россия. Новые цены можно посмотреть на сайте:

* [Цены в рублях](https://yandex.cloud/ru/price-list?installationCode=ru&currency=RUB&services=dn2af04ph5otc5f23o1h)
* [Цены в тенге](https://yandex.cloud/ru/price-list?installationCode=ru&currency=KZT&services=dn2af04ph5otc5f23o1h)

{% endnote %}





{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



### Мастер {#master}

Цены за месяц использования формируются из расчета 720 часов в месяц.


{% note info %}

{% include [base-zonal-pricing](../_includes/managed-kubernetes/base-zonal-pricing.md) %}

{% include [ha-regional-pricing](../_includes/managed-kubernetes/ha-regional-pricing.md) %}

{% endnote %}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/managed-kubernetes/rub-master.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/managed-kubernetes/kzt-master.md) %}

{% endlist %}




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}