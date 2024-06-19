---
title: "Правила тарификации для {{ lockbox-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ lockbox-name }}."
editable: false
---

# Правила тарификации для {{ lockbox-name }}

Расчет стоимости использования {{ lockbox-name }} складывается из:

* Количества версий секретов.
* Числа выполненных операций [get](api-ref/Payload/get) с секретом.



## Цены для региона Россия {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



### Цена хранения секретов {#secrets}


Тарификация почасовая. Цена за месяц приводится только для справки из расчета 720 часов (30 дней) в месяце. Значение округлено.



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



