---
editable: false
---

# Правила тарификации для {{  api-gw-full-name }}

## Из чего складывается стоимость использования {{ api-gw-name }} {#rules}

В рамках сервиса {{ api-gw-name }} тарифицируется количество запросов к созданным API-шлюзам и исходящий трафик. 

{% note warning %}

{{ api-gw-name }} обрабатывает только запросы по протоколу HTTPS. Сервис автоматически перенаправляет все запросы к API-шлюзам по протоколу HTTP на их HTTPS-версии. {% if audience != "external" %} Если HTTP-клиент автоматически обрабатывает перенаправления, вместо одного запроса будет выполнено два: по HTTP и по HTTPS. {% endif %}

{% endnote %}

{% if region == "ru"%}

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

{% endif %}

{% if region == "kz" %}

### Формула расчета стоимости {#price-formula}

Стоимость в месяц = 600 ₸ × Количество миллионов запросов

{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Пример расчета стоимости API-шлюза {#price-example}

Например, вы создали API-шлюз, который обработал 10 000 000 запросов по протоколу HTTPS.

Стоимость работы такого API-шлюза составит: 

> 600 × ((10 000 000 – 100 000) / 1 000 000) = 5940 ₸

Где:
* 600 — цена за 1 миллион вызовов API-шлюза.
* 10 000 000 — количество запросов по HTTPS.
* 100 000 — вычитаем, потому что первые сто тысяч вызовов не тарифицируются.
* 1 000 000 — делим, чтобы посчитать количество миллионов запросов по HTTPS.

{% endif %}

{% if region == "int"%}

### Формула расчета стоимости {#price-formula}

Стоимость в месяц = 0,96 $ × Количество миллионов запросов

{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Пример расчета стоимости API-шлюза {#price-example}

Например, вы создали API-шлюз, который обработал 10 000 000 запросов по протоколу HTTPS.

Стоимость работы такого API-шлюза составит: 

> 0,96 × ((10 000 000 – 100 000) / 1 000 000) = 9,504 $

Где:
* 0,96 — цена за 1 миллион вызовов API-шлюза.
* 10 000 000 — количество запросов по HTTPS.
* 100 000 — вычитаем, потому что первые сто тысяч вызовов не тарифицируются.
* 1 000 000 — делим, чтобы посчитать количество миллионов запросов по HTTPS.

{% endif %}

## Цены {#prices}

### Запросы к API-шлюзам {#request}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/api-gateway/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/api-gateway/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/api-gateway/usd.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}