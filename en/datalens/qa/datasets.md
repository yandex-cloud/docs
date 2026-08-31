---
title: FAQ about datasets
description: This page covers FAQ about datasets.
---

# Datasets

{% include [how-to-change-source-data](../../_qa/datalens/change-source-data.md) %}


{% include [incorrectly-identified-date-field](../../_qa/datalens/incorrectly-identified-date-field.md) %}

{% include [how-to-link-two-tables](../../_qa/datalens/linking-two-tables.md) %}

{% include [add-line-numeration](../../_qa/datalens/add-line-numeration.md) %}

{% include [unix-time](../../_qa/datalens/unix-time.md) %}

{% include [add-sql](../../_qa/datalens/add-sql.md) %}

{% include [make-geocode](../../_qa/datalens/make-geocode.md) %}

{% include [get-geo](../../_qa/datalens/get-geo.md) %}

{% include [qa-materialization-error](../../_qa/datalens/where-is-materialization.md) %}



### Can I join multiple Yandex Documents tables into one? {#how-to-join-tables}

You can join multiple [Yandex Documents](../operations/connection/create-yadocs.md) tables by configuring [links](../dataset/create-dataset.md#links) between them. You can join multiple tables into one using the `UNION` operator in an SQL query. However, SQL queries are only available for databases as data sources.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
