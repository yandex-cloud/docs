---
title: Правила тарификации для {{ msp-full-name }}
description: В статье содержатся правила тарификации сервиса {{ msp-name }}.
editable: false
---

# Правила тарификации для {{ msp-name }}

{% note info %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ msp-name }} не тарифицируется.

{% endnote %}


В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ msp-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы. За потребление других ресурсов {{ yandex-cloud }}, которые вы используете в процессе работы с сервисом, взимается плата в соответствии с их тарифами.




{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}



## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

## Из чего складывается стоимость использования {{ msp-name }} {#rules}

При работе с {{ msp-name }} вы оплачиваете:

* вычислительные ресурсы компонентов кластера;
* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Стоимость начисляется за каждый час работы кластера. Минимальная единица тарификации — час (например, стоимость 1,5 часа работы кластера равна стоимости 2 часов).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Драйвер**: два экземпляра конфигурации `standard`, [класс хоста](concepts/instance-types.md) `c4-m16`, фиксированное количество: 4 vCPU, 16 ГБ RAM.
* **Исполнитель**: четыре экземпляра конфигурации `standard`, класс хоста `c4-m16`, фиксированное количество: 4 vCPU, 16 ГБ RAM.



{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-host](../_pricing_examples/managed-spark/rub-host.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-host](../_pricing_examples/managed-spark/kzt-host.md) %}

{% endlist %}





## Цены для региона Россия {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы кластера {#prices-computing-resources}

{% note info %}

Цены, указанные ниже, начнут действовать 22 сентября 2025 года.

{% endnote %}



{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts](../_pricing/managed-spark/rub-hosts.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts](../_pricing/managed-spark/kzt-hosts.md) %}

{% endlist %}





{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

