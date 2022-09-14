---
editable: false
---

# Правила тарификации для {{ dataproc-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ dataproc-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ dataproc-name }} {#rules}

Итоговый расчет стоимости использования {{ dataproc-name }} учитывает:

* использование вычислительных ресурсов виртуальных машин {{ compute-full-name }} для развертывания хостов;
* наценку на вычислительные ресурсы за использование управляемого сервиса {{ dataproc-name }};
* использование сетевых дисков {{ compute-name }};
{% if product == "yandex-cloud" %}
* использование сервиса {{ cloud-logging-full-name }} для получения и хранения логов;
{% endif %}
* объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование вычислительных ресурсов {#rules-compute}

Стоимость начисляется за каждый час работы виртуальной машины хоста в рамках сервиса {{ compute-name }} согласно [ценам за вычислительные ресурсы {{ compute-full-name }}](../compute/pricing.md#prices), с наценкой за использование управляемого сервиса {{ dataproc-name }}.

### Использование дискового пространства {#rules-storage}

Объем хранилища, запрошенный для каждого из хостов кластера, тарифицируется в рамках сервиса {{ compute-name }} согласно [ценам на дисковое пространство](../compute/pricing.md#prices-storage).

{% if product == "yandex-cloud" %}

### Использование сервиса {{ cloud-logging-full-name }} {#rules-logs}

Получение и хранение логов оплачивается по [правилам тарификации](../logging/pricing.md) сервиса {{ cloud-logging-full-name }}.

{% endif %}

{% if product == "yandex-cloud" %}

### Пример расчета стоимости {#price-example}

{% list tabs %}

- Стандартные хосты

    Стоимость часа использования кластера из двух подкластеров со следующими параметрами:

    * Первый подкластер:
      * **Управляющий хост**: класс `b2.medium`, Intel Cascade Lake, 2 × 50% vCPU, 4 ГБ RAM.
      * **Хранилище управляющего хоста**: 20 ГБ `network-ssd`.

    * Второй подкластер:
      * **Хост для хранения данных**: класс `s2.micro`, Intel Cascade Lake, 2 × 100% vCPU, 8 ГБ RAM.
      * **Хранилище хоста**: 100 ГБ `network-hdd`.

    Расчет стоимости:

    > {% if region == "ru" %}({{ sku|RUB|compute.vm.cpu.50.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.cpu.c50|string }}) × 2 + ({{ sku|RUB|compute.vm.ram.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.ram|string }}) × 4 + {{ sku|RUB|nbs.network-nvme.allocated|string }} × 20 = 3,2500 ₽{% endif %}
    > {% if region == "int" %}({{ sku|USD|compute.vm.cpu.50.v2|string }} + {{ sku|USD|mdb.dataproc.v2.cpu.c50|string }}) × 2 + ({{ sku|USD|compute.vm.ram.v2|string }} + {{ sku|USD|mdb.dataproc.v2.ram|string }}) × 4 + {{ sku|USD|nbs.network-nvme.allocated|string }} × 20 = 0,026288 ${% endif %}
    > {% if region == "kz" %}({{ sku|KZT|compute.vm.cpu.50.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.cpu.c50|string }}) × 2 + ({{ sku|KZT|compute.vm.ram.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.ram|string }}) × 4 + {{ sku|KZT|nbs.network-nvme.allocated|string }} × 20 = 16,2700 ₸{% endif %}
    >
    > Итого: {% if region == "ru" %}3,2500 ₽{% endif %}{% if region == "int" %}0,026288 ${% endif %}{% if region == "kz" %}16,2700 ₸{% endif %} — стоимость часа использования первого подкластера.

    Где:

    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|compute.vm.cpu.50.v2|string }} — стоимость часа использования 50% vCPU.
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|mdb.dataproc.v2.cpu.c50|string }} — наценка {{ dataproc-name }} за использование 50% vCPU.
    * 2 — количество vCPU в управляющем хосте.
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|compute.vm.ram.v2|string }} — стоимость часа использования 1 ГБ RAM.
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|mdb.dataproc.v2.ram|string }} — наценка {{ dataproc-name }} за использование 1 ГБ RAM.
    * 4 — объем RAM управляющего хоста (в гигабайтах).
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|nbs.network-nvme.allocated|string }} — стоимость часа использования 1 ГБ `network-ssd`.
    * 20 — объем хранилища управляющего хоста (в гигабайтах).

    > {% if region == "ru" %}({{ sku|RUB|compute.vm.cpu.c100.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }}) × 2 + ({{ sku|RUB|compute.vm.ram.v2|string }} + {{ sku|RUB|mdb.dataproc.v2.ram|string }}) × 8 + {{ sku|RUB|nbs.network-hdd.allocated|string }} × 100 = 5,7500 ₽{% endif %}
    > {% if region == "int" %}({{ sku|USD|compute.vm.cpu.c100.v2|string }} + {{ sku|USD|mdb.dataproc.v2.cpu.c100|string }}) × 2 + ({{ sku|USD|compute.vm.ram.v2|string }} + {{ sku|USD|mdb.dataproc.v2.ram|string }}) × 8 + {{ sku|USD|nbs.network-hdd.allocated|string }} × 100 = 0,046694 ${% endif %}
    > {% if region == "kz" %}({{ sku|KZT|compute.vm.cpu.c100.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.cpu.c100|string }}) × 2 + ({{ sku|KZT|compute.vm.ram.v2|string }} + {{ sku|KZT|mdb.dataproc.v2.ram|string }}) × 8 + {{ sku|KZT|nbs.network-hdd.allocated|string }} × 100 = 28,7300 ₸{% endif %}
    >
    > Итого: {% if region == "ru" %}5,7500 ₽{% endif %}{% if region == "int" %}0,046694 ${% endif %}{% if region == "kz" %}28,7300 ₸{% endif %} — стоимость часа использования второго подкластера.

    Где:

    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|compute.vm.cpu.c100.v2|string }} — стоимость часа использования 100% vCPU.
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|mdb.dataproc.v2.cpu.c100|string }} — наценка {{ dataproc-name }} за использование 100% vCPU.
    * 2 — количество vCPU в хосте для хранения данных.
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|compute.vm.ram.v2|string }} — стоимость часа использования 1 ГБ RAM.
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|mdb.dataproc.v2.ram|string }} — наценка {{ dataproc-name }} за использование 1 ГБ RAM.
    * 8 — объем RAM хоста для хранения данных (в гигабайтах).
    * {{ sku|{% if region == "ru" %}RUB{% endif %}{% if region == "int" %}USD{% endif %}{% if region == "kz" %}KZT{% endif %}|nbs.network-hdd.allocated|string }} — стоимость часа использования 1 ГБ `network-hdd`.
    * 100 — объем хранилища хоста для хранения данных (в гигабайтах).

    > {% if region == "ru" %}3,2500 ₽ + 5,7500 ₽ = 9,0000 ₽{% endif %}
    > {% if region == "int" %}0,026288 $ + 0,046694 $ = 0,072982 ${% endif %}
    > {% if region == "kz" %}16,2700 ₸ + 28,7300 ₸ = 45,0000 ₸{% endif %}
    > 
    > Итого: {% if region == "ru" %}9,0000 ₽{% endif %}{% if region == "int" %}0,072982 ${% endif %}{% if region == "kz" %}45,0000 ₸{% endif %} — стоимость часа использования кластера из двух подкластеров.

    Где:

    * 3,2500 ₽ — стоимость часа использования первого подкластера.
    * 5,7500 ₽ — стоимость часа использования второго подкластера.

{% endlist %}

{% endif %}

## Цены {#prices}

### Вычислительные ресурсы хостов {#prices-hosts}

{% if region == "ru" %}

{% include [rub.md](../_pricing/data-proc/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/data-proc/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/data-proc/usd.md) %}

{% endif %}

{% note info %}

Возможность использовать GPU на хостах {{ dataproc-name }} предоставляется по запросу в [службу технической поддержки]({{ link-console-support }}).

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

{% endif %}
