---
title: Правила тарификации для {{ mpg-name }}
description: Расчет стоимости использования {{ mpg-name }} учитывает тип диска и размер хранилища, вычислительные ресурсы, выделенные хостам кластера, настройки и количество резервных копий и объем исходящего трафика из {{ yandex-cloud }} в интернет.
editable: false
---

# Правила тарификации для {{ mpg-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mpg-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mpg-short-name }} {#rules}

Расчет стоимости использования {{ mpg-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [Классы хостов](concepts/instance-types.md).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ PG }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.


    * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:

        * для платформ Intel Broadwell и Intel Cascade Lake — с шагом 100 ГБ;
        * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.



    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    {% note info %}

    Размер хранилища кластера равен суммарному размеру хранилищ всех его хостов.

    {% endnote %}

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании {{ mpg-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * При добавлении хостов увеличивается общий размер хранилища кластера и, соответственно, бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).


## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{mpg-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



Все цены указаны с включением НДС.



{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-hosts}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}



#### Цены в час {#host-price-per-hour}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-host-resources-hourly](../_pricing/managed-postgresql/rub-host-resources-hourly.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-host-resources-hourly](../_pricing/managed-postgresql/kzt-host-resources-hourly.md) %}

{% endlist %}



#### Цены в месяц {#host-price-per-month}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-host-resources-monthly](../_pricing/managed-postgresql/rub-host-resources-monthly.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-host-resources-monthly](../_pricing/managed-postgresql/kzt-host-resources-monthly.md) %}

{% endlist %}





### Хранилище и резервные копии {#prices-storage}

{% include [ice-lake-local-ssd-note](../_includes/ice-lake-local-ssd-note.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage.md](../_pricing/managed-postgresql/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage.md](../_pricing/managed-postgresql/kzt-storage.md) %}

{% endlist %}




Особенности тарификации хранилища резервных копий:

* Хранение резервных копий не тарифицируется, пока суммарный объем БД и всех резервных копий меньше общего размера хранилища.

* При [добавлении хоста](./operations/hosts#add) общая стоимость кластера возрастет, но расходы на хранение резервных копий сверх размера хранилища снизятся за счет увеличения общего размера хранилища.

* Чтобы сократить расходы на хранение резервных копий сверх размера хранилища:

    * Сократите срок хранения автоматических резервных копий в [дополнительных настройках](./operations/update#change-additional-settings).
    * [Удалите резервные копии](./operations/cluster-backups.md#delete), созданные вручную.

* {% include [backup-wal](../_includes/mdb/mpg/backup-wal.md) %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}