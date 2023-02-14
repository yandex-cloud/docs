# Step-by-step instructions for {{ datalens-full-name }}

## Creating a connection {#creating-connection}

- [{#T}](connection/create-clickhouse.md)
{% if product == "yandex-cloud" %}- [{#T}](connection/create-file.md){% endif %}
{% if product == "yandex-cloud" %}- [{#T}](connection/create-google-sheets.md){% endif %}
- [{#T}](connection/create-mysql.md)
- [{#T}](connection/create-postgresql.md)
- [{#T}](connection/create-mssql-server.md)
{% if audience == "external" %}- [{#T}](connection/create-big-query.md){% endif %}
{% if product == "yandex-cloud" %}- [{#T}](connection/create-oracle.md){% endif %}
{% if product == "yandex-cloud" %}- [{#T}](connection/create-ydb.md){% endif %}
{% if product == "yandex-cloud" %}- [{#T}](connection/create-greenplum.md){% endif %}
{% if product == "yandex-cloud" %}- [{#T}](connection/create-prometheus.md) {% endif %}
{% if audience == "internal" %}- [{#T}](connection/chyt/create-chyt.md) {% endif %}
{% if product == "yandex-cloud" %}- [{#T}](connection/create-metrica-api.md){% endif %}
{% if product == "yandex-cloud" %}- [{#T}](connection/create-appmetrica.md){% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}- [{#T}](connection/create-cloud-billing.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}- [{#T}](connection/create-monitoring.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}- [{#T}](connection/create-bitrix24.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}- [{#T}](connection/manage-access.md){% endif %}{% endif %}

## Working with a dataset {#working-with-datasets}

- [{#T}](dataset/create.md)
- [{#T}](dataset/join-data.md)
- [{#T}](dataset/create-field.md)
- [{#T}](dataset/create-calculated-field.md)
- [{#T}](dataset/create-filter.md)
- [{#T}](dataset/update-field.md)
- [{#T}](dataset/add-data.md)
{% if product == "yandex-cloud" %}{% if audience != "internal" %} - [{#T}](dataset/manage-access.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}- [{#T}](dataset/manage-row-level-security.md){% endif %}
- [{#T}](dataset/add-parameter-dataset.md)

## Creating and configuring charts {#creating-and-configuring-charts}

- [{#T}](chart/create-chart.md)
- [{#T}](chart/create-sql-chart.md)
- [{#T}](chart/create-multidataset-chart.md)
- [{#T}](chart/add-hierarchy.md)
- [{#T}](chart/config-chart-navigator.md)
{% if audience == "internal" %} - [{#T}](chart/create-alert.md){% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}- [{#T}](chart/publish.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}- [{#T}](chart/manage-access.md){% endif %}
{% if audience == "internal" %} - [{#T}](chart/use-comments.md){% endif %}
{% if audience == "internal" %} - [{#T}](chart/add-parameters.md) {% endif %}
- [{#T}](chart/add-guid.md)
- [{#T}](chart/add-parameter-chart.md)
{% if audience == "internal" %} - [{#T}](chart/export-from-monitoring.md) {% endif %}
- [{#T}](chart/chart-null-settings.md)

## Working with dashboards {#working-with-dashboards}

- [{#T}](dashboard/create.md)
- [{#T}](dashboard/add-chart.md)
- [{#T}](dashboard/add-selector.md)
- [{#T}](dashboard/create-alias.md)
- [{#T}](dashboard/edit-alias.md)
{% if product == "yandex-cloud" %}{% if audience != "internal" %}- [{#T}](dashboard/publish.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}- [{#T}](dashboard/manage-access.md){% endif %}
{% if audience == "internal" %} - [{#T}](dashboard/add-parameters.md) {% endif %}
{% if product == "yandex-cloud" %}- [{#T}](dashboard/auto-update.md){% endif %}

{% if product == "yandex-cloud" %}

{% if audience == "external" %}

## Working with organizations {#working-with-organizations}

- [{#T}](organizations/change-organization.md)

{% endif %}

{% endif %}