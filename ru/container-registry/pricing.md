---
editable: false
---

# Правила тарификации для {{ container-registry-name }}

{% if product == "cloud-il" %}

{% note info %}

Цены, указанные ниже, начнут действовать 6 декабря 2022 года. До этого использование сервиса {{ container-registry-name }} не тарифицируется

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

## Из чего складывается стоимость использования {{ container-registry-name }} {#rules}

Расчет стоимости использования {{ container-registry-name }} учитывает:
* Объем хранилища, занятый данными.
* Объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хранилища {#rules-storage}

Использование хранилища измеряется в ГБ в месяц. Объемом хранимых в течение месяца данных считается среднее значение за месяц, согласно данным, гранулированным посекундно. Минимальная единица тарификации — час хранения 1 МБ данных.

{% note warning %}

Если несколько Docker-образов в одном реестре используют одни и те же слои, хранение каждого переиспользуемого слоя повторно не тарифицируется. Уникальность слоя определяется по его [хешу](concepts/docker-image.md#version).

{% endnote %}

## Цены{% if product == "cloud-il" %} c 6 декабря 2022 года{% endif %} {#prices}

### Хранение данных {#prices-storage}

Цены за ГБ в месяц фиксированны и не зависят от количества дней в месяце. Стоимость услуги хранения в день для более коротких месяцев будет выше, для более длинных — ниже.

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub.md](../_pricing/cr/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/cr/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/cr/usd.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/cr/ils.md) %}

{% endif %}

Пример пропорционального расчета: пусть пользователь хранит 15 ГБ в течение 11 часов и 30 минут в месяце длиной 30 календарных дней. Общую цену хранения можно рассчитать по формуле:

```
Цена_хранения = Цена_за_ГБ_в_месяц * 15 * 12 / 24 / 30
```

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}