# Public access

You can grant public access to charts and dashboards you create, so that any user could view published objects without logging in. However, the user will not be able to view chart settings, connections, or the dataset, or run an SQL query.

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

{% list tabs %}

- Dashboards

   {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Charts

   {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}

## Sharing a chart based on Yandex Metrica or AppMetrica data {#metrica-share}

To share a chart or dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

## Embedding public objects {#embedded-public-chart}

You can [embed](../dashboard/embedded-objects.md) published dashboards and charts into a website or app using an `iframe`.

### Getting the embed code {#get-code}

To get the embed code with a preset dashboard or chart design:

1. [Publish](#how-to-publish) your dashboard or chart.
1. Open the dashboard or chart using the public link provided to you.
1. Click ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) in the top-right corner and select ![image](../../_assets/console-icons/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design parameters.

### Filtering embedded charts {#filtering-embedded-charts}

You can apply filtering to embedded charts. To do this, provide the filtering parameters in the chart link.

To set up filtering:

1. Add a chart and selector to the dashboard.
1. [Publish](#how-to-publish) the dashboard.
1. Set the required selector values.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the chart on the dashboard and select ![image](../../_assets/console-icons/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design and filter parameters.

The filter parameters will be added to the chart URL after `?`. When providing multiple parameters, they will be separated by `&` (ampersand).

```
<iframe frameborder="0" src="https://datalens.yandex/z2uxl5pbztkep?shopid_vj2j=sp-15&shopid_vj2j=sp-18&shopid_vj2j=sp-20&_embedded=1&_no_controls=1&_theme=light&_lang=ru" width="100%" height="400px"></iframe>
```

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
