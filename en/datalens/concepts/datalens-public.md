# Public access

You can grant public access to charts and dashboards you create: any user can view published objects without authorization. However, the user cannot view chart settings, connections, or the dataset, or execute an ad-hoc SQL query.

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

## Share a chart based on Yandex Metrica or AppMetrica data {#metrica-share}

To share a chart or dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

## Embedding public objects {#embedded-public-chart}

You can embed published dashboards and charts into a website or app using an `iframe`. You can also provide the object's format parameter:

* `_theme=light`: Use the light theme for the object.
* `_theme=dark`: Use the dark theme for the object.

The parameter is added to the URL following the question mark `?`.
Here is an example:

```
<iframe frameborder="0" src="https://datalens.yandex/bdzixmpsae3o2?_embedded=1&_no_controls=1&_lang=ru&_theme=dark"></iframe>
```

### Getting the embed code {#get-code}

To get the embed code with a preset dashboard or chart design:

1. [Publish](#how-to-publish) your dashboard or chart.
1. Open the dashboard or chart using the public link provided to you.
1. Click ![image](../../_assets/datalens/arrow-up-right.svg) in the top-right corner and select ![image](../../_assets/datalens/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design parameters.

### Filtering embedded charts {#filtering-embedded-charts}

You can apply filtering to embedded charts. To do this, provide the filtering parameters in the chart link.
To set up filtering:

1. Add a chart and selector to the dashboard.
1. [Publish](#how-to-publish) the dashboard.
1. Set the required selector values.
1. Click ![image](../../_assets/datalens/horizontal-ellipsis-black.svg) next to the chart on the dashboard and select ![image](../../_assets/datalens/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design and filter parameters.

The filter parameters will be added to the chart URL following the question mark (`?`). If multiple parameters are provided, they will be separated by the ampersand character (`&`).

```
<iframe frameborder="0" src="https://datalens.yandex/z2uxl5pbztkep?shopid_vj2j=sp-15&shopid_vj2j=sp-18&shopid_vj2j=sp-20&_embedded=1&_no_controls=1&_theme=light&_lang=ru" width="100%" height="400px"></iframe>
```

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}