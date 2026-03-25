---
title: Подключения
description: На странице представлены вопросы и ответы про подключения.
---

# Подключения

{% include [postgre-type.md](../../_qa/datalens/postgre-type.md) %}



{% include [metrica-clickhouse-connection](../../_qa/datalens/metrica-clickhouse-connection.md) %}

{% include [uploading-data-logs-api.md](../../_qa/datalens/uploading-data-logs-api.md) %}

{% include [csv-rows-display](../../_qa/datalens/csv-rows-display.md) %}

{% include [csv-long-loading](../../_qa/datalens/csv-long-loading.md) %}

{% include [csv-network-error](../../_qa/datalens/csv-network-error.md) %}

{% include [google-sheets-display-v2](../../_qa/datalens/google-sheets-v2.md) %}


{% include [google-sheets-error](../../_qa/datalens/google-sheets-error.md) %}

{% include [yadocs-error](../../_qa/datalens/yadocs-link.md) %}

### Учитываются ли таймзоны при работе с датами? {#timezone-date}

Данные о времени с указанием часового пояса {{ datalens-short-name }} запрашивает и возвращает в часовом поясе источника, само указание часового пояса при этом отбрасывается. Например, для {{ PG }} с настройкой `timezone: Europe/Berlin` все данные из колонок с типом `TIMESTAMP WITH TIME ZONE` будут выводиться в таймзоне `Europe/Berlin` независимо от часового пояса пользователя или того, с каким сдвигом они были записаны в базу.

Например:

* значение в источнике: `2025-03-31 10:00:00+01:00`;
* значение в {{ datalens-short-name }}: `2025-03-31 10:00:00`.

[Таймзона](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) учитывается при вычислениях, в т.ч. с использованием функций [преобразования типов](../function-ref/type-conversion-functions.md).

Например, для {{ PG }} с настройкой `timezone: Europe/Berlin`:

* формула `DATEPART(DATETIME(#1970-01-01 01:00:00#, 'UTC'), 'hour')` вернет значение `2`, т.к. таймзона базы (`Europe/Berlin`) сдвинута относительно указанной (`UTC`) на 1 час;
* формула `INT(DATETIME(#1970-01-01 01:00:00#, 'UTC'))` вернет значение `3600`.



{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
