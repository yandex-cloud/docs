# Пошаговые инструкции для Yandex DataLens

## Создание подключения {#creating-connection}

- [{#T}](connection/create-clickhouse.md)
- [{#T}](connection/create-csv.md)
- [{#T}](connection/create-google-sheets.md)
- [{#T}](connection/create-mysql.md)
- [{#T}](connection/create-postgresql.md)
- [{#T}](connection/create-mssql-server.md)
- [{#T}](connection/create-oracle.md)
- [{#T}](connection/create-ydb.md)
- [{#T}](connection/create-greenplum.md)
{% if audience == "internal" %} - [{#T}](connection/chyt/create-chyt.md) {% endif %}
- [{#T}](connection/create-metrica-api.md)
- [{#T}](connection/create-appmetrica.md)
{% if audience != "internal" %} - [{#T}](connection/create-cloud-billing.md) {% endif %}
{% if audience != "internal" %} - [{#T}](connection/manage-access.md) {% endif %}

## Работа с датасетом {#working-with-datasets}

- [{#T}](dataset/create.md)
- [{#T}](dataset/join-data.md)
- [{#T}](dataset/join-data-csv.md)
- [{#T}](dataset/create-field.md)
- [{#T}](dataset/create-calculated-field.md)
- [{#T}](dataset/create-filter.md)
- [{#T}](dataset/update-field.md)
- [{#T}](dataset/add-data.md)
- [{#T}](dataset/materialize.md)
{% if audience != "internal" %} - [{#T}](dataset/manage-access.md) {% endif %}
- [{#T}](dataset/manage-row-level-security.md)

## Создание и настройка чартов {#creating-and-configuring-charts}

- [{#T}](chart/create-line-chart.md)
- [{#T}](chart/create-column-chart.md)
- [{#T}](chart/create-area-chart.md)
- [{#T}](chart/create-pie-chart.md)
- [{#T}](chart/create-ring-chart.md)
- [{#T}](chart/create-bar-chart.md)
- [{#T}](chart/create-scatter-chart.md)
- [{#T}](chart/create-map-chart.md)
- [{#T}](chart/create-table.md)
- [{#T}](chart/create-pivot-table.md)
- [{#T}](chart/create-indicator-chart.md)
- [{#T}](chart/create-tree-chart.md)
- [{#T}](chart/create-sql-chart.md)
- [{#T}](chart/create-multidataset-chart.md)
- [{#T}](chart/add-hierarchy.md)
- [{#T}](chart/config-chart-navigator.md)
{% if audience == "internal" %} - [{#T}](chart/create-alert.md){% endif %}
{% if audience != "internal" %} - [{#T}](chart/publish.md) {% endif %}
- [{#T}](chart/manage-access.md)
{% if audience == "internal" %} - [{#T}](chart/add-parameters.md) {% endif %}
- [{#T}](chart/add-guid.md)

## Работа с дашбордами {#working-with-dashboards}

- [{#T}](dashboard/create.md)
- [{#T}](dashboard/add-chart.md)
- [{#T}](dashboard/add-selector.md)
- [{#T}](dashboard/create-alias.md)
- [{#T}](dashboard/edit-alias.md)
{% if audience != "internal" %} - [{#T}](dashboard/publish.md) {% endif %}
- [{#T}](dashboard/manage-access.md)
{% if audience == "internal" %} - [{#T}](dashboard/add-parameters.md) {% endif %}
