---
title: Connections
description: This page covers FAQ about connections.
---

# Connections

{% include [postgre-type.md](../../_qa/datalens/postgre-type.md) %}


{% include [metrica-clickhouse-connection](../../_qa/datalens/metrica-clickhouse-connection.md) %}

{% include [uploading-data-logs-api.md](../../_qa/datalens/uploading-data-logs-api.md) %}

{% include [csv-rows-display](../../_qa/datalens/csv-rows-display.md) %}

{% include [csv-long-loading](../../_qa/datalens/csv-long-loading.md) %}

{% include [csv-network-error](../../_qa/datalens/csv-network-error.md) %}


{% include [google-sheets-error](../../_qa/datalens/google-sheets-error.md) %}

{% include [yadocs-error](../../_qa/datalens/yadocs-link.md) %}

### Are time zones taken into account when working with dates? {#timezone-date}

{{ datalens-short-name }} requests and returns time data using the time zone of the source but discards the actual time zone notation. For example, for {{ PG }} with the `timezone: Europe/Berlin` setting, all data from the `TIMESTAMP WITH TIME ZONE` type columns will have the `Europe/Berlin` time zone, regardless of the user's time zone or the shift used to write this data to the database.

Here is an example:

* Value in the source: `2025-03-31 10:00:00+01:00`
* Value in {{ datalens-short-name }}: `2025-03-31 10:00:00`

[Time zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) is factored into the calculations, including if [type conversion](../function-ref/type-conversion-functions.md) functions are used.

For example, for {{ PG }} with the `timezone: Europe/Berlin` setting:

* The `DATEPART(DATETIME(#1970-01-01 01:00:00#, 'UTC'), 'hour')` formula will return `2` because the database time zone (`Europe/Berlin`) is shifted 1 hour relative to the specified one (`UTC`).
* The `INT(DATETIME(#1970-01-01 01:00:00#, 'UTC'))` formula will return `3600`.


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
