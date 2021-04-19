---
editable: false
---

# Правила тарификации для {{  api-gw-full-name }}

## Из чего складывается стоимость использования {{ api-gw-name }} {#rules}

В рамках сервиса {{ api-gw-name }} тарифицируется количество запросов к созданным API-шлюзам и исходящий трафик. 

{% note warning %}

{{ api-gw-name }} обрабатывает только запросы по протоколу HTTPS. Сервис автоматически перенаправлячет все запросы к API-шлюзам по протоколу HTTP на их HTTPS-версии. {% if audience != "external" %} Если HTTP-клиент автоматически обрабатывает перенаправления, вместо одного запроса будет выполнено два: по HTTP и по HTTPS. {% endif %}

{% endnote %}

### Пример расчета стоимости API-шлюза {#price-example}

{% if audience != "external" %}

Например, вы создали API-шлюз, который:

* обработал 10 000 000 запросов по протоколу HTTPS (без учета перенаправлений);
* перенаправил 100 000 запросов по протоколу HTTP на их HTTPS-версии;
* обработал 80 000 перенаправленных запросов.

Стоимость работы такого API-шлюза составит: 

> 75 ₽ × (10 000 000 / 1 000 000) + 75 ₽ × (100 000 / 1 000 000) + 75 ₽ × (80 000 / 1 000 000) = 763,5 ₽

Где:
- 75 — цена за 1 миллион вызовов API-шлюза;
- 10 000 000 / 1 000 000 — количество миллионов запросов по HTTPS;
- 100 000 / 1 000 000 — количество миллионов перенаправлений с HTTP на HTTPS;
- 80 000 / 1 000 000 — количество миллионов обработанных перенаправленных запросов.

{% else %}

Например, вы создали API-шлюз, который обработал 10 000 000 запросов по протоколу HTTPS.

Стоимость работы такого API-шлюза составит: 

> 75 ₽ × (10 000 000 / 1 000 000) = 750 ₽

Где:
- 75 — цена за 1 миллион вызовов API-шлюза;
- 10 000 000 / 1 000 000 — количество миллионов запросов по HTTPS.

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
