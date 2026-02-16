---
title: Правила тарификации для {{ load-testing-full-name }}
description: В статье содержатся правила тарификации сервиса {{ load-testing-name }}.
editable: false
---

# Правила тарификации для {{ load-testing-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

Плата за использование вычислительных ресурсов [агентов](concepts/agent.md) взимается по тарифам [{{ compute-full-name }}](../compute/pricing.md).

Тарификация посекундная. Цены за месяц использования формируются из расчета 720 часов в месяц.

Тесты, запущенные с нескольких агентов, тарифицируются как сумма тестов, запущенных каждым из агентов.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Оплачивается:
* продолжительность выполнения тестов;
* продолжительность тестов, результаты которых будут храниться.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|load-testing }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



## Примеры расчета стоимости {#amount-example}

### Время выполнения тестов {#test-time}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-test-time](../_pricing_examples/load-testing/rub-test-time.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-test-time](../_pricing_examples/load-testing/kzt-test-time.md) %}

{% endlist %}



### Хранение результатов тестов {#test-results-storage}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-test-results](../_pricing_examples/load-testing/rub-test-results.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-test-results](../_pricing_examples/load-testing/kzt-test-results.md) %}

{% endlist %}




