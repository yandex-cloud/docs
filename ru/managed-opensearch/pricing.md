---
editable: false
---

# Правила тарификации для {{ mos-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mos-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mos-short-name }} {#rules}

Расчет стоимости использования {{ mos-name }} учитывает:

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам с ролью `MANAGER`);

* тип дисков и объем дискового пространства;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость работы хоста зависит от выделенных для него вычислительных ресурсов. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов как для хостов с ролью `DATA`, так и для хостов с ролью `MANAGER` и `DASHBOARDS`.

Стоимость начисляется за каждый час работы хоста. Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ OS }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров.

* Объем, занимаемый резервными копиями данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется пока сумма размера данных в кластере и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании {{ mos-short-name }} не создает новую копию, а сохраняет изменения данных по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).


## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mos-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



Все цены указаны с включением НДС.



{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-hosts}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}



#### Цены в час {#prices-hosts-hour}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-hour.md](../_pricing/managed-opensearch/rub-hosts-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-hour.md](../_pricing/managed-opensearch/kzt-hosts-hour.md) %}

{% endlist %}



#### Цены в месяц {#prices-hosts-month}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-hosts-month.md](../_pricing/managed-opensearch/rub-hosts-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-hosts-month.md](../_pricing/managed-opensearch/kzt-hosts-month.md) %}

{% endlist %}



### Хранилище {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../_includes/ice-lake-local-ssd-note.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage.md](../_pricing/managed-opensearch/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage.md](../_pricing/managed-opensearch/kzt-storage.md) %}

{% endlist %}





{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
