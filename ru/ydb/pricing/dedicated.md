---
title: Правила тарификации для режима Dedicated в {{ ydb-full-name }}
description: Из статьи вы узнаете о правилах тарификации для режима Dedicated в {{ ydb-full-name }}.
editable: false
---

# Правила тарификации для режима Dedicated в {{ ydb-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: ../../_assets/console-icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=2443a6ec26b9#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: ../../_assets/console-icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2ydbtgqogjqcrlbehu%2Cdn2kcipi3i3av4ej1fsv
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: ../../_assets/console-icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 6
    children: []
:::





{% include [vat](../../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## Из чего складывается стоимость использования {{ ydb-name }} {#rules}

При работе {{ ydb-name }} в режиме *Dedicated* вы оплачиваете:

* Тип и размер [групп хранения](../concepts/resources.md#storage-groups), выделенных для базы данных.
* [Вычислительные ресурсы](../concepts/resources.md#resource-presets), выделенные БД.
* Размер дискового пространства, выделенного для [временного хранилища (спиллинг)](../concepts/resources.md#spilling).

Дополнительно оплачиваются иные потребляемые ресурсы:

* Место, занятое в сервисе {{ objstorage-full-name }} для хранения резервных копий по требованию.
* Объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Использование вычислительных ресурсов {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы виртуальной машины в соответствии с ее классом. Точные характеристики классов приведены в разделе [{#T}](../concepts/index.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы виртуальной машины равна стоимости 2 часов).

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для групп хранения БД.
* Объем, занимаемый резервными копиями БД по требованию, сохраненными в сервисе {{ objstorage-name }}.

    {% note info %}

    {{ ydb-name }} для каждой БД автоматические создает и бесплатно хранит 2 полные резервные копии за два последних дня. Плата за хранение автоматических резервных копий не взимается.

    {% endnote %}

* Объем временного хранилища (спиллинг).

    {% note info %}

    Стоимость временного хранилища (спиллинг) указана за один узел {{ ydb-short-name }}.

    {% endnote %}

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

Сервис {{ ydb-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены для региона Россия {#prices}




{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|ydb }}']}
    skuIds={['{{ pc|ydb.cluster.v2.cpu }}', '{{ pc|v1.commitment.selfcheckout.m6.ydb.cpu.c100.v2 }}', '{{ pc|v1.commitment.selfcheckout.y1.ydb.cpu.c100.v2 }}', 
    '{{ pc|ydb.cluster.v2.ram }}', '{{ pc|v1.commitment.selfcheckout.m6.ydb.ram.v2 }}', '{{ pc|v1.commitment.selfcheckout.y1.ydb.ram.v2 }}', 
    '{{ pc|ydb.cluster.v1.ssd }}', '{{ pc|ydb.db.backup.v1 }}', '{{ pc|ydb.spilling_type1.v1 }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




{% note info "Минимальный размер группы" %}

Одна [группа хранения](../concepts/resources.md#storage-groups) позволяет разместить до 100 Гб пользовательских данных. Минимальная гранулярность выделения места для базы данных – одна группа хранения.

{% endnote %}


{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

