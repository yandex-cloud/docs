---
editable: false
---

# Правила тарификации для {{ mch-short-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mch-short-name }} {#rules}

Расчет стоимости использования {{ mch-name }} учитывает:

* тип и объем хранилища (дискового пространства);

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам {{ ZK }});

* настройки и количество резервных копий;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.


{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов как для хостов {{ CH }}, так и для хостов ZooKeeper (в соответствии с ожидаемой нагрузкой реплицирования).

{% note warning %}

При создании кластера с 2 и более хостами {{ CH }} автоматически создается 3 хоста {{ ZK }} минимального класса, которые обеспечивают репликацию и отказоустойчивость кластера.

{% endnote %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост СУБД или {{ ZK }} не может выполнять свои основные функции, не тарифицируется.


### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (`local-ssd`) можно заказывать только для кластеров более чем с 2 хостами, с шагом 100 ГБ.
    * Хранилище на нереплицируемых сетевых дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

* Объем, занимаемый резервными копиями данных [локального](concepts/storage.md) и [сетевых](concepts/storage.md) хранилищ:
    
    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.
    
    * Если сумма размера БД и всех резервных копий становится больше объема хранилища кластера, тарифицируется только превышение этого объема.

   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

   * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.
    
    Например, если в кластере есть N свободных гигабайт места, то хранение первых N гигабайт резервных копий не тарифицируется.

* Объем, занимаемый резервными копиями холодных данных [гибридного хранилища](concepts/storage.md#hybrid-storage-features):
   
   * Резервные копии холодных данных хранятся в том же бакете {{ objstorage-name }}, что и сами данные.
   
   * Объем, который занимают резервные копии, учитывается при расчете стоимости использования {{ objstorage-name }} так же, как и объем самих данных.
   
   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if region == "ru"%}

### Пример расчета стоимости кластера {#example}

Например, вы создали кластер:

* с 3 хостами {{ CH }} класса `s1.micro` (2 vCPU, 8 ГБ RAM),
* с 3 автоматически созданными хостами {{ ZK }} класса `b2.medium` (2 vCPU × 50%, 4 ГБ RAM),
* c 100 ГБ стандартного сетевого хранилища.

Стоимость использования ресурсов:

* 1 час использования ядра хоста {{ CH }} с 100% vCPU — 1,43 ₽;
* 1 час использования 1 ГБ RAM хоста {{ CH }} — 0,33 ₽;
* 1 час использования ядра хоста {{ ZK }} с 50% vCPU — 0,49 ₽;
* 1 час использования 1 ГБ RAM хоста {{ ZK }} — 0,2 ₽;
* 1 месяц использования 1 ГБ стандартного сетевого хранилища — 2,2881 ₽.

Стоимость часа работы хостов: `3 × (2 × 1,43 ₽ + 8 × 0,33 ₽) + 3 × (2 × 0,49 ₽ + 4 × 0,2 ₽) = 21,84 ₽`

Общая стоимость кластера в месяц (хосты и хранилище): `720 × 21,84 ₽ + 100 × 2,2881 ₽ = 15 953,61 ₽`

{% endif %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{mch-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно. 

{% endnote %}


## Цены {#prices}

### Вычислительные ресурсы хостов {{ CH }} {#prices-clickhouse}

{% if region == "ru"%}

Все цены указаны с включением НДС.

{% include [rub-host-ch.md](../_pricing/managed-clickhouse/rub-host-ch.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-host-ch.md](../_pricing/managed-clickhouse/kzt-host-ch.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}

{% endif %}


### Вычислительные ресурсы хостов {{ ZK }} {#prices-zookeeper}

{% note info %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% endnote %}

{% if region == "ru"%}

{% include [rub-host-zoo.md](../_pricing/managed-clickhouse/rub-host-zoo.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-host-zoo.md](../_pricing/managed-clickhouse/kzt-host-zoo.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-host-zoo.md](../_pricing/managed-clickhouse/usd-host-zoo.md) %}

{% endif %}


### Хранилище и резервные копии {#prices-storage}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/managed-clickhouse/rub-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-storage.md](../_pricing/managed-clickhouse/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}

{% endif %}


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

## Расчетные цены для классов хостов {#calculated-host-price}

Цены за время работы хостов рассчитаны исходя из конфигураций [классов хостов](concepts/instance-types.md) и приведенных выше цен за использование vCPU и RAM для соответствующей платформы. Чтобы точно рассчитать стоимость нужного кластера, воспользуйтесь [калькулятором](https://cloud.yandex.ru/services/managed-clickhouse#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

### Хосты {{ CH }} {#calculated-clickhouse}

{% list tabs %}

- За месяц работы хоста
  
  {% if region == "ru"%}

Все цены указаны с включением НДС.

  {% include [rub-ch-classes-month.md](../_pricing/managed-clickhouse/rub-ch-classes-month.md) %}

  {% endif %}

  {% if region == "kz"%}

  {% include [kzt-ch-classes-month.md](../_pricing/managed-clickhouse/kzt-ch-classes-month.md) %}

  {% endif %}

- За 1 час работы хоста

  {% if region == "ru"%}

  {% include [rub-ch-classes-hour.md](../_pricing/managed-clickhouse/rub-ch-classes-hour.md) %}

  {% endif %}

  {% if region == "kz"%}

  {% include [kzt-ch-classes-hour.md](../_pricing/managed-clickhouse/kzt-ch-classes-hour.md) %}

  {% endif %}

  {% if region == "int"%}

  {% include [usd-ch-classes-hour.md](../_pricing/managed-clickhouse/usd-ch-classes-hour.md) %}

  {% endif %}

{% endlist %}


### Хосты ZooKeeper {#prices-zookeeper-host}

{% note info %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% endnote %}

{% list tabs %}

- За месяц работы хоста

  {% if region == "ru"%}

  {% include [rub-zoo-classes-month.md](../_pricing/managed-clickhouse/rub-zoo-classes-month.md) %}

  {% endif %}

  {% if region == "kz"%}

  {% include [kzt-zoo-classes-month.md](../_pricing/managed-clickhouse/kzt-zoo-classes-month.md) %}

  {% endif %}

- За 1 час работы хоста

  {% if region == "ru"%}

  {% include [rub-zoo-classes-hour.md](../_pricing/managed-clickhouse/rub-zoo-classes-hour.md) %}

  {% endif %}

  {% if region == "kz"%}

  {% include [kzt-zoo-classes-hour.md](../_pricing/managed-clickhouse/kzt-zoo-classes-hour.md) %}

  {% endif %}

  {% if region == "int"%}

  {% include [usd-zoo-classes-hour.md](../_pricing/managed-clickhouse/usd-zoo-classes-hour.md) %}

  {% endif %}

{% endlist %}
