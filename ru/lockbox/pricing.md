---
title: Правила тарификации для {{ lockbox-full-name }}
description: В статье содержатся правила тарификации сервиса {{ lockbox-name }}.
editable: false
---

# Правила тарификации для {{ lockbox-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


Расчет стоимости использования {{ lockbox-name }} складывается из:

* Количества версий секретов.
* Числа выполненных операций [get](api-ref/Payload/get) с секретом.

Использование секретов, созданных с помощью сервиса {{ connection-manager-name }}, не тарифицируется.


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Цена хранения секретов {#secrets}

Тарификация почасовая. Цена за месяц приводится только для справки из расчета 720 часов (30 дней) в месяце. Значение округлено. [Деактивированные](operations/secret-activation-manage.md), но не удаленные секреты тарифицируются как активные.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/lockbox/rub-secrets.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/lockbox/kzt-secrets.md) %}

{% endlist %}




### Цена запросов секретов {#requests}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/lockbox/rub-requests.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/lockbox/kzt-requests.md) %}

{% endlist %}




### Пример расчета стоимости {#price-example}

Пример расчета стоимости использования {{ lockbox-name }} в месяц для следующей конфигурации:

* количество секретов: 3, у каждого секрета 5 версий;
* количество операций `get` со всеми секретами: 20 000.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-lockbox](../_pricing_examples/lockbox/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-lockbox](../_pricing_examples/lockbox/kzt.md) %}

{% endlist %}





