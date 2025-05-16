---
title: Правила тарификации для {{ mkf-full-name }}
description: В статье содержатся правила тарификации сервиса {{ mkf-name }}.
editable: false
---

# Правила тарификации для {{ mkf-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mkf-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=b51108af518a#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.





{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mkf-short-name }} {#rules}

Расчет стоимости использования {{ mkf-name }} учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам {{ ZK }}), и тип хостов;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов для хостов-брокеров {{ KF }} и хостов {{ ZK }} в соответствии с ожидаемой нагрузкой реплицирования. Наличие хостов {{ ZK }} зависит от конфигурации кластера:

* Хосты {{ ZK }} добавляются в кластер, если он содержит больше одного хоста {{ KF }} и в кластере установлена версия {{ KF }} 3.5.
* Хосты {{ ZK }} не добавляются в кластер, если он содержит один хост-брокер либо установлена версия {{ KF }} 3.6 или выше.


В зависимости от [типа хоста](./concepts/index.md) стоимость вычисляется по-разному:

* Стандартные хосты

    Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.


* Выделенные хосты

    {% include [Dedicated hosts prices](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}



Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост-брокер или {{ ZK }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается объем хранилища, выделенный для кластеров.

* Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами-брокерами и более:
    * для платформы Intel Cascade Lake — с шагом 100 ГБ;
    * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.
* Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами-брокерами и более, с шагом 93 ГБ.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты-брокеры {{ KF }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **Хранилище для хостов-брокеров {{ KF }}**: по 100 ГБ на сетевых HDD-дисках на каждый хост-брокер.
* **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b3-c1-m4`: Intel Ice Lake, 2 × 50% vCPU, 4 ГБ RAM. 
* **Хранилище для хостов {{ ZK }}**: по 10 ГБ на сетевых SSD-дисках на каждый хост.

#### Стандартные хосты {#example-standard-hosts}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-hour](../_pricing_examples/managed-kafka/rub-hour.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-hour](../_pricing_examples/managed-kafka/kzt-hour.md) %}

{% endlist %}




## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mkf-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены для региона Россия](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Все цены указаны с включением НДС.


Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

От типа хостов также зависит цена на быстрое локальное хранилище.

### Вычислительные ресурсы хостов-брокеров {{ KF }} {#prices-kafka-brokers}

#### Стандартные хосты {#prices-kafka-standard}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}



**Цены в час**


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-standard-hour](../_pricing/managed-kafka/rub-hosts-standard-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-standard-hour](../_pricing/managed-kafka/kzt-hosts-standard-hour.md) %}

{% endlist %}



**Цены в месяц**


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-standard-month](../_pricing/managed-kafka/rub-hosts-standard-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-standard-month](../_pricing/managed-kafka/kzt-hosts-standard-month.md) %}

{% endlist %}







#### Выделенные хосты {#prices-kafka-dedicated}

{% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [RUB: dedicated broker hosts](../_pricing/managed-kafka/rub-hosts-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [KZT: dedicated broker hosts](../_pricing/managed-kafka/kzt-hosts-dedicated.md) %}

{% endlist %}





### Вычислительные ресурсы хостов {{ ZK }} {#prices-zookeeper}


{% note info %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% endnote %}


#### Стандартные хосты {#zookeeper-standard}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}



{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [RUB: standard ZooKeeper hosts](../_pricing/managed-kafka/rub-hosts-zk-standard.md) %}

- Цены в тенге {#prices-kzt}

  {% include [KZT: standard ZooKeeper hosts](../_pricing/managed-kafka/kzt-hosts-zk-standard.md) %}

{% endlist %}






#### Выделенные хосты {#zookeeper-dedicated}

{% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

Уточняйте стоимость в [технической поддержке]({{ link-console-support }}).





### Вычислительные ресурсы хостов {{ kraft-name }} {#prices-kraft}

#### Стандартные хосты {#prices-kraft-standard}

{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}


**Цены в час**

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-kraft-standard-hour](../_pricing/managed-kafka/rub-hosts-kraft-standard-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-kraft-standard-hour](../_pricing/managed-kafka/kzt-hosts-kraft-standard-hour.md) %}

{% endlist %}

**Цены в месяц**

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-kraft-standard-month](../_pricing/managed-kafka/rub-hosts-kraft-standard-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-kraft-standard-month](../_pricing/managed-kafka/kzt-hosts-kraft-standard-month.md) %}

{% endlist %}




#### Выделенные хосты {#prices-kraft-dedicated}

{% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [RUB: dedicated broker hosts](../_pricing/managed-kafka/rub-hosts-kraft-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [KZT: dedicated broker hosts](../_pricing/managed-kafka/kzt-hosts-kraft-dedicated.md) %}

{% endlist %}





### Хранилище {#prices-storage}

{% include [local-ssd for Intel Ice Lake only by request](../_includes/ice-lake-local-ssd-note.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [RUB: Storage prices](../_pricing/managed-kafka/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [KZT: Storage prices](../_pricing/managed-kafka/kzt-storage.md) %}

{% endlist %}




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
