---
title: Правила тарификации для {{ container-registry-full-name }}
description: В статье содержатся правила тарификации сервиса {{ container-registry-name }}.
editable: false
---

# Правила тарификации для {{ container-registry-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ container-registry-name }} {#rules}

Расчет стоимости использования {{ container-registry-name }} учитывает:
* Объем хранилища, занятый данными.
* Объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хранилища {#rules-storage}

Использование хранилища измеряется в ГБ в месяц. Объемом хранимых в течение месяца данных считается среднее значение за месяц, согласно данным, гранулированным посекундно. Минимальная единица тарификации — час хранения 1 МБ данных.

{% note warning %}

Если несколько [Docker-образов](concepts/docker-image.md) в одном реестре используют одни и те же слои, хранение каждого переиспользуемого слоя повторно не тарифицируется. Уникальность слоя определяется по его [хешу](concepts/docker-image.md#version).

{% endnote %}


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Хранение данных {#prices-storage}

Цены за ГБ в месяц фиксированы и не зависят от количества дней в месяце. Стоимость услуги хранения в день для более коротких месяцев будет выше, для более длинных — ниже.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/container-registry/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/container-registry/kzt.md) %}

{% endlist %}




Пример пропорционального расчета: пусть пользователь хранит 15 ГБ в течение 11 часов и 30 минут в месяце длиной 30 календарных дней. Общую цену хранения можно рассчитать по формуле:

```text
Цена_хранения = Цена_за_ГБ_в_месяц * 15 * 12 / 24 / 30
```


### Сканер уязвимостей {#scanner}

Стоимость использования [сканера уязвимостей](concepts/vulnerability-scanner.md) для Docker-образов зависит от количества сканирований.

Первичное сканирование первых шести разных Docker-образов в месяц не тарифицируется. Последующие шесть сканирований любых Docker-образов в месяц не тарифицируется.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-scanner.md](../_pricing/container-registry/rub-scanner.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-scanner.md](../_pricing/container-registry/kzt-scanner.md) %}

{% endlist %}




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
