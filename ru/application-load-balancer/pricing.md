---
editable: false
---

# Правила тарификации для {{ alb-full-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ alb-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

## Из чего складывается стоимость использования {{ alb-name }} {#rules}

При работе с сервисом {{ alb-name }} вы платите за фактическое использование вычислительных ресурсов каждого активного балансировщика. Использование сервиса тарифицируется почасно.

{% include [lcu-calculation](../_includes/application-load-balancer/lcu-calculation.md) %}

### Пример расчета стоимости {#example}

Балансировщик, размещенный в одной зоне доступности, работал в течение часа со следующими показателями:

{% include [lcu-example](../_includes/application-load-balancer/lcu-example.md) %}

Расчет стоимости за этот час и за месяц, состоящий из 720 часов с такими же показателями: 

> RPS: 6000 / 1000 = 6
> Активные соединения: 30 000 / 4000 = 7,5 ~ 8
> Новые соединения: 500 / 200 = 2,5 ~ 3
> Трафик: 20 / 22 = 0,9090... ~ 1
> Минимальное количество ресурсных единиц в зоне: 2
>
> Количество ресурсных единиц: 8
>
> {% if region == "ru" %}8 × 2,22 = 17,76 ₽
>
> Итого за час: 17,76 ₽
> Итого за месяц: 17,76 × 720 = 12 787,20 ₽{% endif %}
> {% if region == "kz" %}8 × 11,10 = 88,80 ₸
>
> Итого за час: 88,80 ₸
> Итого за месяц: 88,80 × 720 = 63 936,00 ₸{% endif %}
> {% if region == "int" %}8 × 0,01776 = 0,14208 $
>
> Итого за час: 0,14208 $
> Итого за месяц: 0,14208 × 720 = 102,2976 ${% endif %}

Здесь {% if region == "ru" %}2,22 ₽{% endif %}{% if region == "kz" %}11,10 ₸{% endif %}{% if region == "int" %}0,01776 ${% endif %} — стоимость одной ресурсной единицы.

## Цены {#prices}

{% if region == "ru" %}

{% include [rub-lcu.md](../_pricing/application-load-balancer/rub-lcu.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-lcu.md](../_pricing/application-load-balancer/kzt-lcu.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-lcu.md](../_pricing/application-load-balancer/usd-lcu.md) %}

{% endif %}

{% endif %}
