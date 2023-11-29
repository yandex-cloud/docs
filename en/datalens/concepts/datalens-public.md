# Public access

You can grant public access to charts and dashboards you create: any user can view published objects without authorization. However, the user cannot view chart settings, connections, or the dataset, or execute an ad-hoc SQL query.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Publishing rules {#rules}

To publish a chart or dashboard, grant permissions to publish related datasets and connections. To do this, you need to have `{{ permission-admin }}` permission to these objects.

To protect the data, we recommend that you only grant the user rights to view those tables that are used to build the dataset when connecting to a database.

We also recommend minimizing the data in a dataset and adding only the required filters to the dashboard. You can download data on a public dashboard in a machine-readable format.

Before publishing data, make sure that:

* Your charts and dashboards don't contain any personal data or trade secrets. Access to published data is not restricted.
* You can't publish dashboards and charts built on the [Yandex Metrica API](../operations/connection/create-metrica-api.md) and [AppMetrica](../operations/connection/create-appmetrica.md), but you can [share](#metrica-share) them.
* You have administrator rights to published charts and dashboards, as well as related objects.

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

You can embed published dashboards and charts into a website or app using an `iframe`. You can also pass a parameter to specify the object design:

* `_theme=light`: Use the light theme for the object.
* `_theme=dark`: Use the dark theme for the object.

The parameter is added to the URL following the question mark `?`.
For example:

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
