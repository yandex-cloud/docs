---
title: "Правила тарификации для {{ api-gw-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ api-gw-name }}."
editable: false
---

# Правила тарификации для {{  api-gw-full-name }}

## Из чего складывается стоимость использования {{ api-gw-name }} {#rules}

В рамках сервиса {{ api-gw-name }} тарифицируется количество запросов к созданным API-шлюзам и исходящий трафик. 

{% note warning %}

{{ api-gw-name }} обрабатывает только запросы по протоколу HTTPS. Сервис автоматически перенаправляет все запросы к API-шлюзам по протоколу HTTP на их HTTPS-версии. 

{% endnote %}


### Формула расчета стоимости {#price-formula}

Стоимость в месяц = 120 ₽ × Количество миллионов запросов

{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Пример расчета стоимости API-шлюза {#price-example}

Например, вы создали API-шлюз, который обработал 10 000 000 запросов по протоколу HTTPS.

Стоимость работы такого API-шлюза составит: 

> 120 × ((10 000 000 – 100 000) / 1 000 000) = 1188 ₽

Где:
* 120 — цена за 1 миллион вызовов API-шлюза.
* 10 000 000 — количество запросов по HTTPS.
* 100 000 — вычитаем, потому что первые сто тысяч вызовов не тарифицируются.
* 1 000 000 — делим, чтобы посчитать количество миллионов запросов по HTTPS.




## Цены {#prices}

### Запросы к API-шлюзам {#request}


{% include notitle [rub.md](../_pricing/api-gateway/rub.md) %}




### Исходящий трафик {#prices-traffic}


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}



