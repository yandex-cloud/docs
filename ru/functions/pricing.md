---
editable: false
---

# Правила тарификации для {{ sf-name }}

## Из чего складывается стоимость использования {{ sf-name }} {#rules}

В рамках сервиса {{ sf-name }} тарифицируется количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик. 

При тарификации вычислительных ресурсов (ГБ×час) учитывается объем памяти, выделенный для функции, и время выполнения функции:
- Объем памяти, указанный при [создании версии](operations/function/version-manage.md#func-version-create), измеряется в ГБ.
- Время выполнения для каждого вызова функции, измеряется в часах, и округляется в большую сторону до ближайшего значения, кратного 100 мс.

{% note warning %}

Тарифицируются все [вызовы функции](concepts/function-invoke.md), которые привели к запуску вашего кода.

{% endnote %}

### Пример расчета стоимости {#price-example}

Пример расчета стоимости для функции, у которой:
- **Объем памяти, указанный при создании версии:** 512 МБ.
- **Количество вызовов функции:** 10 000 000.
- **Время выполнения при каждом вызове:** 800 мс.

Расчет стоимости для функции:

> 3.42 × (512 / 1024) × (800 / 3 600 / 1 000) × 10 000 000 + 10 × (10 000 000 / 1 000 000)
>  
> Total: 3900 ₽

Где:
- 3,42 — стоимость выполнения функции ГБ×час.
- 512 / 1024  — перевод МБ в ГБ, так как время выполнения считается в ГБ×час.
- 800 / 3600 / 1000 — перевод мс в часы, так как время выполнения считается в ГБ×час.
- 10 — цена за 1 миллион вызовов функции.
- 10 000 000 / 1 000 000 — количество миллионов вызовов функции.

## Использование триггеров {#triggers}

Использование [триггеров](concepts/trigger/index.md) не тарифицируется. Вы можете создавать и использовать триггеры в рамках доступных [квот и лимитов](concepts/limits.md).

## Цены {#prices}

### Вызов функции {#invoke}

{% if region == "ru" %}

{% include [rub.md](../_pricing/functions/rub-invocations.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include [kzt.md](../_pricing/functions/kzt-invocations.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/functions/usd-invocations.md) %}

{% endif %}

Оплачивается фактическое количество вызовов. Например, стоимость тысячи вызовов составит `0,01 ₽` при цене `10 ₽` за 1 млн вызовов.

### Время выполнения функции {#execution}

{% if region == "ru" %}

{% include [rub.md](../_pricing/functions/rub-compute.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include [kzt.md](../_pricing/functions/kzt-compute.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/functions/usd-compute.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}