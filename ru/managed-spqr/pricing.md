---
title: Правила тарификации для {{ mspqr-full-name }}
description: В статье содержатся правила тарификации сервиса {{ mspqr-name }}.
editable: false
keywords:
  - keyword: '{{ SPQR }}'
  - keyword: '{{ mspqr-full-name }}'
  - keyword: '{{ mspqr-name }}'
---

# Правила тарификации для {{ mspqr-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      lg: 6
      sm: 6
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=44d352affb85#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: ../_assets/console-icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2sdm5cvhv4serguw5l
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mspqr-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.


{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mspqr-name }} {#rules}

Расчет стоимости использования {{ mspqr-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [Классы хостов](concepts/instance-types.md).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

    * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:

        * для платформ Intel Broadwell и Intel Cascade Lake — с шагом 100 ГБ;
        * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.

    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

{% include [pricing-backup-general](../_includes/mdb/pricing-backup-general.md) %} 

Подробнее в разделе [Резервные копии в {{ mspqr-name }}](concepts/backup.md).

Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mspqr-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}

{% include [ice-lake-local-ssd-note](../_includes/ice-lake-local-ssd-note.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.spqr }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.spqr.v1.cores }}', '{{ pc|mdb.software_accelerated_network.spqr.v2.cores }}', '{{ pc|mdb.software_accelerated_network.spqr.v3.cores }}', '{{ pc|mdb.software_accelerated_network.spqr.v4a.cores }}' ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

