---
editable: false
---

# Правила тарификации для {{ sws-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## Из чего складывается стоимость использования {{ sws-name }} {#rules}

Стоимость {{ sws-name }} зависит от количества [легитимных](concepts/rules.md#rule-action) запросов.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [sum-cloud-account](../_includes/smartwebsecurity/sum-cloud-account.md) %}

### Запросы, обработанные правилами профиля безопасности {#requests-smart}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-requests](../_pricing/smartwebsecurity/rub-requests.md) %}

  {% cut "Пример расчета стоимости запросов, обработанных правилами профиля безопасности" %}

  {% include [rub-smartwebsecurity](../_pricing_examples/smartwebsecurity/rub-smartwebsecurity.md) %}

  {% endcut %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-requests](../_pricing/smartwebsecurity/kzt-requests.md) %}

  {% cut "Пример расчета стоимости запросов, обработанных правилами профиля безопасности" %}

  {% include [kzt-smartwebsecurity](../_pricing_examples/smartwebsecurity/kzt-smartwebsecurity.md) %}

  {% endcut %}

{% endlist %}



### Запросы, обработанные правилами WAF {#requests-waf}

{% note warning %}

Цены, указанные ниже, начнут действовать с 1 октября 2024 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-requests](../_pricing/smartwebsecurity/rub-requests-waf.md) %}

  {% cut "Пример расчета стоимости запросов, обработанных правилами WAF" %}

  {% include [rub-smartwebsecurity](../_pricing_examples/smartwebsecurity/rub-smartwebsecurity-waf.md) %}

  {% endcut %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-requests](../_pricing/smartwebsecurity/kzt-requests-waf.md) %}

  {% cut "Пример расчета стоимости запросов, обработанных правилами WAF" %}

  {% include [kzt-smartwebsecurity](../_pricing_examples/smartwebsecurity/kzt-smartwebsecurity-waf.md) %}

  {% endcut %}

{% endlist %}



### Готовые расчеты стоимости запросов


Чтобы оценить порядок стоимости запросов, в таблице ниже представлены расчеты цен за определенное количество запросов в месяц. В это количество не включен нетарифицируемый лимит — 10 000 запросов.
Стоимость приведена для ориентира, использование {{ sws-name }} вашими сервисами будет рассчитываться по фактическому количеству запросов.

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/rub-smartwebsecurity-pack.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/kzt-smartwebsecurity-pack.md) %}

{% endlist %}


Чтобы дополнительно использовать защиту от DDoS-атак на уровнях 3 и 4 модели OSI, подключите [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). При этом будет взиматься оплата за [публичный IP-адрес](../vpc/pricing.md#prices-public-ip) и [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection).
