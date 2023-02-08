# DataLens Public

With {{ datalens-public }}, you can grant public access to charts and dashboards: any user can view published objects without authorization. However, the user cannot view chart settings, connections, or the dataset, or execute an ad-hoc SQL query.

Sample public dashboards and charts can be found in [{#T}](../public-talks/public-dashboards-and-charts.md).

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Publishing rules {#rules}

To publish a chart or dashboard, grant permissions to publish related datasets and connections. To do this, you need to have `{{ permission-admin }}` permission to these objects.

To protect the data, we recommend that you only grant the user rights to view those tables that are used to build the dataset when connecting to a database.

We also recommend minimizing the data in a dataset and adding only the required filters to the dashboard. You can download data on a public dashboard in a machine-readable format.

## Publishing an object {#how-to-publish}

You can grant public access to a dashboard or chart.

{% list tabs %}

- Dashboards

  {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

  To share a dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

  {% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

- Charts

  {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

  To share a chart containing Yandex Metrica or AppMetrica data, use one of the following methods:

  {% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

{% endlist %}

## Embedding public objects {#embedded-public-chart}

You can embed published dashboards and charts into a website or app using an `iframe`. You can also pass a parameter to specify the object design:

* `_theme=light`: Use the light theme for the object.
* `_theme=dark`: Use the dark theme for the object.

The parameter is added to the URL following the question mark `?`.
For example:

```
<iframe src="https://datalens.yandex/oxxbqilhotpgk?_theme=dark"></iframe>
```

You can apply filtering to embedded charts. To do this, pass the filter parameter in the chart link.
To set the filter parameter:

1. Add the chart and selectors to the dashboard.
1. [Publish](#how-to-publish) the dashboard.
1. Select the desired selector.
1. Proceed to edit the chart on the dashboard. Click ![image](../../_assets/datalens/horizontal-ellipsis-black.svg) and select **Embed code**.

The filter parameter is added to the chart URL following the question mark `?`. To pass multiple parameters (for example, to set up the theme), use the ampersand `&` between them.

```
<iframe src="https://datalens.yandex/oxxbqilhotpgk?e16d1014-7135-4af5-9169-1b8ab88bdb4e=East&_theme=dark"></iframe>
```


