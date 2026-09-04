---
title: Правила тарификации для {{ maf-full-name }}
description: В статье содержатся правила тарификации сервиса {{ maf-name }}.
editable: false
---

# Правила тарификации для {{ maf-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        gravityIcon: Calculator
        iconPosition: left
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=7530d534895e#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        gravityIcon: CircleRuble
        iconPosition: left
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2o8879r181fgps5lb3
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ maf-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы. За потребление других ресурсов {{ yandex-cloud }}, которые вы используете в процессе работы с сервисом, взимается плата в соответствии с их тарифами.


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ maf-name }} {#rules}

При работе с {{ maf-name }} вы оплачиваете:

* вычислительные ресурсы компонентов кластера;
* объем исходящего трафика.

Стоимость начисляется за каждую минуту работы кластера. Минимальная единица тарификации — минута (например, стоимость 1,5 минуты работы кластера равна стоимости 2 минут).

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



<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.apache_airflow }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

