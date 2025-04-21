---
title: Правила тарификации для {{ load-testing-full-name }}
description: В статье содержатся правила тарификации сервиса {{ load-testing-name }}.
editable: false
---

# Правила тарификации для {{ load-testing-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

Плата за использование вычислительных ресурсов [агентов](concepts/agent.md) взимается по тарифам [{{ compute-full-name }}](../compute/pricing.md).

Тарификация посекундная. Цены за месяц использования формируются из расчета 720 часов в месяц.

Тесты, запущенные с нескольких агентов, тарифицируются как сумма тестов, запущенных каждым из агентов.

## Цены для региона Россия {#prices}


{% note warning %}

С 1 мая 2025 года увеличатся цены на ресурсы {{ load-testing-full-name }} в регионе Россия. Новые цены можно посмотреть на сайте:

* [Цены в рублях](https://yandex.cloud/ru/price-list?currency=RUB&installationCode=ru&services=dn2ul6hj517ba5ckvl0i)
* [Цены в тенге](https://yandex.cloud/ru/price-list?currency=KZT&installationCode=ru&services=dn2ul6hj517ba5ckvl0i)

{% endnote %}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Время выполнения тестов {#test-time}

Оплачивается продолжительность выполнения тестов.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [test-time-rub](../_pricing/load-testing/test-time-rub.md) %}

  {% include [rub-test-time](../_pricing_examples/load-testing/rub-test-time.md) %}

- Цены в тенге {#prices-kzt}

  {% include [test-time-kzt](../_pricing/load-testing/test-time-kzt.md) %}

  {% include [kzt-test-time](../_pricing_examples/load-testing/kzt-test-time.md) %}

{% endlist %}



### Хранение результатов тестов {#test-results-storage}

Оплачивается продолжительность тестов, результаты которых будут храниться.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [test-results-rub](../_pricing/load-testing/test-results-rub.md) %}

  {% include [rub-test-results](../_pricing_examples/load-testing/rub-test-results.md) %}

- Цены в тенге {#prices-kzt}

  {% include [test-results-kzt](../_pricing/load-testing/test-results-kzt.md) %}

  {% include [kzt-test-results](../_pricing_examples/load-testing/kzt-test-results.md) %}

{% endlist %}


