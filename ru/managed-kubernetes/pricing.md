---
title: Правила тарификации для {{ managed-k8s-full-name }}
description: В статье содержатся правила тарификации сервиса {{ managed-k8s-name }}.
editable: false
---


# Правила тарификации для {{ managed-k8s-name }}

{% include [master-pricing-note](../_includes/managed-kubernetes/master-pricing-note.md) %}

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=195a9184658e#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

В рамках сервиса {{ managed-k8s-name }} тарифицируется использование [мастера](concepts/index.md#master) и исходящий трафик.

Узлы тарифицируются по [правилам тарификации {{ compute-full-name }}](../compute/pricing.md).



## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Мастер {#master}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|mk8s }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
