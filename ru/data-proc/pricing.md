---
title: Правила тарификации для {{ dataproc-full-name }}
description: В статье содержатся правила тарификации сервиса {{ dataproc-name }}.
editable: false
---

# Правила тарификации для {{ dataproc-name }}


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

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
  * **Хост-мастер**: класс `m2.micro`, Intel Cascade Lake, 2 × 100% vCPU, 16 ГБ RAM.
  * **Хранилище хоста-мастера**: 20 ГБ `network-ssd`.

* Второй подкластер:
  * **Хост для хранения данных**: класс `s2.micro`, Intel Cascade Lake, 2 × 100% vCPU, 8 ГБ RAM.
  * **Хранилище хоста**: 100 ГБ `network-hdd`.

Расчет стоимости:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-data-proc](../_pricing_examples/data-processing/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-data-proc](../_pricing_examples/data-processing/kzt.md) %}

{% endlist %}



## Цены для региона Россия {#prices} 


{% note warning %}

С 1 мая 2025 года увеличатся цены на ресурсы {{ dataproc-full-name }} в регионе Россия. Новые цены можно посмотреть на сайте:

* [Цены в рублях](https://yandex.cloud/ru/price-list?currency=RUB&installationCode=ru&services=dn28hpu6268356q0j8mk)
* [Цены в тенге](https://yandex.cloud/ru/price-list?currency=KZT&installationCode=ru&services=dn28hpu6268356q0j8mk)

{% endnote %}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Все цены указаны с включением НДС.



{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-hosts}

#### Стандартные хосты {#standard-hosts}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-standard-hosts](../_pricing/data-processing/rub-standard-hosts.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-standard-hosts](../_pricing/data-processing/kzt-standard-hosts.md) %}

{% endlist %}



#### Выделенные хосты {#dedicated-hosts}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-dedicated-hosts](../_pricing/data-processing/rub-dedicated-hosts.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-dedicated-hosts](../_pricing/data-processing/kzt-dedicated-hosts.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
