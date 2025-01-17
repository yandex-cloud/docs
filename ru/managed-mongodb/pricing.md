---
title: Правила тарификации для {{ mmg-full-name }}
description: В статье содержатся правила тарификации сервиса {{ mmg-name }}.
editable: false
---

# Правила тарификации для {{ mmg-name }}



В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mmg-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=2793ca00242f#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mmg-short-name }} {#rules}

Расчет стоимости использования {{ mmg-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ MG }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.


    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя или более хостами, с шагом 93 ГБ.

    * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:
        * для платформ **Intel Broadwell** и **Intel Cascade Lake** — с шагом 100 ГБ;
        * для платформы **Intel Ice Lake** — с шагом {{ local-ssd-v3-step }}.

    Подробнее об ограничениях хранилища, связанных с платформой, см. в разделе [{#T}](./concepts/storage.md).


* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного размера хранилища.

    * При автоматическом резервном копировании {{ mmg-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц.  Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты {{ MG }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 ГБ на сетевых HDD-дисках.

Расчет стоимости для хостов {{ MG }}:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-mongodb-host](../_pricing_examples/managed-mongodb/rub-host.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-mongodb-host](../_pricing_examples/managed-mongodb/kzt-host.md) %}

{% endlist %}



Расчет стоимости хранилища и итоговой стоимости:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-mongodb-storage](../_pricing_examples/managed-mongodb/rub-storage.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-mongodb-storage](../_pricing_examples/managed-mongodb/kzt-storage.md) %}

{% endlist %}




## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Все цены включают НДС.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-host}

Цены на вычислительные ресурсы одинаковы для всех видов хостов — mongod, mongos и mongocfg.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-host](../_pricing/managed-mongodb/rub-host.md) %}


- Цены в тенге {#prices-kzt}

  {% include [kzt-host](../_pricing/managed-mongodb/kzt-host.md) %}


{% endlist %}



### Хранилище и резервные копии {#prices-storage}


{% note info %}

Доступ к сверхбыстрому сетевому хранилищу с тремя репликами (SSD) предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}



{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage](../_pricing/managed-mongodb/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage](../_pricing/managed-mongodb/kzt-storage.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

