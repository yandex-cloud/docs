---
title: "{{ datalens-full-name }} use cases"
description: "This section describes use cases for {{ datalens-full-name }}. Visualizing data from a CSV file, creating and publishing a chart with a map of Moscow from a CSV file, analyzing a store chain's sales based on data from a ClickHouse DB, and analyzing public data on road accidents in Russia"
---

# {{ datalens-name }} practical guidelines

Below is a description of guidelines for working with {{ datalens-full-name }}:

{% if audience != "internal" %}

* [Visualizing data from a CSV file](data-from-csv-visualization.md)
* [Creating and publishing a chart with a map of Moscow from a CSV file](data-from-csv-to-public-visualization.md)
* [Analyzing a retail chain's sales from a ClickHouse database](data-from-ch-visualization.md)
* [Analyzing public data on road accidents in Russia](data-from-csv-geo-visualization.md)
* [Analyzing sales and locations of pizzerias based on data from Clickhouse and Marketplace databases](data-from-ch-to-geolayers-visualization.md)
* [Web analytics with a connection to Yandex Metrica](data-from-metrica-visualization.md)
* [Web analytics with funnels and cohorts calculated based on Yandex Metrica data](data-from-metrica-yc-visualization.md)
* [Mobile app analytics based on AppMetrica data](data-from-appmetrica-visualization.md)
* [Analyzing Yandex Music podcast statistics (for podcasters)](data-from-podcasts.md)
* [Visualizing data using parameters](data-from-ch-with-parameters.md)
* [Visualizing data with a QL chart](data-from-ch-to-sql-chart.md)
* [Building customer journey charts based on AppMetrica data](data-from-appmetrica-yc-visualization.md)

{% else %}

* [Visualizing data from a CSV file](data-from-csv-visualization.md)
* [Visualizing data from ClickHouse over YT (CHYT)](data-from-ch-over-yt.md)
* [Analyzing public data on road accidents in Russia](data-from-csv-geo-visualization.md)
* [Yandex Forms data visualization](data-from-forms-visualization.md)
* [Visualizing data using parameters](data-from-ch-with-parameters.md)
* [Visualizing data with a QL chart](data-from-ch-to-sql-chart.md)

{% endif %}