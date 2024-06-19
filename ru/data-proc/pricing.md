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

Информацию о тарифах за использование внешнего IP-адреса см. в разделе [{#T}](../vpc/pricing.md) документации сервиса {{ vpc-full-name }}.

### Использование дискового пространства {#rules-storage}

Объем хранилища, запрошенный для каждого из хостов кластера, тарифицируется в рамках сервиса {{ compute-name }} согласно [ценам на дисковое пространство](../compute/pricing.md#prices-storage).

### Использование сервиса {{ cloud-logging-full-name }} {#rules-logs}

Получение и хранение логов оплачивается по [правилам тарификации](../logging/pricing.md) сервиса {{ cloud-logging-full-name }}.

### Пример расчета стоимости стандартных хостов {#price-example}

Стоимость часа использования кластера из двух подкластеров со следующими параметрами:

* Первый подкластер:
  * **Хост-мастер**: класс `b2.medium`, Intel Cascade Lake, 2 × 50% vCPU, 4 ГБ RAM.
  * **Хранилище хоста-мастера**: 20 ГБ `network-ssd`.

* Второй подкластер:
  * **Хост для хранения данных**: класс `s2.micro`, Intel Cascade Lake, 2 × 100% vCPU, 8 ГБ RAM.
  * **Хранилище хоста**: 100 ГБ `network-hdd`.

Расчет стоимости:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > ({{ sku|RUB|compute.vm.cpu.50.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.cpu.c50|string }}) × 2 + ({{ sku|RUB|compute.vm.ram.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.ram|string }}) × 4 + {{ sku|RUB|nbs.network-nvme.allocated|string }} × 20 = 3,2500 ₽
  >
  > Итого: 3,2500 ₽ — стоимость часа использования первого подкластера.

  Где:

  * {{ sku|RUB|compute.vm.cpu.50.v2|string }} — стоимость часа использования 50% vCPU.
  * {{ sku|RUB|mdb.dataproc.v2.cpu.c50|string }} — наценка {{ dataproc-name }} за использование 50% vCPU.
  * 2 — количество vCPU в хосте-мастере.
  * {{ sku|RUB|compute.vm.ram.v2|string }} — стоимость часа использования 1 ГБ RAM.
  * {{ sku|RUB|mdb.dataproc.v2.ram|string }} — наценка {{ dataproc-name }} за использование 1 ГБ RAM.
  * 4 — объем RAM хоста-мастера (в гигабайтах).
  * {{ sku|RUB|nbs.network-nvme.allocated|string }} — стоимость часа использования 1 ГБ `network-ssd`.
  * 20 — объем хранилища хоста-мастера (в гигабайтах).

  > ({{ sku|RUB|compute.vm.cpu.c100.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }}) × 2 + ({{ sku|RUB|compute.vm.ram.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.ram|string }}) × 8 + {{ sku|RUB|nbs.network-hdd.allocated|string }} × 100 = 5,7500 ₽
  >
  > Итого: 5,7500 ₽ — стоимость часа использования второго подкластера.

  Где:

  * {{ sku|RUB|compute.vm.cpu.c100.v2|string }} — стоимость часа использования 100% vCPU.
  * {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }} — наценка {{ dataproc-name }} за использование 100% vCPU.
  * 2 — количество vCPU в хосте для хранения данных.
  * {{ sku|RUB|compute.vm.ram.v2|string }} — стоимость часа использования 1 ГБ RAM.
  * {{ sku|RUB|mdb.dataproc.v2.ram|string }} — наценка {{ dataproc-name }} за использование 1 ГБ RAM.
  * 8 — объем RAM хоста для хранения данных (в гигабайтах).
  * {{ sku|RUB|nbs.network-hdd.allocated|string }} — стоимость часа использования 1 ГБ `network-hdd`.
  * 100 — объем хранилища хоста для хранения данных (в гигабайтах).

  > 3,2500 ₽ + 5,7500 ₽ = 9,0000 ₽
  > 
  > Итого: 9,0000 ₽ — стоимость часа использования кластера из двух подкластеров.

  Где:

  * 3,2500 ₽ — стоимость часа использования первого подкластера.
  * 5,7500 ₽ — стоимость часа использования второго подкластера.

- Расчет в тенге {#prices-kzt}

  > ({{ sku|KZT|compute.vm.cpu.50.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.cpu.c50|string }}) × 2 + ({{ sku|KZT|compute.vm.ram.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.ram|string }}) × 4 + {{ sku|KZT|nbs.network-nvme.allocated|string }} × 20 = 16,2700 ₸
  >
  > Итого: 16,2700 ₸ — стоимость часа использования первого подкластера.

  Где:

  * {{ sku|KZT|compute.vm.cpu.50.v2|string }} — стоимость часа использования 50% vCPU.
  * {{ sku|KZT|mdb.dataproc.v2.cpu.c50|string }} — наценка {{ dataproc-name }} за использование 50% vCPU.
  * 2 — количество vCPU в хосте-мастере.
  * {{ sku|KZT|compute.vm.ram.v2|string }} — стоимость часа использования 1 ГБ RAM.
  * {{ sku|KZT|mdb.dataproc.v2.ram|string }} — наценка {{ dataproc-name }} за использование 1 ГБ RAM.
  * 4 — объем RAM хоста-мастера (в гигабайтах).
  * {{ sku|KZT|nbs.network-nvme.allocated|string }} — стоимость часа использования 1 ГБ `network-ssd`.
  * 20 — объем хранилища хоста-мастера (в гигабайтах).

  > ({{ sku|KZT|compute.vm.cpu.c100.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.cpu.c100|string }}) × 2 + ({{ sku|KZT|compute.vm.ram.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.ram|string }}) × 8 + {{ sku|KZT|nbs.network-hdd.allocated|string }} × 100 = 28,7300 ₸
  >
  > Итого: 28,7300 ₸ — стоимость часа использования второго подкластера.

  Где:

  * {{ sku|KZT|compute.vm.cpu.c100.v2|string }} — стоимость часа использования 100% vCPU.
  * {{ sku|KZT|mdb.dataproc.v2.cpu.c100|string }} — наценка {{ dataproc-name }} за использование 100% vCPU.
  * 2 — количество vCPU в хосте для хранения данных.
  * {{ sku|KZT|compute.vm.ram.v2|string }} — стоимость часа использования 1 ГБ RAM.
  * {{ sku|KZT|mdb.dataproc.v2.ram|string }} — наценка {{ dataproc-name }} за использование 1 ГБ RAM.
  * 8 — объем RAM хоста для хранения данных (в гигабайтах).
  * {{ sku|KZT|nbs.network-hdd.allocated|string }} — стоимость часа использования 1 ГБ `network-hdd`.
  * 100 — объем хранилища хоста для хранения данных (в гигабайтах).

  > 16,2700 ₸ + 28,7300 ₸ = 45,0000 ₸
  > 
  > Итого: 45,0000 ₸ — стоимость часа использования кластера из двух подкластеров.

  Где:

  * 16,2700 ₸ — стоимость часа использования первого подкластера.
  * 28,7300 ₸ — стоимость часа использования второго подкластера.

{% endlist %}



## Тарификация кластеров {{ metastore-full-name }}

Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md) и не тарифицируется.

## Цены для региона Россия {#prices} 


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Вычислительные ресурсы хостов {#prices-hosts}


#### Стандартные хосты {#standard-hosts}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-standard-hosts](../_pricing/data-proc/rub-standard-hosts.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-standard-hosts](../_pricing/data-proc/kzt-standard-hosts.md) %}

{% endlist %}

#### Выделенные хосты {#dedicated-hosts}

Цены на вычислительные ресурсы выделенных хостов представлены в [документации {{ compute-full-name }}](../compute/pricing.md#prices-dedicated-host).

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-dedicated-hosts](../_pricing/data-proc/rub-dedicated-hosts.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-dedicated-hosts](../_pricing/data-proc/kzt-dedicated-hosts.md) %}

{% endlist %}



{% note info %}

Возможность использовать [GPU](../glossary/gpu.md) на хостах {{ dataproc-name }} предоставляется по запросу в [службу технической поддержки]({{ link-console-support }}).

{% endnote %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
