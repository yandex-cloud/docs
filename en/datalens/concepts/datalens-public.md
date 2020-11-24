# DataLens Public

With {{ datalens-public }}, you can grant public access to created charts and dashboards: any user can view published objects without authorization.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Publishing rules {#rules}

To publish a chart or dashboard, make sure you meet the following conditions:

- [Materializing a dataset](../operations/dataset/materialize.md). After the materialization, {{datalens-short-name}} has guaranteed access to data. 

    {% include [datalens-materialization](../../_includes/datalens/datalens-materialization.md) %}

- Grant permissions to publish related datasets and connections. To do this, you need to have `{{ permission-admin }}` permission to these objects.

## Embedding public charts {#embedded-public-chart}

You can embed the published charts into a website or app using the `iframe` element.

Before adding a chart to the `iframe`, add the `_embedded=1` parameter to the chart URL.
The parameter is added to the URL following the question mark (`?`).
For example:

```
<iframe src="https://datalens.yandex/oxxbqilhotpgk?_embedded=1"></iframe>
```

You can also pass a parameter to specify the chart design:

* `_theme=light`: Use the light theme for the chart.
* `_theme=dark`: Use the dark theme for the chart.

To pass more than one parameter, use the ampersand (`&`) between them.
For example:

```
<iframe src="https://datalens.yandex/oxxbqilhotpgk?_embedded=1&_theme=dark"></iframe>
```

## How to publish an object {#how-to-publish}

You can grant public access to a dashboard or chart.

{% list tabs %}

- Dashboards

  {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Charts

  {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}

