---
editable: false
---

# Правила тарификации для {{ mkf-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ mkf-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

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

{% if product == "yandex-cloud" and audience != "internal" %}
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
    {% if product == "yandex-cloud" %}* для платформы Intel Cascade Lake — с шагом 100 ГБ;{% endif %}
      * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.
  * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами-брокерами и более, с шагом 93 ГБ.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if region == "ru"%}

### Пример расчета стоимости кластера {#example}

{% list tabs %}

* Стандартные хосты

  Стоимость использования кластера со следующими параметрами в течение 30 дней:

  * **Хосты-брокеры {{ KF }}**: 3 хоста класса `s2.micro`: Intel Cascade Lake, 2 × 100% vCPU, 8 ГБ RAM.
  * **Хранилище для хостов-брокеров {{ KF }}**: по 100 ГБ на сетевых HDD-дисках на каждый хост-брокер.
  * **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b2.medium`: Intel Cascade Lake, 2 × 50% vCPU, 4 ГБ RAM. 
  * **Хранилище для хостов {{ ZK }}**: по 10 ГБ на сетевых SSD-дисках на каждый хост.

  Расчет стоимости:

  > 3 × (2&nbsp;×&nbsp;1,6800 ₽ + 8&nbsp;×&nbsp;0,4500 ₽) = 20,8800&nbsp;₽
  > 
  > Итого: 20,8800 ₽ – стоимость часа работы хостов-брокеров {{ KF }}.

  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 2 — количество vCPU.
  * 1,6800 ₽ — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста (в гигабайтах).
  * 0,4500 ₽ — стоимость часа использования 1 ГБ RAM на 100% vCPU.

  > 3 × 100 × 3,2000 ₽ = 960,0000 ₽
  >
  > Итого: 960,0000 ₽ – стоимость хранилища для хостов-брокеров {{ KF }}.

  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * 3,2000 ₽ – стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

  > 3 × (2&nbsp;×&nbsp;0,7800 ₽ + 4&nbsp;×&nbsp;0,3200 ₽) = 8,5200&nbsp;₽
  >
  > Итого: 8,5200 ₽ – стоимость часа работы хостов {{ ZK }}.

  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * 0,7800 ₽ — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста (в гигабайтах).
  * 0,3200 ₽ — стоимость часа использования 1 ГБ RAM на 50% vCPU.

  > 3 × 10 × 13,0100 ₽ = 390,3000 ₽
  >
  > Итого: 390,3000 ₽ – стоимость хранилища для хостов {{ ZK }}.

  Где:
  * 3 — количество хостов {{ ZK }}.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * 13,0100 ₽ — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.

  > 720 × (20,8800 ₽ + 8,5200 ₽) + 960,0000 ₽ + 390,3000 ₽ = 22&nbsp;518,300&nbsp;₽
  >
  > Итого: 22&nbsp;518,300&nbsp;₽ – стоимость использования кластера в течение 30 дней.

  Где:
  * 720 — количество часов в 30 днях.
  * 20,8800 ₽ — стоимость часа работы хостов-брокеров {{ KF }}.
  * 8,5200 ₽ — стоимость часа работы хостов {{ ZK }}.
  * 960,0000 ₽ — стоимость хранилища для хостов-брокеров {{ KF }}.
  * 390,3000 ₽ – стоимость хранилища для хостов {{ ZK }}.

{% endlist %}

{% endif %}

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

{% if product == "yandex-cloud" and audience != "internal" %}

* Выделенные хосты

    {% include [Цена на выделенные хосты](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

    {% if region == "ru" %} {% include notitle [RUB: dedicated broker hosts](../_pricing/managed-kafka/rub-hosts-dedicated.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: dedicated broker hosts](../_pricing/managed-kafka/kzt-hosts-dedicated.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: dedicated broker hosts](../_pricing/managed-kafka/usd-hosts-dedicated.md) %}{% endif %}
    
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

{% if product == "yandex-cloud" and audience != "internal" %}

* Выделенные хосты

    {% include [Цена на выделенные хосты](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

    Уточняйте стоимость в [технической поддержке]({{ link-console-support }}).

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

{% endif %}
