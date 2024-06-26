---
editable: false
---

# Правила тарификации для {{ mch-short-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mch-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mch-short-name }} {#rules}

Расчет стоимости использования {{ mch-name }} учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам {{ ZK }});

* настройки и количество резервных копий;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Входящий трафик и количество запросов к гибридному хранилищу не тарифицируются.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [{#T}](#prices).

Вы можете выбрать класс хостов как для хостов {{ CH }}, так и для хостов {{ ZK }} (в соответствии с ожидаемой нагрузкой реплицирования).

{% note warning %}

В кластерах с выключенной поддержкой [{{ CK }}](./concepts/replication.md#ck) и с двумя или более хостами {{ CH }} автоматически создается 3 хоста {{ ZK }} минимального класса, которые обеспечивают репликацию и отказоустойчивость.

{% endnote %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост СУБД или {{ ZK }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

   * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:
        * для платформ **Intel Broadwell** и **Intel Cascade Lake** — с шагом 100 ГБ;
        * для платформы **Intel Ice Lake** — с шагом {{ local-ssd-v3-step }}.
   * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя или более хостами, с шагом 93 ГБ.

* Размер, занимаемый резервными копиями данных хранилища на [локальных](concepts/storage.md#local-storage-features) и [сетевых](concepts/storage.md) дисках:

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного размера хранилища.

    * Если сумма размера БД и всех резервных копий становится больше размера хранилища кластера, тарифицируется только превышение этого размера.

   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

   * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

    Например, если в кластере есть N свободных гигабайт места, то хранение первых N гигабайт резервных копий не тарифицируется.

* Размер, занимаемый резервными копиями холодных данных [гибридного хранилища](concepts/storage.md#hybrid-storage-features):

   * Резервные копии холодных данных хранятся в том же бакете {{ objstorage-name }}, что и сами данные.

   * Объем, который занимают резервные копии, учитывается при расчете стоимости использования {{ objstorage-name }} так же, как и объем самих данных.

   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).


### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты {{ CH }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b3-c1-m4`: Intel Ice Lake, 2 × 50% vCPU, 4 ГБ RAM.
* **Хранилище**: 100 ГБ на сетевых HDD-дисках.

Расчет стоимости для хостов {{ CH }}:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 3 × (2&nbsp;×&nbsp;1,7200&nbsp;₽ + 8&nbsp;×&nbsp;0,4700&nbsp;₽) = 21,6000&nbsp;₽
  >
  > Итого: 21,6000&nbsp;₽ — стоимость часа работы хостов {{ CH }}.
  
  Где:
  * 3 — количество хостов {{ CH }}.
  * 2 — количество vCPU.
  * 1,7200&nbsp;₽ — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста {{ CH }} (в гигабайтах).
  * 0,4700&nbsp;₽ — стоимость часа использования 1 ГБ RAM на 100% vCPU.

- Расчет в тенге {#prices-kzt}

  > 3 × (2&nbsp;×&nbsp;8,6000&nbsp;₸ + 8&nbsp;×&nbsp;2,3500&nbsp;₸) = 108,0000&nbsp;₸
  >
  > Итого: 108,0000&nbsp;₸ — стоимость часа работы хостов {{ CH }}.
  
  Где:
  * 3 — количество хостов {{ CH }}.
  * 2 — количество vCPU.
  * 8,6000&nbsp;₸ — стоимость часа использования 100% vCPU.
  * 8 — объем RAM одного хоста {{ CH }} (в гигабайтах).
  * 2,3500&nbsp;₸ — стоимость часа использования 1 ГБ RAM на 100% vCPU.

{% endlist %}



Расчет стоимости для хостов {{ ZK }}:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 3 × (2&nbsp;×&nbsp;0,7000&nbsp;₽ + 4&nbsp;×&nbsp;0,2800&nbsp;₽) = 7,5600&nbsp;₽
  >
  > Итого: 7,5600&nbsp;₽ — стоимость часа работы хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * 0,7000&nbsp;₽ — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
  * 0,2800&nbsp;₽ — стоимость часа использования 1 ГБ RAM на 50% vCPU.

- Расчет в тенге {#prices-kzt}

  > 3 × (2&nbsp;×&nbsp;3,5000&nbsp;₸ + 4&nbsp;×&nbsp;1,4000&nbsp;₸) = 37,8000&nbsp;₸
  >
  > Итого: 37,8000&nbsp;₸ — стоимость часа работы хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * 3,5000&nbsp;₸ — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
  * 1,4000&nbsp;₸ — стоимость часа использования 1 ГБ RAM на 50% vCPU.

{% endlist %}



Расчет стоимости хранилища и итоговой стоимости:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 720 × (21,6000&nbsp;₽ + 7,5600&nbsp;₽) + 100&nbsp;×&nbsp;3,2000&nbsp;₽ = 21&nbsp;315,2000&nbsp;₽
  >
  > Итого: 21&nbsp;315,2000&nbsp;₽ — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 21,6000&nbsp;₽ — стоимость часа работы хостов {{ CH }}.
  * 7,5600&nbsp;₽ — стоимость часа работы хостов {{ ZK }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * 3,2000&nbsp;₽ — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

- Расчет в тенге {#prices-kzt}

  > 720 × (108,0000&nbsp;₸ + 37,8000&nbsp;₸) + 100&nbsp;×&nbsp;16,0000&nbsp;₸ = 106&nbsp;576,0000&nbsp;₸
  >
  > Итого: 106&nbsp;576,0000&nbsp;₸ — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 108,0000&nbsp;₸ — стоимость часа работы хостов {{ CH }}.
  * 37,8000&nbsp;₸ — стоимость часа работы хостов {{ ZK }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * 16,0000&nbsp;₸ — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

{% endlist %}





## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mch-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [{#T}](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}



## Цены для региона Россия {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Все цены указаны с включением НДС.



{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {{ CH }} {#prices-clickhouse}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}



#### Цены в час {#prices-clickhouse-hour}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-host-ch.md](../_pricing/managed-clickhouse/rub-host-ch-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-host-ch.md](../_pricing/managed-clickhouse/kzt-host-ch-hour.md) %}

{% endlist %}



#### Цены в месяц {#prices-clickhouse-month}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-host-ch.md](../_pricing/managed-clickhouse/rub-host-ch-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-host-ch.md](../_pricing/managed-clickhouse/kzt-host-ch-month.md) %}

{% endlist %}





### Вычислительные ресурсы хостов {{ ZK }} {#prices-zookeeper}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}



{% note info %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% endnote %}



{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-host-zoo.md](../_pricing/managed-clickhouse/rub-host-zoo.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-host-zoo.md](../_pricing/managed-clickhouse/kzt-host-zoo.md) %}

{% endlist %}




### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../_includes/ice-lake-local-ssd-note.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage.md](../_pricing/managed-clickhouse/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage.md](../_pricing/managed-clickhouse/kzt-storage.md) %}

{% endlist %}




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}