#### Quotas {#datalens-quotas}

There are no quotas for {{ datalens-short-name }}.

#### General limits {#datalens-common-limits}

{% note info %}

{{ datalens-short-name }} has no limitation on the amount of data on the source you are connecting to.

{% endnote %}

{% if audience != "internal" %}

| Type of limit | Value |
----- | -----
| Number of DataLens instances per organization or cloud | 1 |
| Maximum CSV file size | 200 MB |
| Maximum number of tables in a single dataset | 32 |
| Maximum number of fields in a single dataset | 1200 |

{% else %}

| Type of limit | Value |
----- | -----
| Maximum CSV file size | 200 MB |
| Maximum amount of data received from source | 50 MB |
| Maximum number of tables in a single dataset | 32 |
| Maximum number of fields in a single dataset | 1200 |

{% endif %}

#### Chart data limits {#datalens-chart-data-limits}

Charts in {{ datalens-short-name }} can only display a limited amount of data. If the number of rows (columns and cells for pivot tables) in a dataset exceeds the established limit, no chart will be built. Therefore, to build a chart from data in a large dataset, select a part of the data to display based on the limits below using [filters](../../datalens/concepts/dataset/settings.md#default-setting):

| Chart type | Limit |
----- | -----
| **Charts** |
| Line chart | 75000 rows |
| Stacked area chart<br/>Normalized area chart | 75000 rows |
| Column chart<br/>Normalized column chart | 75000 rows |
| Bar chart<br/>Normalized bar chart | 75000 rows |
| Scatter chart | 75000 rows |
| Pie chart | 1000 rows |
| Tree chart | 1000 rows |
| **Tables** |
| Table | 100000 rows |
| Pivot table | 100000 cells |
| Pivot table | 800 columns |
| **Geomaps** |
| Point map | 40000 rows |
| Point map with clusters | 40000 points |
| Background map | 40000 rows |
| Heat map | 40000 rows |
| Polyline map | 40000 rows |
