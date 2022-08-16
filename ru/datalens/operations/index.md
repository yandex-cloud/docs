# Пошаговые инструкции для Yandex DataLens

## Создание подключения {#creating-connection}

- [{#T}](connection/create-clickhouse.md)
{% if audience != "internal" %} - [{#T}](connection/create-csv.md) {% endif %}
{% if audience == "internal" %} - [{#T}](connection/create-file.md) {% endif %}
- [{#T}](connection/create-google-sheets.md)
- [{#T}](connection/create-mysql.md)
- [{#T}](connection/create-postgresql.md)
- [{#T}](connection/create-mssql-server.md)
- [{#T}](connection/create-oracle.md)
- [{#T}](connection/create-ydb.md)
- [{#T}](connection/create-greenplum.md)
{% if audience == "internal" %} - [{#T}](connection/create-prometheus.md) {% endif %}
{% if audience == "internal" %} - [{#T}](connection/chyt/create-chyt.md) {% endif %}
- [{#T}](connection/create-metrica-api.md)
- [{#T}](connection/create-appmetrica.md)
{% if audience != "internal" %} - [{#T}](connection/create-cloud-billing.md) {% endif %}
{% if audience != "internal" %} - [{#T}](connection/manage-access.md) {% endif %}

## Работа с датасетом {#working-with-datasets}

- [{#T}](dataset/create.md)
- [{#T}](dataset/join-data.md)
{% if audience != "internal" %} - [{#T}](dataset/join-data-csv.md) {% endif %}
- [{#T}](dataset/create-field.md)
- [{#T}](dataset/create-calculated-field.md)
- [{#T}](dataset/create-filter.md)
- [{#T}](dataset/update-field.md)
- [{#T}](dataset/add-data.md)
{% if audience != "internal" %} - [{#T}](dataset/materialize.md) {% endif %}
{% if audience != "internal" %} - [{#T}](dataset/manage-access.md) {% endif %}
- [{#T}](dataset/manage-row-level-security.md)
- [{#T}](dataset/add-parameter-dataset.md)

## Создание и настройка чартов {#creating-and-configuring-charts}

- [{#T}](chart/create-chart.md)
- [{#T}](chart/create-sql-chart.md)
- [{#T}](chart/create-multidataset-chart.md)
- [{#T}](chart/add-hierarchy.md)
- [{#T}](chart/config-chart-navigator.md)
{% if audience == "internal" %} - [{#T}](chart/create-alert.md){% endif %}
{% if audience != "internal" %} - [{#T}](chart/publish.md) {% endif %}
- [{#T}](chart/manage-access.md)
{% if audience == "internal" %} - [{#T}](chart/use-comments.md){% endif %}
{% if audience == "internal" %} - [{#T}](chart/add-parameters.md) {% endif %}
- [{#T}](chart/add-guid.md)
- [{#T}](chart/add-parameter-chart.md)
{% if audience == "internal" %} - [{#T}](chart/export-from-monitoring.md) {% endif %}
- [{#T}](chart/chart-null-settings.md)

## Работа с дашбордами {#working-with-dashboards}

- [{#T}](dashboard/create.md)
- [{#T}](dashboard/add-chart.md)
- [{#T}](dashboard/add-selector.md)
- [{#T}](dashboard/create-alias.md)
- [{#T}](dashboard/edit-alias.md)
{% if audience != "internal" %} - [{#T}](dashboard/publish.md) {% endif %}
- [{#T}](dashboard/manage-access.md)
{% if audience == "internal" %} - [{#T}](dashboard/add-parameters.md) {% endif %}
- [{#T}](dashboard/auto-update.md)

{% if audience == "external" %}

## Работа с организациями {#working-with-organizations}

- [{#T}](organizations/change-organization.md)

{% endif %}