---
title: "Правила тарификации для {{ api-gw-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ api-gw-name }}."
editable: false
---

# Правила тарификации для {{ api-gw-full-name }}



## Из чего складывается стоимость использования {{ api-gw-name }} {#rules}

В рамках сервиса {{ api-gw-name }} тарифицируется количество запросов к созданным API-шлюзам и исходящий трафик. 

{% note warning %}

{{ api-gw-name }} обрабатывает только запросы по протоколу HTTPS. Сервис автоматически перенаправляет все запросы к API-шлюзам по протоколу HTTP на их HTTPS-версии. 

{% endnote %}

### Формула расчета стоимости {#price-formula}


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  Стоимость в месяц = 120,00 ₽ × Количество миллионов запросов

- Стоимость в тенге {#prices-kzt}

  Стоимость в месяц = 600,00 ₸ × Количество миллионов запросов

{% endlist %}



{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Пример расчета стоимости API-шлюза {#price-example}

{% include [prices-example](../_includes/api-gateway/prices-example.md) %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Запросы к API-шлюзам {#request}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/api-gateway/rub.md) %}
  
  Оплачивается фактическое количество вызовов.

  > Например, 10 000 вызовов сверх нетарифицируемого объема стоит 1,20 ₽, если 1 миллион запросов стоит 120,00 ₽.

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/api-gateway/kzt.md) %}
  
  Оплачивается фактическое количество вызовов.

  > Например, 10 000 вызовов сверх нетарифицируемого объема стоит 6,00 ₸, если 1 миллион запросов стоит 600,00 ₸.

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
