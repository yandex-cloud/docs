---
editable: false
---

# Правила тарификации для {{ mkf-name }}

{% if product == "cloud-il" %}

{% note info %}

Цены, указанные ниже, начнут действовать, когда сервис {{ mkf-name }} [станет общедоступным](../overview/concepts/launch-stages.md) (дата будет объявлена позже). До этого использование сервиса не тарифицируется.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

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

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов как для хостов-брокеров {{ KF }}, так и для хостов {{ ZK }} (в соответствии с ожидаемой нагрузкой реплицирования).

{% if product == "yandex-cloud" and audience != "internal" %}

В зависимости от [типа хоста](./concepts/index.md) стоимость вычисляется по-разному:

* Стандартные хосты

    Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.

* Выделенные хосты

    {% include [Dedicated hosts prices](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

{% endif %}

{% note warning %}

При создании кластера с 2 и более хостами-брокерами {{ KF }} автоматически создается 3 хоста {{ ZK }} минимального класса в трех зонах доступности, которые обеспечивают репликацию и отказоустойчивость кластера. При создании кластера с 1 хостом-брокером хосты {{ ZK }} не создаются.

{% endnote %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост-брокер или {{ ZK }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается объем хранилища, выделенный для кластеров.

{% if product == "yandex-cloud" %}

  * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами-брокерами и более:
      * для платформы Intel Cascade Lake — с шагом 100 ГБ;
      * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.
  * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами-брокерами и более, с шагом 93 ГБ.

{% endif %}

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if product == "yandex-cloud" %}

### Пример расчета стоимости кластера {#example}

{% list tabs %}

* Стандартные хосты

  Стоимость использования кластера со следующими параметрами в течение 30 дней:

  * **Хосты-брокеры {{ KF }}**: 3 хоста класса `s2.micro`: Intel Cascade Lake, 2 × 100% vCPU, 8 ГБ RAM.
  * **Хранилище для хостов-брокеров {{ KF }}**: по 100 ГБ на сетевых HDD-дисках на каждый хост-брокер.
  * **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b2.medium`: Intel Cascade Lake, 2 × 50% vCPU, 4 ГБ RAM. 
  * **Хранилище для хостов {{ ZK }}**: по 10 ГБ на сетевых SSD-дисках на каждый хост.

  Расчет стоимости:

  {% if region == "ru" %}
  > 3 × (2&nbsp;×&nbsp;1,6800&nbsp;₽ + 8&nbsp;×&nbsp;2,1000&nbsp;₽) + 8&nbsp;×&nbsp;(0,4500&nbsp;₽) = 20,8800&nbsp;₽
  {% endif %}
  {% if region == "int" %}
  > 3 × (2&nbsp;×&nbsp;0,013440&nbsp;$ + 8&nbsp;×&nbsp;0,016800&nbsp;$) + 8&nbsp;×&nbsp;(0,003600&nbsp;$) = 0,167040&nbsp;$
  {% endif %}
  {% if region == "kz" %}
  > 3 × (2&nbsp;×&nbsp;8,4000&nbsp;₸ + 8&nbsp;×&nbsp;10,5000&nbsp;₸) + 8&nbsp;×&nbsp;(2,2500&nbsp;₸) = 104,4000&nbsp;₸
  {% endif %}
  > 
  > Итого: {% if region == "ru" %}20,8800&nbsp;₽{% endif %}{% if region == "int" %}0,167040&nbsp;${% endif %}{% if region == "kz" %}104,4000&nbsp;₸{% endif %} – стоимость часа работы хостов-брокеров {{ KF }}.

  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 2 — количество vCPU.
  * {% if region == "ru" %}1,6800&nbsp;₽{% endif %}{% if region == "int" %}0,013440&nbsp;${% endif %}{% if region == "kz" %}8,4000&nbsp;₸{% endif %} — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста (в гигабайтах).
  * {% if region == "ru" %}0,4500&nbsp;₽{% endif %}{% if region == "int" %}0,003600&nbsp;${% endif %}{% if region == "kz" %}2,2500&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

  > {% if region == "ru" %}3 × 100 × 3,2000&nbsp;₽ = 960,0000&nbsp;₽{% endif %}
  > {% if region == "int" %}3 × 100 × 0,025600&nbsp;$ = 7,680000&nbsp;${% endif %}
  > {% if region == "kz" %}3 × 100 × 16,0000&nbsp;₸ = 4800,0000&nbsp;₸{% endif %}
  >
  > Итого: {% if region == "ru" %}960,0000&nbsp;₽{% endif %}{% if region == "int" %}7,680000&nbsp;${% endif %}{% if region == "kz" %}4800,0000&nbsp;₸{% endif %} – стоимость хранилища для хостов-брокеров {{ KF }}.

  Где:
  * 3 — количество хостов-брокеров {{ KF }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * {% if region == "ru" %}3,2000&nbsp;₽{% endif %}{% if region == "int" %}0,025600&nbsp;${% endif %}{% if region == "kz" %}16,0000&nbsp;₸{% endif %} – стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

  > {% if region == "ru" %}3 × (2&nbsp;×&nbsp;0,7800&nbsp;₽ + 4&nbsp;×&nbsp;0,3200&nbsp;₽) = 8,5200&nbsp;₽{% endif %}
  > {% if region == "int" %}3 × (2&nbsp;×&nbsp;0,006240&nbsp;$ + 4&nbsp;×&nbsp;0,002560&nbsp;$) = 0,068160&nbsp;${% endif %}
  > {% if region == "kz" %}3 × (2&nbsp;×&nbsp;3,9000&nbsp;₸ + 4&nbsp;×&nbsp;1,6000&nbsp;₸) = 42,6000&nbsp;₸{% endif %}
  >
  > Итого: {% if region == "ru" %}8,5200&nbsp;₽{% endif %}{% if region == "int" %}0,068160&nbsp;${% endif %}{% if region == "kz" %}42,6000&nbsp;₸{% endif %} – стоимость часа работы хостов {{ ZK }}.

  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * {% if region == "ru" %}0,7800&nbsp;₽{% endif %}{% if region == "int" %}0,006240&nbsp;${% endif %}{% if region == "kz" %}3,9000&nbsp;₸{% endif %} — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста (в гигабайтах).
  * {% if region == "ru" %}0,3200&nbsp;₽{% endif %}{% if region == "int" %}0,002560&nbsp;${% endif %}{% if region == "kz" %}1,6000&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM на 50% vCPU.

  > {% if region == "ru" %}3 × 10 × 13,0100&nbsp;₽ = 390,3000&nbsp;₽{% endif %}
  > {% if region == "int" %}3 × 10 × 0,104080&nbsp;$ = 3,122400&nbsp;${% endif %}
  > {% if region == "kz" %}3 × 10 × 65,0500&nbsp;₸ = 1951,5000&nbsp;₸{% endif %}
  >
  > Итого: {% if region == "ru" %}390,3000&nbsp;₽{% endif %}{% if region == "int" %}3,122400&nbsp;${% endif %}{% if region == "kz" %}1951,5000&nbsp;₸{% endif %} – стоимость хранилища для хостов {{ ZK }}.

  Где:
  * 3 — количество хостов {{ ZK }}.
  * 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
  * {% if region == "ru" %}13,0100&nbsp;₽{% endif %}{% if region == "int" %}0,104080&nbsp;${% endif %}{% if region == "kz" %}65,0500&nbsp;₸{% endif %} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.

  > {% if region == "ru" %}720 × (20,8800&nbsp;₽ + 8,5200&nbsp;₽) + 960,0000&nbsp;₽ + 390,3000&nbsp;₽ = 22&nbsp;518,300&nbsp;₽{% endif %}
  > {% if region == "int" %}720 × (0,167040&nbsp;$ + 0,068160&nbsp;$) + 7,680000&nbsp;$ + 3,122400&nbsp;$ = 180,146400&nbsp;${% endif %}
  > {% if region == "kz" %}720 × (104,4000&nbsp;₸ + 42,6000&nbsp;₸) + 4800,0000&nbsp;₸ + 1951,5000&nbsp;₸ = 112&nbsp;591,5000&nbsp;₸{% endif %}
  >
  > Итого: {% if region == "ru" %}22&nbsp;518,300&nbsp;₽{% endif %}{% if region == "int" %}180,146400&nbsp;${% endif %}{% if region == "kz" %}112&nbsp;591,5000&nbsp;₸{% endif %} – стоимость использования кластера в течение 30 дней.

  Где:
  * 720 — количество часов в 30 днях.
  * {% if region == "ru" %}20,8800&nbsp;₽{% endif %}{% if region == "int" %}0,167040&nbsp;${% endif %}{% if region == "kz" %}104,4000&nbsp;₸{% endif %} — стоимость часа работы хостов-брокеров {{ KF }}.
  * {% if region == "ru" %}8,5200&nbsp;₽{% endif %}{% if region == "int" %}0,068160&nbsp;${% endif %}{% if region == "kz" %}42,6000&nbsp;₸{% endif %} — стоимость часа работы хостов {{ ZK }}.
  * {% if region == "ru" %}960,0000&nbsp;₽{% endif %}{% if region == "int" %}7,680000&nbsp;${% endif %}{% if region == "kz" %}4800,0000&nbsp;₸{% endif %} — стоимость хранилища для хостов-брокеров {{ KF }}.
  * {% if region == "ru" %}390,3000&nbsp;₽{% endif %}{% if region == "int" %}3,122400&nbsp;${% endif %}{% if region == "kz" %}1951,5000&nbsp;₸{% endif %} – стоимость хранилища для хостов {{ ZK }}.

{% endlist %}

{% endif %}

{% if product == "yandex-cloud" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{mkf-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно. 

{% endnote %}

{% endif %}

## Цены {% if product == "cloud-il" %}(когда сервис станет общедоступным){% endif %} {#prices}

{% if region != "int" %}

Все цены указаны с включением НДС.

{% else %}

Все цены указаны без включения НДС.

{% endif %}

{% if product == "yandex-cloud" %}

Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

От типа хостов также зависит цена на быстрое локальное хранилище.

{% endif %}

### Вычислительные ресурсы хостов-брокеров {{ KF }} {#prices-kafka-brokers}

{% if product == "yandex-cloud" %}

{% list tabs %}

* Стандартные хосты

    {% if region == "ru" %} {% include notitle [RUB: standard broker hosts](../_pricing/managed-kafka/rub-hosts-standard.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: standard broker hosts](../_pricing/managed-kafka/kzt-hosts-standard.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: standard broker hosts](../_pricing/managed-kafka/usd-hosts-standard.md) %}{% endif %}

{% if audience != "internal" %}

* Выделенные хосты

    {% include [Цена на выделенные хосты](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

    {% if region == "ru" %} {% include notitle [RUB: dedicated broker hosts](../_pricing/managed-kafka/rub-hosts-dedicated.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: dedicated broker hosts](../_pricing/managed-kafka/kzt-hosts-dedicated.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: dedicated broker hosts](../_pricing/managed-kafka/usd-hosts-dedicated.md) %}{% endif %}  

{% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}
    
{% include notitle [ILS: standard broker hosts](../_pricing/managed-kafka/ils-hosts-standard.md) %}
    
{% endif %}

### Вычислительные ресурсы хостов {{ ZK }} {#prices-zookeeper}

{% if product == "yandex-cloud" %}

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

    Уточняйте стоимость в [технической поддержке]({{ link-console-support }}).

    {% if audience == "draft" %}
    {% if region == "ru" %} {% include notitle [RUB: dedicated ZooKeeper hosts](../_pricing/managed-kafka/rub-hosts-zk-dedicated.md) %}{% endif %}
    {% if region == "kz" %} {% include notitle [KZT: dedicated ZooKeeper hosts](../_pricing/managed-kafka/kzt-hosts-zk-dedicated.md) %}{% endif %}
    {% if region == "int" %}{% include notitle [USD: dedicated ZooKeeper hosts](../_pricing/managed-kafka/usd-hosts-zk-dedicated.md) %}{% endif %}
    {% endif %}

{% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ILS: standard ZooKeeper hosts](../_pricing/managed-kafka/ils-hosts-zk-standard.md) %}

{% endif %}

### Хранилище {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %} {% include notitle [RUB: Storage prices](../_pricing/managed-kafka/rub-storage.md) %}{% endif %}
{% if region == "kz" %} {% include notitle [KZT: Storage prices](../_pricing/managed-kafka/kzt-storage.md) %}{% endif %}
{% if region == "int" %}{% include notitle [USD: Storage prices](../_pricing/managed-kafka/usd-storage.md) %}{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ILS: Storage prices](../_pricing/managed-kafka/ils-storage.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if product == "yandex-cloud" %}

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

{% if product == "cloud-il" %}

{% include notitle [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}