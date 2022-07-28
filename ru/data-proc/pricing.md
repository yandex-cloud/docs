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
* использование сервиса {{ cloud-logging-full-name }} для получения и хранения логов;
* объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование вычислительных ресурсов {#rules-compute}

Стоимость начисляется за каждый час работы виртуальной машины хоста в рамках сервиса {{ compute-name }} согласно [ценам за вычислительные ресурсы {{ compute-full-name }}](../compute/pricing.md#prices), с наценкой за использование управляемого сервиса {{ dataproc-name }}.

### Использование дискового пространства {#rules-storage}

Объем хранилища, запрошенный для каждого из хостов кластера, тарифицируется в рамках сервиса {{ compute-name }} согласно [ценам на дисковое пространство](../compute/pricing.md#prices-storage).


### Использование сервиса {{ cloud-logging-full-name }} {#rules-logs}

Получение и хранение логов оплачивается по [правилам тарификации](../logging/pricing.md) сервиса {{ cloud-logging-full-name }}.




### Пример вычисления цены {#price-calculation-example}

{% list tabs %}

- Стандартные хосты

    Вы создаете кластер с подкластером с управляющим хостом — `b2.medium` (2 vCPU, 50%, 4 ГБ RAM) с хранилищем 20 ГБ `network-ssd`, и одним подкластером для хранения данных из одного хоста — `s2.micro` (2 vCPU, 100%, 8 ГБ RAM), с хранилищем 100 ГБ `network-hdd`.

    В таком случае цена часа использования кластера будет складываться следующим образом:

    | Ресурс {{ compute-name }}                  | Стоимость                                       | Наценка {{ dataproc-name }}                   | Количество | Итого    |
    |--------------------------------------------|------------------------------------------------:|----------------------------------------------:|-----------:|---------:|
    | **Вычислительные ресурсы на платформе Intel Cascade Lake**                                                                                                           |
    | 1 ядро vCPU с гарантированной долей 50%    | {{ sku|RUB|compute.vm.cpu.50.v2|string }}       | {{ sku|RUB|mdb.dataproc.v2.cpu.c50|string }}  |          2 | 1,5600 ₽ |
    | 1 ядро vCPU с гарантированной долей 100%   | {{ sku|RUB|compute.vm.cpu.c100.v2|string }}     | {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }} |          2 | 2,6200 ₽ |
    | 1 ГБ RAM                                   | {{ sku|RUB|compute.vm.ram.v2|string }}          | {{ sku|RUB|mdb.dataproc.v2.ram|string }}      | 4 + 8 = 12 | 4,0800 ₽ |
    | **Диски Compute Cloud**                                                                                                                                              |
    | 1 ГБ хранилища на быстрых дисках (SSD)     | {{ sku|RUB|nbs.network-nvme.allocated|string }} |                                             — |         20 | 0,3300 ₽ |
    | 1 ГБ хранилища на стандартных дисках (HDD) | {{ sku|RUB|nbs.network-hdd.allocated|string }}  |                                             — |        100 | 0,4100 ₽ |
    | **Итого**                                  |                                                 |                                               |            | 9,0000 ₽ |

    Таким образом, суммарная цена за час составит 9,0000 ₽.

{% endlist %}



## Цены {#prices}

### Вычислительные ресурсы хостов {#prices-hosts}


{% include [rub.md](../_pricing/data-proc/rub.md) %}




{% note info %}

Возможность использовать GPU на хостах {{ dataproc-name }} предоставляется по запросу в [службу технической поддержки]({{ link-console-support }}).

{% endnote %}

### Исходящий трафик {#prices-traffic}


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}



