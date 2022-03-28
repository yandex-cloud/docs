---
editable: false
---

# Правила тарификации для {{ mkf-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mkf-short-name }} {#rules}

Расчет стоимости использования {{ mkf-name }} учитывает:

* тип и объем хранилища (дискового пространства);

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам {{ ZK }}), и тип хостов;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов как для хостов-брокеров {{ KF }}, так и для хостов {{ ZK }} (в соответствии с ожидаемой нагрузкой реплицирования).

В зависимости от [типа хоста](./concepts/index.md) стоимость вычисляется по-разному:

* Стандартные хосты

    Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.

{% if audience != "internal" %}
* Выделенные хосты

    {% include [Dedicated hosts prices](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

{% endif %}

{% note warning %}

При создании кластера с 2 и более хостами-брокерами {{ KF }} автоматически создается 3 хоста {{ ZK }} минимального класса в трех зонах доступности, которые обеспечивают репликацию и отказоустойчивость кластера. При создании кластера с 1 хостом-брокером хосты {{ ZK }} не создаются.

{% endnote %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост-брокер или {{ ZK }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается объем хранилища, выделенный для кластеров.

  * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами-брокерами и более:
      * для платформы Intel Cascade Lake — с шагом 100 ГБ;
      * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.
  * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами-брокерами и более, с шагом 93 ГБ.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if region == "ru"%}

### Пример расчета стоимости кластера {#example}

{% list tabs %}

* Стандартные хосты

    Например, вы создали кластер:

    * с 3 хостами-брокерами {{ KF }} с классом хостов `s2.micro` (2 vCPU, 8 ГБ RAM),
    * с 3 автоматически созданными хостами {{ ZK }} класса `b2.medium` (2 vCPU, 50% vCPU, 4 ГБ RAM).
    * c 100 ГБ хранилища на сетевых HDD-дисках.

    Стоимость часа работы хостов: `3 × (2 × 1,05 ₽ + 8 × 0,28 ₽) + 3 × (2 × 0,49 ₽ + 4 × 0,20 ₽) = 18,36 ₽`

    Общая стоимость кластера в месяц (хосты и хранилище): `720 × 18,36 ₽ + 100 × 2,2881 ₽ = 13 448,01 ₽`

    {% endif %}

{% endlist %}

{% if audience == "cvos" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{mkf-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно. 

{% endnote %}


{% endif %}

## Цены {#prices}

{% if region != "int" %}
{% include [disclaimer-new-prices](../_pricing/disclaimer-new-prices.md) %}
{% endif %}

{% if region != "int" %}

Все цены указаны с включением НДС.

{% else %}

Все цены указаны без включения НДС.

{% endif %}

Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

От типа хостов также зависит цена на быстрое локальное хранилище.

### Вычислительные ресурсы хостов-брокеров {{ KF }} {#prices-kafka-brokers}

{% list tabs %}

* Стандартные хосты

    {% if region == "ru" %} {% include notitle [RUB: standard broker hosts](../_pricing/managed-kafka/rub-hosts-standard.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: standard broker hosts](../_pricing/managed-kafka/kzt-hosts-standard.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: standard broker hosts](../_pricing/managed-kafka/usd-hosts-standard.md) %}{% endif %}

{% if audience != "internal" %}

* Выделенные хосты

    {% include [Цена на выделенные хосты](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

    {% if audience == "draft" %}
    {% if region == "ru" %} {% include notitle [RUB: dedicated broker hosts](../_pricing/managed-kafka/rub-hosts-dedicated.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: dedicated broker hosts](../_pricing/managed-kafka/kzt-hosts-dedicated.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: dedicated broker hosts](../_pricing/managed-kafka/usd-hosts-dedicated.md) %}{% endif %}
    {% endif %}
    
{% endif %}

{% endlist %}

### Вычислительные ресурсы хостов {{ ZK }} {#prices-zookeeper}

{% note info %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% endnote %}

{% list tabs %}

* Стандартные хосты

    {% if region == "ru" %} {% include notitle [RUB: standard ZooKeeper hosts](../_pricing/managed-kafka/rub-hosts-zk-standard.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: standard ZooKeeper hosts](../_pricing/managed-kafka/kzt-hosts-zk-standard.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: standard ZooKeeper hosts](../_pricing/managed-kafka/usd-hosts-zk-standard.md) %}{% endif %}

{% if audience != "internal" %}

* Выделенные хосты

    {% include [Цена на выделенные хосты](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

    {% if audience == "draft" %}
    {% if region == "ru" %} {% include notitle [RUB: dedicated ZooKeeper hosts](../_pricing/managed-kafka/rub-hosts-zk-dedicated.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: dedicated ZooKeeper hosts](../_pricing/managed-kafka/kzt-hosts-zk-dedicated.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: dedicated ZooKeeper hosts](../_pricing/managed-kafka/usd-hosts-zk-dedicated.md) %}{% endif %}
    {% endif %}

{% endif %}

{% endlist %}

### Хранилище {#prices-storage}

{% if region == "ru" %} {% include notitle [RUB: Storage prices](../_pricing/managed-kafka/rub-storage.md) %}{% endif %}
{% if region == "kz" %} {% include notitle [KZT: Storage prices](../_pricing/managed-kafka/kzt-storage.md) %}{% endif %}
{% if region == "int" %}{% include notitle [USD: Storage prices](../_pricing/managed-kafka/usd-storage.md) %}{% endif %}

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

