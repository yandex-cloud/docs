# Public access

You can make the charts and dashboards you create public, so any user can follow a link and view the object you published without logging in. However, the user will not be able to view chart settings, connections, or the dataset, or run an SQL query.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Publishing rules {#rules}

Before publishing data, make sure that:

* You have the `{{ permission-admin }}` permission to published charts, dashboards, and related objects.
* Your charts and dashboards do not contain any personal data or trade secrets. Access to published data is not restricted.
* The connection your objects run on top of supports data publication. You cannot publish data from the following connections:

   * [Google BigQuery](../operations/connection/create-big-query.md)
   * [Snowflake](../operations/connection/create-snowflake.md)
   * [Metrica](../operations/connection/create-metrica-api.md)
   * [AppMetrica](../operations/connection/create-appmetrica.md)

      {% note info %}

      You can [share](#metrica-share) a dashboard or chart based on Yandex Metrica or AppMetrica data.

      {% endnote %}

To secure your published data:

* Grant the user permission to view only the tables that are used to build a dataset when connecting to a database.
* Minimize the data in a dataset and only add the required filters to your dashboard. You can download data on a public dashboard in a machine-readable format.

## Publishing an object {#how-to-publish}

{% list tabs group=datalens_public %}

- Publishing a dashboard {#dashboard}

   {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Publishing a chart {#chart}

   {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}

## Sharing a chart based on Yandex Metrica or AppMetrica data {#metrica-share}

To share a chart or dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

#### See also: {#see-also}

* [{#T}](../security/embedded-objects.md)