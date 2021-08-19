---
editable: false
---

# Правила тарификации для {{ ml-platform-name }}

## Из чего складывается стоимость использования {{ ml-platform-name }} {#rules}

При работе с сервисом {{ ml-platform-name }} вы платите за фактическое использование вычислительных ресурсов — посекундно тарифицируется время вычисления.

Если вы не выполняете вычислительные операции в проекте, время использования сервиса {{ ml-platform-name }} не тарифицируется. Но если вы производите вычисления с помощью кластеров {{ dataproc-name }}, они оплачиваются отдельно. Подробнее об этом в разделе [Использование кластеров {{ dataproc-name }}](#data-proc).

### Единица тарификации {#unit}

Единица тарификации — это один тарифицирующий юнит. Количество тарифицирующих юнитов, затраченное на вычисление, зависит от: 
* мощности используемых вычислительных ресурсов;
* времени, затраченного на вычисление.

    Время вычисления округляется до целого числа секунд в большую сторону.

Стоимость одного тарифицирующего юнита — это стоимость использования 1 ядра СPU в течение 1 секунды. Количество юнитов зависит от [конфигурации вычислительных ресурсов](concepts/configurations.md). 

Конфигурация | Количество юнитов в секунду
----- | ---- 
c1.4 | 4 
c1.8 | 8 
c1.32 | 32
c1.80 | 80 
g1.1 | 72 
g1.2 | 144
g1.4 | 288 

[Стоимость фоновых операций](#async) рассчитывается отдельно.

{% if region == "ru"%}

### Пример расчета стоимости {#price-example}

Пример расчета стоимости: 
- **Вычислительные ресурсы:** конфигурация g1.1 с 8 CPU и 1 GPU.
- **Время выполнения операций:** 1 400 мс (округляется до целого числа секунд в большую сторону).

Расчет стоимости:

> 72 × 2 = 144 юнита за вычисление
> 144 × 0,00075 = 0,108 ₽
>
> Total: 0,108 ₽

Где:
* 72 — количество юнитов за конфигурацию g1.1.
* 2 — округленные в большую сторону 1 400 мс.
* 0,00075 ₽ — стоимость 1 юнита.

{% endif %}

### Использование кластеров {{ dataproc-name }} {#data-proc}

Стоимость использования интеграции с сервисом {{ dataproc-name }} учитывает: 
* Вычислительные ресурсы конфигурации c1.4 {{ ml-platform-name }}.
    
    Эти ресурсы создаются для обеспечения интеграции с кластером {{ dataproc-name }} и тарифицируются пока на кластере идут вычисления.
* Все время существования кластера {{ dataproc-name }} по [правилам тарификации {{ dataproc-full-name }}](../data-proc/pricing.md).

Подробнее об [интеграции с {{ dataproc-name }}](concepts/data-proc.md).

### Хранение данных в проекте {#storage}

Хранение данных внутри проекта {{ ml-platform-name }} не тарифицируется в рамках установленных [квот и лимитов](concepts/limits.md).
 Если вам требуется хранить большие объемы данных, превышающие указанные лимиты, используйте сервис {{ objstorage-full-name }}. В этом случае хранение данных будет тарифицироваться по [правилам тарификации {{ objstorage-name }}](../storage/pricing.md).

{% note warning %}

С 1 сентября 2021 года изменяется стоимость использования датасетов.

{% endnote %}

{% if region == "ru"%}

{% include [rub-data-storage.md](../_pricing/datasphere/rub-data-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-data-storage.md](../_pricing/datasphere/kzt-data-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-data-storage.md](../_pricing/datasphere/usd-data-storage.md) %}

{% endif %}

## Цены {#prices}

{% if region == "ru"%}

{% include [rub-unit-and-resource.md](../_pricing/datasphere/rub-unit-and-resource.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-unit-and-resource.md](../_pricing/datasphere/kzt-unit-and-resource.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}

{% endif %}

### Выполнение фоновых операций {#async}

Подробнее про [фоновые операции](concepts/async.md).

{% if region == "ru"%}

{% include [rub-async.md](../_pricing/datasphere/rub-async.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-async.md](../_pricing/datasphere/kzt-async.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-async.md](../_pricing/datasphere/usd-async.md) %}

{% endif %}

#### Выполнение фоновых операций после 1 сентября 2021 года {#async-new}

{% note warning %}

С 1 сентября 2021 года вступают в силу новые правила тарификации фоновых операций.

{% endnote %}

Подробнее про [фоновые операции](concepts/async.md).

{% if region == "ru"%}

{% include [rub-async.md](../_pricing/datasphere/rub-async-new.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-async.md](../_pricing/datasphere/kzt-async-new.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-async.md](../_pricing/datasphere/usd-async-new.md) %}

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