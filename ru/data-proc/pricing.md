---
editable: false
---

# Правила тарификации для {{ dataproc-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ dataproc-name }} {#rules}

Итоговый расчет стоимости использования {{ dataproc-name }} учитывает:

* использование вычислительных ресурсов виртуальных машин {{ compute-full-name }} для развертывания хостов;
* наценку на вычислительные ресурсы за использование управляемого сервиса {{ dataproc-name }};
* использование сетевых дисков {{ compute-name }};
* объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование вычислительных ресурсов {#rules-compute}

Стоимость начисляется за каждый час работы виртуальной машины хоста в рамках сервиса {{ compute-name }} согласно [ценам за вычислительные ресурсы {{ compute-name }}](../compute/pricing.md#prices), с наценкой за использование управляемого сервиса {{ dataproc-name }}.

### Использование дискового пространства {#rules-storage}

Объем хранилища, запрошенный для каждого из хостов кластера, тарифицируется в рамках сервиса {{ compute-name }} согласно [ценам на дисковое пространство](../compute/pricing.md#prices-storage).

### Пример вычисления цены {#price-calculation-example}

Вы создаете кластер с одним Data-подкластером. Хост-мастер — `s2.micro` (2 vCPU, 8 ГБ RAM) с хранилищем 15 ГБ SSD, в подкластере один хост — `s2.small` (4 vCPU, 16 ГБ RAM), с хранилищем 100 ГБ HDD. 

Цены на использование ресурсов:

* использование одного ядра прерываемой ВМ на платформе Intel Cascade Lake с 100% vCPU — 0,2040 ₽ в час;
* использование 1 ГБ RAM прерываемой ВМ на платформе Intel Cascade Lake — 0,0492 ₽ в час;
* использование 1 ГБ памяти диска SSD — 7,4441 ₽ в месяц;
* использование 1 ГБ памяти диска HDD — 2,0847 ₽ в месяц.

В таком случае цена часа использования кластера будет складываться следующим образом:

* (2 + 4) × 0,2040 ₽ + (8 + 16) × 0,0492 ₽ = 2,4048 ₽ (за вычислительные ресурсы {{ compute-name }});
* 2,4048 ₽ × 0.1 = 0,2405 ₽ (наценка за использование {{ dataproc-name }});
* (15 × 7,4441 ₽ + 100 × 2,0847 ₽) / 30 / 24 = 0.4447 ₽ (за использование дисков {{ compute-name }}).

Суммарная цена за час: 2,4048 ₽ + 0,2405 ₽ + 0,4447 ₽ = 3,09 ₽


## Цены {#prices}

### Вычислительные ресурсы с наценкой {{ dataproc-name }} {#prices-compute}

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-proc/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-proc/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-proc/usd.md) %}

{% endif %}

{% note info %}

Возможность использовать GPU на хостах {{ dataproc-name }} предоставляется по запросу в [службу технической поддержки](https://console.cloud.yandex.ru/support).

{% endnote %}


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
