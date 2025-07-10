---
title: Правила тарификации для {{ mtr-full-name }}
description: В статье содержатся правила тарификации сервиса {{ mtr-name }}.
editable: false
---

# Правила тарификации для {{ mtr-name }}



{% note info %}

Сервис находится на [стадии Preview](../overview/concepts/launch-stages.md), и его использование не тарифицируется.

{% endnote %}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mtr-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы. За потребление других ресурсов {{ yandex-cloud }}, которые вы используете в процессе работы с сервисом, взимается плата в соответствии с их тарифами.



{% include [vat](../_includes/vat.md) %}

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

## Из чего складывается стоимость использования {{ mtr-name }} {#rules}

При работе с {{ mtr-name }} вы оплачиваете:

* вычислительные ресурсы компонентов кластера;
* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Стоимость начисляется за каждый час работы кластера. Минимальная единица тарификации — час (например, стоимость 1,5 часа работы кластера равна стоимости 2 часов).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Координатор**: 1 экземпляр конфигурации `standard`: 4 × 100% vCPU, 16 ГБ RAM.
* **Воркеры**: 1 экземпляр конфигурации `standard`, фиксированное количество: 4 × 100% vCPU, 16 ГБ RAM.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-trino](../_pricing_examples/managed-trino/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-trino](../_pricing_examples/managed-trino/kzt.md) %}

{% endlist %}



## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы кластера {#prices-computing-resources}

{% note info %}

Цены, указанные ниже, начнут действовать 21 июля 2025 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-prices](../_pricing/managed-trino/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-prices](../_pricing/managed-trino/kzt.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
