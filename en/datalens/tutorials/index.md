---
title: "Scenarios for using Yandex DataLens"
description: "This section describes scenarios for using the Yandex DataLens service. Visualization of data from a CSV-file, creation and publication of a chart with a map of Moscow from a CSV-file, analysis of sales of a chain of stores from the ClickHouse database, analysis of open data on road accidents in Russia"
---

# Practical Yandex DataLens guidelines

Below is a description of guidelines for working with {{ datalens-full-name }}:

- [Visualizing data from a CSV file](data-from-csv-visualization.md)
{% if audience == "external" %}- [Creating and publishing a chart with a map of Moscow from a CSV file](data-from-csv-to-public-visualization.md){% endif %}
- [Analyzing a retail chain's sales from a ClickHouse database](data-from-ch-visualization.md)
- [Analyzing public data on road accidents in Russia](data-from-csv-geo-visualization.md)
{% if audience == "external" %}- [Analyzing sales and locations of pizzerias based on data from Clickhouse and Marketplace databases](data-from-ch-to-geolayers-visualization.md){% endif %}
{% if audience == "external" %}- [Web analytics with a connection to Yandex Metrica](data-from-metrica-visualization.md){% endif %}
{% if audience == "external" %}- [Web analytics with funnels and cohorts calculated based on Yandex Metrica data](data-from-metrica-yc-visualization.md){% endif %}
{% if audience == "external" %}- [Mobile app analytics based on AppMetrica data](data-from-appmetrica-visualization.md){% endif %}
{% if audience == "external" %}- [Analyzing Yandex Music podcast statistics (for podcasters)](data-from-podcasts.md){% endif %}
- [Visualizing data with a QL chart](data-from-ch-to-sql-chart.md)
{% if audience == "external" %}- [Building customer journey charts based on AppMetrica data](data-from-appmetrica-yc-visualization.md){% endif %}
