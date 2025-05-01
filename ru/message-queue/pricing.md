---
title: Правила тарификации для {{ message-queue-full-name }}
description: В статье содержатся правила тарификации сервиса {{ message-queue-name }}.
editable: false
---

# Правила тарификации для {{ message-queue-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## Из чего складывается стоимость использования Message Queue {#rules}

В рамках сервиса {{ message-queue-name }} тарифицируется количество запросов к [стандартным очередям](concepts/queue.md#standard-queues) и [очередям FIFO](concepts/queue.md#fifo-queues), а также исходящий трафик.

{% include [not-charged-queue.md](../_includes/pricing/price-formula/not-charged-queue.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## Цены для региона Россия {#prices}


{% note warning %}

С 1 мая 2025 года увеличатся цены на ресурсы {{ message-queue-full-name }} в регионе Россия. Новые цены можно посмотреть на сайте:

* [Цены в рублях](https://yandex.cloud/ru/price-list?installationCode=ru&currency=RUB&services=dn2ymqni7eesvh97h5ro)
* [Цены в тенге](https://yandex.cloud/ru/price-list?installationCode=ru&currency=KZT&services=dn2ymqni7eesvh97h5ro)

{% endnote %}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Запросы к очередям {#requests-to-queues}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/message-queue/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/message-queue/kzt.md) %}

{% endlist %}



При тарификации каждые 64 КБ данных запроса считаются отдельным запросом. Например, запрос размером 63 КБ будет тарифицирован как один запрос, а 65 КБ (64 + 1) — уже как два запроса.

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
