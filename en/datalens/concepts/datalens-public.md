# DataLens Public

With {{ datalens-public }}, you can grant public access to created charts and dashboards: any user can view published objects without authorization.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Publishing rules {#rules}

To publish a chart or dashboard, make sure you meet the following conditions:

- [Materializing a dataset](../operations/dataset/materialize.md). After the materialization, {{datalens-short-name}} has guaranteed access to data.
- Grant permissions to publish related datasets and connections. To do this, you need to have `{{ permission-admin }}` permission to these objects.

## How to publish an object {#how-to-publish}

You can grant public access to a dashboard or chart.

{% list tabs %}

- Dashboards

  {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Charts

  {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}

