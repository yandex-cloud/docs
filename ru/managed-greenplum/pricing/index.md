---
title: Правила тарификации для {{ mgp-full-name }}
description: В статье содержатся правила тарификации сервиса {{ mgp-name }}.
editable: false
---

# Правила тарификации для {{ mgp-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mgp-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.


{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=c55f805e6ef5#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}



{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}


{% include [pricing-status](../../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning](../../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mgp-short-name }} {#rules}

Расчет стоимости использования {{ mgp-name }} учитывает:

* тип диска и размер хранилища;
* вычислительные ресурсы, выделенные хостам кластера, и тип хостов;
* настройки и количество резервных копий;
* объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Использование хостов кластера {#rules-hosts-uptime}


В зависимости от [типа хоста](../concepts/) стоимость вычисляется по-разному:

* Стандартные хосты

  Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.

* Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../../compute/pricing.md#prices) и наценки {{ mgp-name }} на эти ресурсы.



Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](../concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ GP }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров.

  
  * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с двумя хостами-мастерами:

    * для платформы Intel Cascade Lake — с шагом 100 ГБ;
    * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.



  * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с двумя хостами-мастерами, с шагом 93 ГБ.

  Чтобы сэкономить, вы можете [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-full-name }}. Данные будут храниться в служебном бакете в сжатом и зашифрованном виде, так хранить данные дешевле. Стоимость хранения рассчитывается по [правилам тарификации {{ objstorage-name }}](../../storage/pricing.md).

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

  * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

  * При автоматическом резервном копировании {{ mgp-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

  * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:


* **Стандартные хосты**: 3 хоста класса `s3-c8-m32`: Intel Ice Lake, 8 × 100% vCPU, 32 ГБ RAM.
* **Хранилище для стандартных хостов**: 100 ГБ на сетевых HDD-дисках.
* **Выделенные хосты**: 3 хоста класса `s2.medium`: Intel Cascade Lake, 8 × 100% vCPU, 32 ГБ RAM.
* **Хранилище для выделенных хостов**: 50 ГБ на локальных SSD-дисках.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-managed-greenplum-standard](../../_pricing_examples/managed-greenplum/rub-managed-greenplum.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-managed-greenplum-standard](../../_pricing_examples/managed-greenplum/kzt-managed-greenplum.md) %}

{% endlist %}






## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

Сервис {{ mgp-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика, а также вычислительные ресурсы выделенных хостов заказать таким образом пока невозможно.

{% endnote %}

## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}



Все цены указаны с включением НДС.



Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

От типа хостов также зависит цена на хранилище на локальных SSD-дисках (`local-ssd`).


{% include [pricing-month-term](../../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-hosts}


#### Стандартные хосты {#standard-hosts}

{% include [Доступ к Compute Optimized по запросу](../../_includes/mdb/note-compute-optimized-request.md) %}

Стоимость вычисляется по-разному в зависимости от [конфигурации хостов](../concepts/instance-types.md):

* Для хостов i2 и i3 (`io-optimized`) стоимость складывается из цены за вычислительные ресурсы хостов {{ mgp-name }} (см. таблицу ниже) и [цены за использование программно-ускоренной сети](../../compute/pricing.md#software-accelerated-network).
* Для хостов других конфигураций оплачиваются только их вычислительные ресурсы:


**Цены в час**


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-standard-hour](../../_pricing/managed-greenplum/rub-hosts-standard-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-standard-hour](../../_pricing/managed-greenplum/kzt-hosts-standard-hour.md) %}

{% endlist %}




**Цены в месяц**


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-standard-month](../../_pricing/managed-greenplum/rub-hosts-standard-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-standard-month](../../_pricing/managed-greenplum/kzt-hosts-standard-month.md) %}

{% endlist %}





#### Выделенные хосты {#dedicated-hosts}

{% include [Доступ к Compute Optimized по запросу](../../_includes/mdb/note-compute-optimized-request.md) %}

Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../../compute/pricing.md#prices) и наценки {{ mgp-name }} на эти ресурсы.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-dedicated](../../_pricing/managed-greenplum/rub-hosts-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-dedicated](../../_pricing/managed-greenplum/kzt-hosts-dedicated.md) %}

{% endlist %}




### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}


#### Стандартные хосты {#storage-standard}



{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage-standard](../../_pricing/managed-greenplum/rub-storage-standard.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage-standard](../../_pricing/managed-greenplum/kzt-storage-standard.md) %}

{% endlist %}




#### Выделенные хосты {#storage-dedicated}

Стоимость начисляется из двух компонентов: [цены за хранилище {{ compute-full-name }}](../../compute/pricing.md#prices) и цены {{ mgp-name }} на него. Все цены указаны за 1 ГБ в месяц.

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage-dedicated](../../_pricing/managed-greenplum/rub-storage-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage-dedicated](../../_pricing/managed-greenplum/kzt-storage-dedicated.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
