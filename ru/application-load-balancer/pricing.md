---
title: Правила тарификации для {{ alb-full-name }}
description: В статье содержатся правила тарификации сервиса {{ alb-name }}.
editable: false
---

# Правила тарификации для {{ alb-full-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


## Из чего складывается стоимость использования {{ alb-name }} {#rules}

При работе с сервисом {{ alb-name }} вы платите за фактическое использование вычислительных ресурсов каждого активного балансировщика.

Объем использованных ресурсов определяется как количество [ресурсных единиц](concepts/application-load-balancer.md#lcu-scaling) — внутренних виртуальных машин, создаваемых для работы балансировщика в каждой его зоне доступности.

{% include [lcu-thresholds](../_includes/application-load-balancer/lcu-thresholds.md) %}

В [настройках автомасштабирования](concepts/application-load-balancer.md#lcu-scaling-settings) балансировщика можно установить ограничения на количество его ресурсных единиц. По умолчанию минимальное количество единиц в каждой зоне доступности — 2, суммарное количество во всех зонах не ограничено. Указать минимальное значение меньше 2 нельзя.

Использование балансировщика тарифицируется почасно. Плата берется за наибольшее количество ресурсных единиц, работавших в течение часа. При [создании](operations/application-load-balancer-create.md) L7-балансировщика в [консоли управления]({{ link-console-main }}) расчет стоимости отображается справа.

### Пример расчета стоимости {#example}

Балансировщик размещен в одной зоне доступности. Автомасштабирование настроено по умолчанию: минимум 2 ресурсные единицы в зоне, максимальное суммарное количество не ограничено.

Балансировщик работал в течение часа. Внешняя нагрузка на него достигала следующих максимальных показателей (возможно, разные максимумы достигались в разные моменты времени):

{% include [lcu-example](../_includes/application-load-balancer/lcu-example.md) %}

Эти показатели соответствуют **8 ресурсным единицам**:

{% include [lcu-example-amounts](../_includes/application-load-balancer/lcu-example-amounts.md) %}

Расчет стоимости за час:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-alb-hour](../_pricing_examples/application-load-balancer/rub-hour.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-alb-hour](../_pricing_examples/application-load-balancer/kzt-hour.md) %}

{% endlist %}




Расчет стоимости за месяц (30 дней) с той же почасовой нагрузкой:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-alb-month](../_pricing_examples/application-load-balancer/rub-month.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-alb-month](../_pricing_examples/application-load-balancer/kzt-month.md) %}

{% endlist %}



 


## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-lcu.md](../_pricing/application-load-balancer/rub-lcu.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kz-preview-prices.md](../_pricing/application-load-balancer/kzt-lcu.md) %}

{% endlist %}


 

