---
title: Правила тарификации для {{ yds-full-name }}
description: В статье содержатся правила тарификации сервиса {{ yds-name }}.
editable: false
---

# Правила тарификации для {{ yds-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

В сервисе {{ yds-name }} существуют два режима тарификации:

* [По выделенным ресурсам](#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
* [По фактическому использованию](#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

Режим тарификации устанавливается для каждого потока данных по-отдельности. По умолчанию потоки данные в {{ yds-name }} создаются в режиме тарификации по выделенным ресурсам.

## Тарификация по выделенным ресурсам {#rules}

В режиме работы по выделенным ресурсам тарифицируется количество единиц записываемых данных и ресурсы, выделенные для обслуживания потоков данных.

При тарификации выделенных ресурсов учитывается лимит предоставленной пропускной способности сегмента, а также время хранения или объем хранения.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Примеры расчета стоимости {#price-example}

В поток данных, состоящий из одного сегмента, поступают 2 сообщения в секунду размером 50 КБ. Время хранения сообщений — 12 часов.

Стоимость обработки данных за месяц (при числе дней в месяце 31):


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  {% include [rub.md](../_pricing_examples/data-streams/rub-data-streams.md) %}

- Стоимость в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing_examples/data-streams/kzt-data-streams.md) %}

{% endlist %}



## Цены для региона Россия {#prices}


{% note warning %}

С 1 мая 2025 года увеличатся цены на ресурсы {{ yds-full-name }} в регионе Россия. Новые цены можно посмотреть на сайте:

* [Цены в рублях](https://yandex.cloud/ru/price-list?installationCode=ru&currency=RUB&services=dn2yds6scistjlmes0fe)
* [Цены в тенге](https://yandex.cloud/ru/price-list?installationCode=ru&currency=KZT&services=dn2yds6scistjlmes0fe)

{% endnote %}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Цена единицы записываемых данных {#event}

Каждый месяц не тарифицируются первые 2 000 000 единиц записываемых данных.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-streams/rub-event.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-streams/kzt-event.md) %}

{% endlist %}



### Цена выделенных ресурсов {#resources}

### Тарификация по времени хранения {#time-limit}

Цена указывается за 1 час использования выделенных ресурсов.


#### Цена за хранение данных при лимите пропускной способности сегмента до 128 КБ/с {#up-to-128}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-streams/rub-resources-128.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-streams/kzt-resources-128.md) %}

{% endlist %}



#### Цена за хранение данных при лимите пропускной способности сегмента до 512 КБ/с {#up-to-512}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-streams/rub-resources-512.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-streams/kzt-resources-512.md) %}

{% endlist %}


#### Цена за хранение данных при лимите пропускной способности сегмента до 1 МБ/с {#up-to-1}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-streams/rub-resources-1.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-streams/kzt-resources-1.md) %}

{% endlist %}



### Тарификация по объему хранения {#storage-limit}

Данные хранятся до 7 дней.


#### Цена за запись данных {#record}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-streams/rub-resources-record.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-streams/kzt-resources-record.md) %}

{% endlist %}

#### Цена за хранение данных {#storage}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/data-streams/rub-resources-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/data-streams/kzt-resources-storage.md) %}

{% endlist %}



## Тарификация по фактическому использованию {#on-demand}

При тарификации по фактическому использованию:
* Потоки данных, хранящие данные в [Serverless базах данных {{ ydb-short-name }}](../ydb/concepts/serverless-and-dedicated.md#serverless), тарифицируются по [правилам тарификации для бессерверного режима {{ ydb-short-name }}](../ydb/pricing/serverless.md).

* Потоки данных, хранящие данные в [Dedicated базах данных {{ ydb-short-name }}](../ydb/concepts/serverless-and-dedicated.md#dedicated), отдельно не тарифицируются (оплачивается только dedicated база, см. [правила тарификации для dedicated баз](../ydb/pricing/dedicated)).

