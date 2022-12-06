---
editable: false
---

# Правила тарификации для {{ mpg-name }}

Использование сервиса {{ mpg-name }} тарифицируется по правилам, описанным в этом разделе.

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mpg-short-name }} {#rules}

Расчет стоимости использования {{ mpg-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [{#T}](concepts/instance-types.md).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ PG }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

    {% if product == "yandex-cloud" %}

    * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:
        * для платформ Intel Broadwell и Intel Cascade Lake — с шагом 100 ГБ;
        * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.

    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

    {% endif %}

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    {% note info %}

    Размер хранилища кластера равен суммарному размеру хранилищ всех его хостов.

    {% endnote %}

    * Хранение резервных копий не тарифицируется пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании {{ mpg-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * При добавлении хостов увеличивается общий размер хранилища кластера и, соответственно, бесплатный объем резервных копий.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if product == "yandex-cloud" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{mpg-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

{% endif %}

## Цены {#prices}

{% if region != "int" %}

Все цены указаны с включением НДС.

{% else %}

Все цены указаны без включения НДС.

{% endif %}

### Вычислительные ресурсы хостов {#prices-hosts}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-host-resources.md](../_pricing/managed-postgresql/rub-host-resources.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-host-resources.md](../_pricing/managed-postgresql/kzt-host-resources.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-host-resources.md](../_pricing/managed-postgresql/usd-host-resources.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-host-resources.md](../_pricing/managed-postgresql/ils-host-resources.md) %}

{% endif %}

### Хранилище и резервные копии {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-storage.md](../_pricing/managed-postgresql/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-storage.md](../_pricing/managed-postgresql/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-storage.md](../_pricing/managed-postgresql/usd-storage.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-storage.md](../_pricing/managed-postgresql/ils-storage.md) %}

{% endif %}

Особенности тарификации хранилища резервных копий:

* Хранение резервных копий не тарифицируется, пока суммарный объем БД и всех резервных копий меньше общего размера хранилища.

* При [добавлении хоста](./operations/hosts#add) общая стоимость кластера возрастет, но расходы на хранение резервных копий сверх размера хранилища снизятся за счет увеличения общего размера хранилища.

* Чтобы сократить расходы на хранение резервных копий сверх размера хранилища:

    * Сократите срок хранения автоматических резервных копий в [дополнительных настройках](./operations/update#change-additional-settings).
    * [Удалите резервные копии](./operations/cluster-backups.md#delete), созданные вручную.

* {% include [backup-wal](../_includes/mdb/mpg/backup-wal.md) %}

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
