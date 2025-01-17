---
title: Правила тарификации для {{ maf-full-name }}
description: В статье содержатся правила тарификации сервиса {{ maf-name }}.
editable: false
---

# Правила тарификации для {{ maf-name }}



В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ maf-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы. За потребление других ресурсов {{ yandex-cloud }}, которые вы используете в процессе работы с сервисом, взимается плата в соответствии с их тарифами.

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=6d791b1487fb#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

## Из чего складывается стоимость использования {{ maf-name }} {#rules}

При работе с {{ maf-name }} вы оплачиваете:

* вычислительные ресурсы компонентов кластера;
* объем исходящего трафика.

Стоимость начисляется за каждый час работы кластера. Минимальная единица тарификации — час (например, стоимость 1,5 часа работы кластера равна стоимости 2 часов).

Использование {{ objstorage-full-name }} для [хранения DAG-файлов](operations/upload-dags.md) оплачивается по [правилам тарификации {{ objstorage-name }}](../storage/pricing.md).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Веб-сервер**: 1 экземпляр конфигурации `standard`: 1 × 100% vCPU, 4 ГБ RAM.
* **Планировщик**: 1 экземпляр конфигурации `standard`: 1 × 100% vCPU, 4 ГБ RAM.
* **Воркеры**: 1 экземпляр конфигурации `standard`: 1 × 100% vCPU, 4 ГБ RAM.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-airflow](../_pricing_examples/managed-airflow/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-airflow](../_pricing_examples/managed-airflow/kzt.md) %}

{% endlist %}



## Цены для региона Россия {#prices}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



Все цены указаны с включением НДС.



{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы кластера {#prices-computing-resources}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-prices](../_pricing/managed-airflow/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-prices](../_pricing/managed-airflow/kzt.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
